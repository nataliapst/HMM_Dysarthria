% Path to the wav_to_mfc_paths.txt file
inputFile = 'C:\Users\root\Desktop\htk-3.2.1\wav_to_mfc_paths.txt';

% Path to the output .scp file
outputScpFile = 'C:\Users\root\Desktop\htk-3.2.1\mfc_paths.scp';

% Read the wav_to_mfc_paths.txt file
fileID = fopen(inputFile, 'r');
if fileID == -1
    error('Could not open the file %s', inputFile);
end

% Read lines from the file
data = textscan(fileID, '%s %s', 'Delimiter', '\t');
fclose(fileID);

% Extract the second column (paths to .mfc files)
mfcPaths = data{2};

% Save the paths in the .scp file
fileID = fopen(outputScpFile, 'w');
if fileID == -1
    error('Could not create the file %s', outputScpFile);
end

for i = 1:length(mfcPaths)
    fprintf(fileID, '%s\n', mfcPaths{i});
end
fclose(fileID);

% Confirmation message
fprintf('.scp file generated at: %s\n', outputScpFile);
