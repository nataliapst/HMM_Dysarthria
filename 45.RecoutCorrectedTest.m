% Define subjects with dysarthria and without dysarthria
dysarthria = {'F01','F03', 'F04', 'M01', 'M02', 'M03', 'M04','M05'};
no_dysarthria = {'FC01','FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};

% Base path
base_path = 'C:\Users\root\Desktop\htk-3.2.1\';

% Iterate over all combinations of subjects with and without dysarthria
for i = 1:length(dysarthria)
    for j = 1:length(no_dysarthria)
        
        % Current subject names
        dysarthria_subject = dysarthria{i};
        no_dysarthria_subject = no_dysarthria{j};
        
        % Find all recout files matching the corresponding pattern
        file_pattern = fullfile(base_path, ['recout_' dysarthria_subject '_' no_dysarthria_subject '_TEST.mlf']);
        recout_files = dir(file_pattern);
        
        % Process each found file
        for f = 1:length(recout_files)
            % Get full name of the current file
            recout_file = fullfile(recout_files(f).folder, recout_files(f).name);
            corrected_recout_file = strrep(recout_file, '.mlf', '_corrected.mlf');
            
            % Development files names
            test_file = fullfile(base_path, ['test_' dysarthria_subject '_' no_dysarthria_subject '.mlf']);
            
            % Read the development file
            dev_fid = fopen(test_file, 'r');
            if dev_fid == -1
                fprintf('Could not open file %s\n', test_file);
                continue;
            end
            dev_content = textscan(dev_fid, '%s', 'Delimiter', '\n');
            fclose(dev_fid);
            
            % Extract .lab paths in development and change extension to .rec
            dev_lines = dev_content{1};
            rec_paths = strrep(dev_lines(contains(dev_lines, '.lab')), '.lab', '.rec');
            
            % Read the recout file
            recout_fid = fopen(recout_file, 'r');
            if recout_fid == -1
                fprintf('Could not open file %s\n', recout_file);
                continue;
            end
            recout_content = textscan(recout_fid, '%s', 'Delimiter', '\n');
            fclose(recout_fid);
            
            % Write the corrected recout file
            corrected_fid = fopen(corrected_recout_file, 'w');
            fprintf(corrected_fid, '%s\n', recout_content{1}{1}); % Header #!MLF!#
            
            % Replace the recout paths with the modified development paths
            rec_index = 1;
            for k = 2:length(recout_content{1})
                line = recout_content{1}{k};
                if contains(line, '.rec') && rec_index <= length(rec_paths)
                    fprintf(corrected_fid, '%s\n', rec_paths{rec_index});
                    rec_index = rec_index + 1;
                else
                    fprintf(corrected_fid, '%s\n', line);
                end
            end
            fclose(corrected_fid);
            
            fprintf('Corrected file saved: %s\n', corrected_recout_file);
        end
    end
end
