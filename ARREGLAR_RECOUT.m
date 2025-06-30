% Definir los sujetos con disartria y sin disartria
disartria = {'F01', 'F03','F04', 'M01', 'M02', 'M03', 'M04','M05'}; %'F03',
no_disartria = {'FC01','FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};

% Ruta base
base_path = 'C:\Users\root\Desktop\htk-3.2.1\';

% Iterar sobre todas las combinaciones de sujetos con y sin disartria
for i = 1:length(disartria)
    for j = 1:length(no_disartria)
        
        % Nombres de los sujetos actuales
        disartria_subject = disartria{i};
        no_disartria_subject = no_disartria{j};
        
        % Buscar todos los archivos recout con el patrón correspondiente
        file_pattern = fullfile(base_path, ['recout_' disartria_subject '_' no_disartria_subject '_*.mlf']);
        recout_files = dir(file_pattern);
        
        % Procesar cada archivo encontrado
        for f = 1:length(recout_files)
            % Obtener nombre completo del archivo actual
            recout_file = fullfile(recout_files(f).folder, recout_files(f).name);
            corrected_recout_file = strrep(recout_file, '.mlf', '_corrected.mlf');
            
            % Nombres de archivos development
            development_file = fullfile(base_path, ['develop_' disartria_subject '_' no_disartria_subject '.mlf']);
            
            % Leer el archivo development
            dev_fid = fopen(development_file, 'r');
            if dev_fid == -1
                fprintf('No se pudo abrir el archivo %s\n', development_file);
                continue;
            end
            dev_content = textscan(dev_fid, '%s', 'Delimiter', '\n');
            fclose(dev_fid);
            
            % Extraer las rutas de .lab en development y cambiar extensión a .rec
            dev_lines = dev_content{1};
            rec_paths = strrep(dev_lines(contains(dev_lines, '.lab')), '.lab', '.rec');
            
            % Leer el archivo recout
            recout_fid = fopen(recout_file, 'r');
            if recout_fid == -1
                fprintf('No se pudo abrir el archivo %s\n', recout_file);
                continue;
            end
            recout_content = textscan(recout_fid, '%s', 'Delimiter', '\n');
            fclose(recout_fid);
            
            % Escribir el archivo recout corregido
            corrected_fid = fopen(corrected_recout_file, 'w');
            fprintf(corrected_fid, '%s\n', recout_content{1}{1}); % Encabezado #!MLF!#
            
            % Sustituir las rutas en recout con las de development modificadas
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
            
            fprintf('Archivo corregido guardado: %s\n', corrected_recout_file);
        end
    end
end
