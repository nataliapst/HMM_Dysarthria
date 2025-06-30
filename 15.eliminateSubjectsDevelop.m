% Full path to the mfc_paths.scp file
scp_file_path = 'C:\Users\root\Desktop\htk-3.2.1\mfc_paths.scp';

% Read the mfc_paths.scp file
mfc_paths = fileread(scp_file_path); % Read the content of the SCP file as text
mfc_paths = strsplit(mfc_paths, newline); % Split into lines

% Output folder for the generated .scp files
output_folder = 'C:\Users\root\Desktop\htk-3.2.1'; % Folder where the files will be saved


%DEVELOP
% DEVELOPMENT
output_files = {
    'F01_FC01', {'F03', 'M01', 'FC02', 'MC01'};
    'F01_FC02', {'F04', 'M02', 'FC01', 'MC02'};
    'F01_FC03', {'F03', 'M03', 'FC02', 'MC03'};
    'F01_MC01', {'F04', 'M04', 'FC03', 'MC04'};
    'F01_MC02', {'F03', 'M05', 'FC01', 'MC01'};
    'F01_MC03', {'F04', 'M01', 'FC03', 'MC02'};
    'F01_MC04', {'F03', 'M02', 'FC01', 'MC03'};
    'F03_FC01', {'F01', 'M01', 'FC02', 'MC01'};
    'F03_FC02', {'F04', 'M02', 'FC01', 'MC02'};
    'F03_FC03', {'F01', 'M03', 'FC02', 'MC03'};
    'F03_MC01', {'F04', 'M04', 'FC03', 'MC04'};
    'F03_MC02', {'F01', 'M05', 'FC01', 'MC01'};
    'F03_MC03', {'F04', 'M01', 'FC03', 'MC02'};
    'F03_MC04', {'F01', 'M02', 'FC01', 'MC03'};
    'F04_FC01', {'F01', 'M01', 'FC02', 'MC01'};
    'F04_FC02', {'F03', 'M02', 'FC01', 'MC02'};
    'F04_FC03', {'F01', 'M03', 'FC02', 'MC03'};
    'F04_MC01', {'F03', 'M04', 'FC03', 'MC04'};
    'F04_MC02', {'F01', 'M05', 'FC01', 'MC01'};
    'F04_MC03', {'F03', 'M01', 'FC03', 'MC02'};
    'F04_MC04', {'F01', 'M02', 'FC01', 'MC03'};
    'M01_FC01', {'F01', 'M02', 'FC02', 'MC01'};
    'M01_FC02', {'F03', 'M03', 'FC03', 'MC02'};
    'M01_FC03', {'F04', 'M04', 'FC01', 'MC03'};
    'M01_MC01', {'F01', 'M05', 'FC02', 'MC04'};
    'M01_MC02', {'F03', 'M02', 'FC03', 'MC01'};
    'M01_MC03', {'F04', 'M03', 'FC01', 'MC02'};
    'M01_MC04', {'F01', 'M04', 'FC02', 'MC03'};
    'M02_FC01', {'F01', 'M01', 'FC02', 'MC01'};
    'M02_FC02', {'F03', 'M03', 'FC03', 'MC02'};
    'M02_FC03', {'F04', 'M04', 'FC01', 'MC03'};
    'M02_MC01', {'F01', 'M05', 'FC02', 'MC04'};
    'M02_MC02', {'F03', 'M01', 'FC03', 'MC01'};
    'M02_MC03', {'F04', 'M03', 'FC01', 'MC02'};
    'M02_MC04', {'F01', 'M04', 'FC02', 'MC03'};
    'M03_FC01', {'F01', 'M01', 'FC02', 'MC01'};
    'M03_FC02', {'F03', 'M02', 'FC03', 'MC02'};
    'M03_FC03', {'F04', 'M04', 'FC01', 'MC03'};
    'M03_MC01', {'F01', 'M05', 'FC02', 'MC04'};
    'M03_MC02', {'F03', 'M01', 'FC03', 'MC01'};
    'M03_MC03', {'F04', 'M02', 'FC01', 'MC02'};
    'M03_MC04', {'F01', 'M04', 'FC02', 'MC03'};
    'M04_FC01', {'F01', 'M01', 'FC02', 'MC01'};
    'M04_FC02', {'F03', 'M02', 'FC03', 'MC02'};
    'M04_FC03', {'F04', 'M03', 'FC01', 'MC03'};
    'M04_MC01', {'F01', 'M05', 'FC02', 'MC04'};
    'M04_MC02', {'F03', 'M01', 'FC03', 'MC01'};
    'M04_MC03', {'F04', 'M02', 'FC01', 'MC02'};
    'M04_MC04', {'F01', 'M03', 'FC02', 'MC03'};
    'M05_FC01', {'F01', 'M01', 'FC02', 'MC01'};
    'M05_FC02', {'F03', 'M02', 'FC03', 'MC02'};
    'M05_FC03', {'F04', 'M03', 'FC01', 'MC03'};
    'M05_MC01', {'F01', 'M04', 'FC02', 'MC04'};
    'M05_MC02', {'F03', 'M01', 'FC03', 'MC01'};
    'M05_MC03', {'F04', 'M02', 'FC01', 'MC02'};
    'M05_MC04', {'F01', 'M03', 'FC02', 'MC03'};
};


% Generate .scp files
for i = 1:size(output_files, 1)
    % Full path of the output file
    % TRAINING ->
    % output_file_name = fullfile(output_folder, strcat('train_', output_files{i, 1}, '.scp'));

    % Subjects to search for in the paths
    subjects_to_search = output_files{i, 2};
    
    % Filter paths that contain the search terms
    filtered_paths = {}; % Initialize as a cell array
    for j = 1:numel(subjects_to_search)
        search_term = subjects_to_search{j};
        matching_paths = mfc_paths(contains(mfc_paths, search_term)); % Filter paths that contain the term
        filtered_paths = [filtered_paths; matching_paths(:)]; % Concatenate in cell format
    end
    
    % Remove duplicates from the filtered paths
    filtered_paths = unique(filtered_paths, 'stable'); % Remove duplicates and preserve order
    
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
