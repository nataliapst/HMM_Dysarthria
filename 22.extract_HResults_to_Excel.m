% === CONFIGURE YOUR FOLDER AND FILES HERE ===
folder = 'C:\Users\root\Desktop';  % folder where the .txt files are located
excel_file = 'C:\Users\root\Desktop\RESULT_CORREGIDO2.xlsx';  % destination Excel file
sheet_name = 'HTK_Results';  % Excel sheet where data will be saved

txt_files = { ...
    'HResultF01.txt', ...
    'HResultF03.txt', ...
    'HResultF04.txt', ...
    'HResultM01.txt', ...
    'HResultM02.txt', ...
    'HResultM03.txt', ...
    'HResultM04.txt', ...
    'HResultM05.txt' ...
};

% === Create an empty table with headers ===
gaussians = 1:40;
n_gauss = numel(gaussians);
columns = strcat("Var", string(gaussians));
table_data = cell2table(cell(0, n_gauss), 'VariableNames', columns);
table_data.Properties.RowNames = {};

% === Add Speaker row (number of Gaussians) ===
speaker_row = array2table(gaussians, 'VariableNames', columns);
speaker_row.Properties.RowNames = {'Speaker'};
table_data = [speaker_row; table_data];

% === PROCESS ALL TXT FILES ===
for f = 1:length(txt_files)
    txt_file = fullfile(folder, txt_files{f});
    fprintf('Processing: %s\n', txt_file);

    fid = fopen(txt_file, 'r');
    if fid == -1
        warning('Could not open: %s', txt_file);
        continue;
    end

    line = fgetl(fid);
    row_name = ''; gauss = NaN;

    while ischar(line)
        % Look for combination and number of Gaussians
        recinfo = regexp(line, 'recout_([FM]\d{2}_[FM]C\d{2})_(\d+)_corrected\.mlf', 'tokens');
        if ~isempty(recinfo)
            row_name = recinfo{1}{1};
            gauss = str2double(recinfo{1}{2});
        end

        % Look for %Correct value
        corinfo = regexp(line, '%Correct=([\d.]+)', 'tokens');
        if ~isempty(corinfo) && ~isempty(row_name) && ~isnan(gauss)
            value = str2double(corinfo{1}{1});
            column_name = sprintf('Var%d', gauss);

            % If the row does not exist, add it
            if ~any(strcmp(table_data.Properties.RowNames, row_name))
                new_row = array2table(nan(1, n_gauss), 'VariableNames', columns);
                new_row.Properties.RowNames = {row_name};
                table_data = [table_data; new_row];
            end

            % Save the value in its position
            table_data{row_name, column_name} = value;

            row_name = ''; gauss = NaN;
        end

        line = fgetl(fid);
    end
    fclose(fid);
end

% === SAVE RESULT TO EXCEL ===
writetable(table_data, excel_file, 'WriteRowNames', true, 'Sheet', sheet_name);
disp('Results successfully added to the Excel file!');

