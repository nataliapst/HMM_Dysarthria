

% Listas de X y Y
X_values = {'F01', 'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05'};
Y_values = {'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};

% Directorio base
base_dir = 'C:\Users\root\Desktop\htk-3.2.1';

% Iterar sobre todas las combinaciones de X y Y
for i = 1:length(X_values)
    for j = 1:length(Y_values)
        X = X_values{i};
        Y = Y_values{j};
        
        % Definir rutas específicas para esta combinación
        train_dir = fullfile(base_dir, ['train_', X, '_', Y, '\hmm0']);
        % train_dir = fullfile(base_dir, ['train_develop_', X, '_', Y, '\hmm0']);
        proto_file = fullfile(train_dir, 'proto');
        vFloor_file = fullfile(train_dir, 'vFloors');
        hmmdefs_file = fullfile(train_dir, 'hmmdefs');
        macro_file = fullfile(train_dir, 'macro');
        
        % Verificar que los archivos proto y vFloors existan
        if ~isfile(proto_file)
            warning('Archivo proto no encontrado: %s. Se omite esta combinación.', proto_file);
            continue;
        end
        if ~isfile(vFloor_file)
            warning('Archivo vFloor no encontrado: %s. Se omite esta combinación.', vFloor_file);
            continue;
        end
        
        % Leer el contenido completo del archivo proto
        proto_content = fileread(proto_file);
        proto_lines = strsplit(proto_content, '\n'); % Dividir en líneas
        
        % Asegurarse de que las líneas copiadas tienen el formato correcto
        for k = 1:3
            if contains(proto_lines{k}, '<MFCC_D_A_0>')
                proto_lines{k} = strrep(proto_lines{k}, '<MFCC_D_A_0>', '<MFCC_0_D_A>');
            end
        end
        
        % Generar el archivo hmmdefs
        hmmdefs_fid = fopen(hmmdefs_file, 'w');
        if hmmdefs_fid == -1
            error('No se pudo abrir el archivo hmmdefs para escribir: %s', hmmdefs_file);
        end
        
        % Crear las definiciones de HMM
        proto_body = proto_lines(4:end); % Eliminar las primeras tres líneas
        proto_body_content = strjoin(proto_body, '\n');
        
        dysarthria_hmm = strrep(proto_body_content, '~h "proto"', '~h "Dysarthria"');
        no_dysarthria_hmm = strrep(proto_body_content, '~h "proto"', '~h "No_Dysarthria"');
        
        % Escribir las definiciones en hmmdefs
        fprintf(hmmdefs_fid, '%s', dysarthria_hmm);
        fprintf(hmmdefs_fid, '%s', no_dysarthria_hmm);
        fclose(hmmdefs_fid);
        
        % Generar el archivo macro
        macro_fid = fopen(macro_file, 'w');
        if macro_fid == -1
            error('No se pudo abrir el archivo macro para escribir: %s', macro_file);
        end
        
        % Escribir las primeras tres líneas del proto en macro
        for k = 1:3
            fprintf(macro_fid, '%s\n', proto_lines{k});
        end
        
        % Leer el contenido completo de vFloors
        vFloor_content = fileread(vFloor_file);
        
        % Buscar la posición de la línea "<Variance> 39" para procesar solo los números después
        header_position = strfind(vFloor_content, '<Variance> 39');
        if isempty(header_position)
            error('No se encontró la línea "<Variance> 39" en el archivo vFloors: %s', vFloor_file);
        end
        
        % Extraer solo el contenido después del encabezado
        numeric_content = vFloor_content(header_position + length('<Variance> 39'):end);
        numeric_values = strsplit(strtrim(numeric_content)); % Dividir en números individuales
        
        % Escribir la línea de encabezado <Variance> con "39"
        fprintf(macro_fid, '~v varFloor1 <Variance> 39\n');
        
        % Escribir los números formateados en líneas de tres
        num_per_line = 3; % Cantidad de números por línea
        for k = 1:num_per_line:length(numeric_values)
            fprintf(macro_fid, '%s\n', strjoin(numeric_values(k:min(k+num_per_line-1, end)), ' '));
        end
        
        fclose(macro_fid);
        
        % Mensaje de éxito
        fprintf('Archivos hmmdefs y macro generados correctamente para %s y %s.\n', X, Y);
    end
end

disp('Proceso completado para todas las combinaciones.');
