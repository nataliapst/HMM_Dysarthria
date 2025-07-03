function generate_mlf_files()
    % Specify the base path
    basePath = 'C:/Users/root/Desktop/htk-3.2.1/';
    classIdentifiersPath = fullfile(basePath, 'clases.list');

    % Define speaker lists
    dysarthria = {'F01', 'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05'};
    no_dysarthria = {'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};

    try
        % Read class list directly
        fid_classes = fopen(classIdentifiersPath, 'r');
        if fid_classes == -1
            error('Could not open the classes file: %s', classIdentifiersPath);
        end
        classes = {};
        while ~feof(fid_classes)
            classLine = strtrim(fgetl(fid_classes));
            if ischar(classLine) && ~isempty(classLine)
                classes{end+1} = classLine;
            end
        end
        fclose(fid_classes);
        disp('Classes read successfully.');

        % Generate files for each dysarthria and no_dysarthria combination
        for i = 1:length(dysarthria)
            for j = 1:length(no_dysarthria)
                dysarthric_subject = dysarthria{i};
                non_dysarthric_subject = no_dysarthria{j};

                % Create filenames
                scpName = sprintf('test_%s_%s.scp', dysarthric_subject, non_dysarthric_subject);
                mlfName = sprintf('test_%s_%s.mlf', dysarthric_subject, non_dysarthric_subject);

                scpPath = fullfile(basePath, scpName);
                mlfPath = fullfile(basePath, mlfName);

                % Check if .scp file exists
                if ~isfile(scpPath)
                    fprintf('Warning: .scp file does not exist: %s\n', scpPath);
                    continue; % Skip this combination if no .scp file
                end

                % Open output .mlf file
                fid_mlf = fopen(mlfPath, 'w');
                if fid_mlf == -1
                    error('Could not create .mlf file: %s', mlfPath);
                end
                fprintf(fid_mlf, '#!MLF!#\n');

                % Read filenames from corresponding .scp file
                fid_scp = fopen(scpPath, 'r');
                if fid_scp == -1
                    fclose(fid_mlf);
                    error('Could not open .scp file: %s', scpPath);
                end

                % Process lines from .scp file
                while ~feof(fid_scp)
                    line = strtrim(fgetl(fid_scp));
                    if ischar(line) && ~isempty(line)
                        % Determine the class of the current file
                        classLabel = determine_class(line, dysarthria, no_dysarthria);

                        % Change extension to .lab and write to .mlf file
                        labFilePath = strrep(line, '.mfc', '.lab');
                        fprintf(fid_mlf, '"%s"\n%s\n.\n', labFilePath, classLabel);
                    end
                end

                fclose(fid_scp);
                fclose(fid_mlf);
                fprintf('File %s generated successfully.\n', mlfName);
            end
        end

    catch ME
        disp('Error generating files:');
        disp(ME.message);
    end
end

function classLabel = determine_class(line, dysarthria, no_dysarthria)
    % Determines the class of the file based on dysarthria/no_dysarthria lists
    classLabel = 'Unknown'; % Default value
    for i = 1:length(dysarthria)
        if contains(line, dysarthria{i})
            classLabel = 'Dysarthria';
            return; % Exit function if match found
        end
    end
    for i = 1:length(no_dysarthria)
        if contains(line, no_dysarthria{i})
            classLabel = 'No_Dysarthria';
            return; % Exit function if match found
        end
    end
end
