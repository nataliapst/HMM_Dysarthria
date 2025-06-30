% Full path to the mfc_paths.scp file
scp_file_path = 'C:\Users\root\Desktop\htk-3.2.1\mfc_paths.scp';

% Read the mfc_paths.scp file
mfc_paths = fileread(scp_file_path); % Read the content of the SCP file as text
mfc_paths = strsplit(mfc_paths, newline); % Split into lines

% Output folder for the generated .scp files
output_folder = 'C:\Users\root\Desktop\htk-3.2.1'; % Folder where the files will be saved


%TRAINING
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
