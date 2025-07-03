% Full path to the mfc_paths.scp file
scp_file_path = 'C:\Users\root\Desktop\htk-3.2.1\mfc_paths.scp';

% Read the mfc_paths.scp file
mfc_paths = fileread(scp_file_path); % Read the SCP file content as text
mfc_paths = strsplit(mfc_paths, newline); % Split into lines

% Output folder for the generated .scp files
output_folder = 'C:\Users\root\Desktop\htk-3.2.1'; % Folder where files will be saved

% Manual configuration of subjects and files
% %TEST 
output_files = {

    'F01_FC01', {'F01', 'FC01'};
    'F01_FC02', {'F01', 'FC02'};
    'F01_FC03', {'F01', 'FC03'};
    'F01_MC01', {'F01', 'MC01'};
    'F01_MC02', {'F01', 'MC02'};
    'F01_MC03', {'F01', 'MC03'};
    'F01_MC04', {'F01', 'MC04'};
    'F03_FC01', {'F03', 'FC01'};
    'F03_FC02', {'F03', 'FC02'};
    'F03_FC03', {'F03', 'FC03'};
    'F03_MC01', {'F03', 'MC01'};
    'F03_MC02', {'F03', 'MC02'};
    'F03_MC03', {'F03', 'MC03'};
    'F03_MC04', {'F03', 'MC04'};
    'F04_FC01', {'F04', 'FC01'};
    'F04_FC02', {'F04', 'FC02'};
    'F04_FC03', {'F04', 'FC03'};
    'F04_MC01', {'F04', 'MC01'};
    'F04_MC02', {'F04', 'MC02'};
    'F04_MC03', {'F04', 'MC03'};
    'F04_MC04', {'F04', 'MC04'};
    'M01_FC01', {'M01', 'FC01'};
    'M01_FC02', {'M01', 'FC02'};
    'M01_FC03', {'M01', 'FC03'};
    'M01_MC01', {'M01', 'MC01'};
    'M01_MC02', {'M01', 'MC02'};
    'M01_MC03', {'M01', 'MC03'};
    'M01_MC04', {'M01', 'MC04'};
    'M02_FC01', {'M02', 'FC01'};
    'M02_FC02', {'M02', 'FC02'};
    'M02_FC03', {'M02', 'FC03'};
    'M02_MC01', {'M02', 'MC01'};
    'M02_MC02', {'M02', 'MC02'};
    'M02_MC03', {'M02', 'MC03'};
    'M02_MC04', {'M02', 'MC04'};
    'M03_FC01', {'M03', 'FC01'};
    'M03_FC02', {'M03', 'FC02'};
    'M03_FC03', {'M03', 'FC03'};
    'M03_MC01', {'M03', 'MC01'};
    'M03_MC02', {'M03', 'MC02'};
    'M03_MC03', {'M03', 'MC03'};
    'M03_MC04', {'M03', 'MC04'};
    'M04_FC01', {'M04', 'FC01'};
    'M04_FC02', {'M04', 'FC02'};
    'M04_FC03', {'M04', 'FC03'};
    'M04_MC01', {'M04', 'MC01'};
    'M04_MC02', {'M04', 'MC02'};
    'M04_MC03', {'M04', 'MC03'};
    'M04_MC04', {'M04', 'MC04'};
    'M05_FC01', {'M05', 'FC01'};
    'M05_FC02', {'M05', 'FC02'};
    'M05_FC03', {'M05', 'FC03'};
    'M05_MC01', {'M05', 'MC01'};
    'M05_MC02', {'M05', 'MC02'};
    'M05_MC03', {'M05', 'MC03'};
    'M05_MC04', {'M05', 'MC04'};
};

% Generate .scp files
for i = 1:size(output_files, 1)
    % Full path of the output file
    %TEST ->   
    output_file_name = fullfile(output_folder, strcat('test_', output_files{i, 1}, '.scp'));
    
    % Subjects to search for in the paths
    subjects_to_search = output_files{i, 2};
    
    % Filter paths containing the search terms
    filtered_paths = {}; % Initialize as cell
    for j = 1:numel(subjects_to_search)
        search_term = subjects_to_search{j};
        matching_paths = mfc_paths(contains(mfc_paths, search_term)); % Filter paths containing the term
        filtered_paths = [filtered_paths; matching_paths(:)]; % Concatenate as cell array
    end
    
    % Remove duplicates in the filtered paths
    filtered_paths = unique(filtered_paths, 'stable'); % Remove duplicates and keep order
    
    % Save to the .scp file
    fid = fopen(output_file_name, 'w');
    if fid == -1
        error('Could not open file %s for writing.', output_file_name);
    end
    fprintf(fid, '%s\n', filtered_paths{:});
    fclose(fid);
    
    fprintf('File %s generated with %d paths.\n', output_file_name, numel(filtered_paths));
end

disp('All .scp files have been generated successfully.');
