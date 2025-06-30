% === INITIAL CONFIGURATION ===
rootDir = 'C:\Users\root\Desktop\htk-3.2.1';  % Carpeta donde están tus .wav reales
phnDir = 'C:\Users\root\Desktop\';            % Carpeta donde está phn_invalid_files.txt

% Root directory for .mfc files
mfcRootDir = 'C:\Users\root\Desktop\htk-3.2.1\mfccs';


% Full path for the output file
outputFile = fullfile('C:\Users\root\Desktop', 'wav_to_mfc_paths.txt');

% Get all wav_headMic and wav_arrayMic folders within the root directory
folders = {'wav_headMic', 'wav_arrayMic'};
filePaths = [];

% === Load PHN invalid paths and convert to corresponding WAV paths ===
phnInvalidFile = fullfile(phnDir, 'phn_invalid_files2.txt'); % Asegura ruta correcta

fid = fopen(phnInvalidFile, 'r');
if fid == -1
    error('❌ Could not open the invalid PHN file: %s', phnInvalidFile);
end

excludePaths = {};
while ~feof(fid)
    line = strtrim(fgetl(fid));
    if ~isempty(line)
        % Convert .phn path to .wav equivalent
        wavLine = strrep(line, 'phn_arrayMic', 'wav_arrayMic');
        wavLine = strrep(wavLine, 'phn_headMic', 'wav_headMic');
        
        % Extract file name and folder
        [folderPath, baseName, ~] = fileparts(wavLine);
        
        % Pad with zeros if baseName is numeric and shorter than 4 digits
        if all(isstrprop(baseName, 'digit')) && length(baseName) < 4
            baseName = sprintf('%04d', str2double(baseName));
        end
        
        % Reconstruct full wav path
        wavLine = fullfile(folderPath, [baseName, '.wav']);

        excludePaths{end+1} = wavLine;
    end
end
fclose(fid);

fprintf('📛 Total WAV files to exclude: %d\n', numel(excludePaths));

% === GENERATION OF THE FINAL LIST ===
for i = 1:length(folders)
    folderPath = fullfile(rootDir, '**', folders{i}); % Recursively search within htk-3.2.1
    files = dir(fullfile(folderPath, '*.wav')); % Get all .wav files

    for j = 1:length(files)
        wavPath = fullfile(files(j).folder, files(j).name); % Full path to the .wav file

        % Check if the file should be excluded
        if ismember(wavPath, excludePaths)
            fprintf('⛔ Archivo excluido: %s\n', wavPath); % ← Mostrar los excluidos
            continue; % Skip excluded paths
        end

        % Create the corresponding path for .mfc
        relativePath = strrep(wavPath, rootDir, ''); % Get the relative path from rootDir
        mfcPath = fullfile(mfcRootDir, relativePath); % Combine with the new root directory
        mfcPath = strrep(mfcPath, '.wav', '.mfc'); % Change extension to .mfc

        % Create necessary directories for the .mfc path
        mfcDir = fileparts(mfcPath);
        if ~exist(mfcDir, 'dir')
            mkdir(mfcDir);
        end

        % Add the paths to the array
        filePaths = [filePaths; {wavPath, mfcPath}];
    end
end

% Save the paths to a text file
fileID = fopen(outputFile, 'w');
for i = 1:size(filePaths, 1)
    fprintf(fileID, '%s\t%s\n', filePaths{i, 1}, filePaths{i, 2});
end
fclose(fileID);

fprintf('✅ File generated at: %s\n', outputFile);
fprintf('.mfc files will be saved under: %s\n', mfcRootDir);
