% === INITIAL CONFIGURATION ===
basePath = 'C:\Users\root\Desktop\htk-3.2.1';

% Subject groups
groups = {'F', 'FC', 'M', 'MC'};

% Subjects per group
subjects = struct( ...
    'F',  {{'F01', 'F03', 'F04'}}, ...
    'FC', {{'FC01', 'FC02', 'FC03'}}, ...
    'M',  {{'M01', 'M02', 'M03', 'M04', 'M05'}}, ...
    'MC', {{'MC01', 'MC02', 'MC03', 'MC04'}} ...
);

% Possible sessions
sessions = {'Session1', 'Session2', 'Session3'};

% Phonetic transcription folders
phnFolders = {'phn_arrayMic', 'phn_headMic'};

% Useless labels (silence, noise, etc.)
uselessLabels = {'sil', 'spn', 'noi', 'xxx'};

% List of invalid PHN files
invalidFiles = {};

% === AUTOMATIC SEARCH ===
for i = 1:length(groups)
    group = groups{i};
    for j = 1:length(subjects.(group))
        subject = subjects.(group){j};
        for s = 1:length(sessions)
            session = sessions{s};
            for p = 1:length(phnFolders)
                phnPath = fullfile(basePath, group, subject, session, phnFolders{p});
                
                if ~isfolder(phnPath)
                    continue;
                end
                
                files = dir(fullfile(phnPath, '*.PHN'));
                for k = 1:length(files)
                    filePath = fullfile(phnPath, files(k).name);
                    
                    fid = fopen(filePath, 'r');
                    if fid == -1
                        warning('Could not open: %s', filePath);
                        continue;
                    end
                    
                    phnLabels = {};
                    while ~feof(fid)
                        rawLine = fgetl(fid);
                        if ischar(rawLine)
                            line = strtrim(rawLine);
                            if ~isempty(line)
                                parts = strsplit(line);
                                if numel(parts) == 3
                                    phnLabels{end+1} = lower(parts{3}); 
                                end
                            end
                        end
                    end
                    fclose(fid);
                    
                    % Sole criterion: all labels are useless
                    if ~isempty(phnLabels) && all(ismember(phnLabels, uselessLabels))
                        invalidFiles{end+1} = filePath; 
                    end
                end
            end
        end
    end
end

% === SAVE RESULT ===
if ~isempty(invalidFiles)
    outputPath = fullfile('C:\Users\root\Desktop', 'phn_invalid_files.txt');
    fid = fopen(outputPath, 'w');
    for i = 1:length(invalidFiles)
        fprintf(fid, '%s\n', invalidFiles{i});
    end
    fclose(fid);
    fprintf('List saved to:\n%s\n', outputPath);
else
    fprintf('No invalid .PHN files found.\n');
end
