function generate_mlf_files()
    % Specify the base path
    basePath = 'C:/Users/root/Desktop/htk-3.2.1/';
    classIdentifiersPath = fullfile(basePath, 'clases.list');

    % Define the speaker lists
    dysarthric = {'F01', 'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05'};
    non_dysarthric = {'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};

    try
        % Read the class list directly
        fid_classes = fopen(classIdentifiersPath, 'r');
        if fid_classes == -1
            error('Could not open class file: %s', classIdentifiersPath);
        end
        classes = {};
        while ~feof(fid_classes)
            class_name = strtrim(fgetl(fid_classes));
            if ischar(class_name) && ~isempty(class_name)
                classes{end+1} = class_name;
            end
        end
        fclose(fid_classes);
        disp('Classes read successfully.');

        % Generate files for each dysarthric and non-dysarthric combination
        for i = 1:length(dysarthric)
            for j = 1:length(non_dysarthric)
                dysarthric_subject = dysarthric{i};
                non_dysarthric_subject = non_dysarthric{j};

                % Create file names
                 nameSCP = sprintf('train_%s_%s.scp', dysarthric_subject, non_dysarthric_subject);
                 nameMLF = sprintf('train_%s_%s.mlf', dysarthric_subject, non_dysarthric_subject);
    
                pathSCP = fullfile(basePath, nameSCP);
                pathMLF = fullfile(basePath, nameMLF);

                % Check if the .scp file exists
                if ~isfile(pathSCP)
                    fprintf('Warning: .scp file does not exist: %s\n', pathSCP);
                    continue; % Skip this combination if no .scp file is available
                end

                % Open the output .mlf file
                fid_mlf = fopen(pathMLF, 'w');
                if fid_mlf == -1
                    error('Could not create the .mlf file: %s', pathMLF);
                end
                fprintf(fid_mlf, '#!MLF!#\n');

                % Read filenames from the corresponding .scp file
                fid_scp = fopen(pathSCP, 'r');
                if fid_scp == -1
                    fclose(fid_mlf);
                    error('Could not open the .scp file: %s', pathSCP);
                end

                % Process each line in the .scp file
                while ~feof(fid_scp)
                    line = strtrim(fgetl(fid_scp));
                    if ischar(line) && ~isempty(line)
                        % Determine the class for the current file
                        class_label = determine_class(line, dysarthric, non_dysarthric);

                        % Change the extension to .lab and write to the .mlf file
                        labPath = strrep(line, '.mfc', '.lab');
                        fprintf(fid_mlf, '"%s"\n%s\n.\n', labPath, class_label);
                    end
                end

                fclose(fid_scp);
                fclose(fid_mlf);
                fprintf('File %s generated successfully.\n', name

