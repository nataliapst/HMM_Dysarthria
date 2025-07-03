% Lists of X and Y
X_values = {'F01', 'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05'};
Y_values = {'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};

% Base directory
base_dir = 'C:\Users\root\Desktop\htk-3.2.1';

% Iterate over all combinations of X and Y
for i = 1:length(X_values)
    for j = 1:length(Y_values)
        X = X_values{i};
        Y = Y_values{j};
        
        % Define specific paths for this combination
        train_dir = fullfile(base_dir, ['train_', X, '_', Y, '\hmm0']);
        proto_file = fullfile(train_dir, 'proto');
        vFloor_file = fullfile(train_dir, 'vFloors');
        hmmdefs_file = fullfile(train_dir, 'hmmdefs');
        macro_file = fullfile(train_dir, 'macro');
        
        % Check if proto and vFloors files exist
        if ~isfile(proto_file)
            warning('Proto file not found: %s. This combination will be skipped.', proto_file);
            continue;
        end
        if ~isfile(vFloor_file)
            warning('vFloors file not found: %s. This combination will be skipped.', vFloor_file);
            continue;
        end
        
        % Read the entire content of the proto file
        proto_content = fileread(proto_file);
        proto_lines = strsplit(proto_content, '\n'); % Split into lines
        
        % Ensure the copied lines have the correct format
        for k = 1:3
            if contains(proto_lines{k}, '<MFCC_D_A_0>')
                proto_lines{k} = strrep(proto_lines{k}, '<MFCC_D_A_0>', '<MFCC_0_D_A>');
            end
        end
        
        % Generate the hmmdefs file
        hmmdefs_fid = fopen(hmmdefs_file, 'w');
        if hmmdefs_fid == -1
            error('Could not open hmmdefs file for writing: %s', hmmdefs_file);
        end
        
        % Create HMM definitions
        proto_body = proto_lines(4:end); % Remove the first three lines
        proto_body_content = strjoin(proto_body, '\n');
        
        dysarthria_hmm = strrep(proto_body_content, '~h "proto"', '~h "Dysarthria"');
        no_dysarthria_hmm = strrep(proto_body_content, '~h "proto"', '~h "No_Dysarthria"');
        
        % Write the definitions into hmmdefs
        fprintf(hmmdefs_fid, '%s', dysarthria_hmm);
        fprintf(hmmdefs_fid, '%s', no_dysarthria_hmm);
        fclose(hmmdefs_fid);
        
        % Generate the macro file
        macro_fid = fopen(macro_file, 'w');
        if macro_fid == -1
            error('Could not open macro file for writing: %s', macro_file);
        end
        
        % Write the first three lines from proto into macro
        for k = 1:3
            fprintf(macro_fid, '%s\n', proto_lines{k});
        end
        
        % Read the full content of vFloors
        vFloor_content = fileread(vFloor_file);
        
        % Find the position of the line "<Variance> 39" to process only the numbers after it
        header_position = strfind(vFloor_content, '<Variance> 39');
        if isempty(header_position)
            error('Line "<Variance> 39" not found in vFloors file: %s', vFloor_file);
        end
        
        % Extract only the content after the header
        numeric_content = vFloor_content(header_position + length('<Variance> 39'):end);
        numeric_values = strsplit(strtrim(numeric_content)); % Split into individual numbers
        
        % Write the header line <Variance> with "39"
        fprintf(macro_fid, '~v varFloor1 <Variance> 39\n');
        
        % Write the numbers formatted in lines of three
        num_per_line = 3; % Number of values per line
        for k = 1:num_per_line:length(numeric_values)
            fprintf(macro_fid, '%s\n', strjoin(numeric_values(k:min(k+num_per_line-1, end)), ' '));
        end
        
        fclose(macro_fid);
        
        % Success message
        fprintf('hmmdefs and macro files successfully generated for %s and %s.\n', X, Y);
    end
end

disp('Process completed for all combinations.');
