
function generar_archivos_mlf()
    % Especifica la ruta base
    rutaBase = 'C:/Users/root/Desktop/htk-3.2.1/';
    rutaIdentificadoresClases = fullfile(rutaBase, 'clases.list');

    % Definir las listas de hablantes
    disartria = {'F01', 'F03', 'F04', 'M01', 'M02', 'M03', 'M04', 'M05'};
    no_disartria = {'FC01', 'FC02', 'FC03', 'MC01', 'MC02', 'MC03', 'MC04'};

    try
        % Leer lista de clases directamente
        fid_clases = fopen(rutaIdentificadoresClases, 'r');
        if fid_clases == -1
            error('No se pudo abrir el archivo de clases: %s', rutaIdentificadoresClases);
        end
        clases = {};
        while ~feof(fid_clases)
            clase = strtrim(fgetl(fid_clases));
            if ischar(clase) && ~isempty(clase)
                clases{end+1} = clase;
            end
        end
        fclose(fid_clases);
        disp('Clases leídas correctamente.');

        % Generar archivos para cada combinación de disartria y no_disartria
        for i = 1:length(disartria)
            for j = 1:length(no_disartria)
                sujeto_disartria = disartria{i};
                sujeto_no_disartria = no_disartria{j};

               % Crear nombres de archivo

                 nombreSCP = sprintf('develop_%s_%s.scp', sujeto_disartria, sujeto_no_disartria);
                 nombreMLF = sprintf('develop_%s_%s.mlf', sujeto_disartria, sujeto_no_disartria);

                rutaSCP = fullfile(rutaBase, nombreSCP);
                rutaMLF = fullfile(rutaBase, nombreMLF);

                % Comprobar si el archivo .scp existe
                if ~isfile(rutaSCP)
                    fprintf('Advertencia: El archivo .scp no existe: %s\n', rutaSCP);
                    continue; % Saltar esta combinación si no hay archivo .scp
                end

                % Abrir archivo de salida .mlf
                fid_mlf = fopen(rutaMLF, 'w');
                if fid_mlf == -1
                    error('No se pudo crear el archivo .mlf: %s', rutaMLF);
                end
                fprintf(fid_mlf, '#!MLF!#\n');

                % Leer los nombres de archivos del .scp correspondiente
                fid_scp = fopen(rutaSCP, 'r');
                if fid_scp == -1
                    fclose(fid_mlf);
                    error('No se pudo abrir el archivo .scp: %s', rutaSCP);
                end

                % Procesar líneas del archivo .scp
                while ~feof(fid_scp)
                    linea = strtrim(fgetl(fid_scp));
                    if ischar(linea) && ~isempty(linea)
                        % Determinar la clase del archivo actual
                        clase = determinar_clase(linea, disartria, no_disartria);

                        % Cambiar la extensión a .lab y escribir en el archivo .mlf
                        rutaArchivoLab = strrep(linea, '.mfc', '.lab');
                        fprintf(fid_mlf, '"%s"\n%s\n.\n', rutaArchivoLab, clase);
                    end
                end

                fclose(fid_scp);
                fclose(fid_mlf);
                fprintf('Archivo %s generado con éxito.\n', nombreMLF);
            end
        end

    catch ME
        disp('Error al generar los archivos:');
        disp(ME.message);
    end
end

function clase = determinar_clase(linea, disartria, no_disartria)
    % Determina la clase del archivo basado en las listas de disartria/no_disartria
    clase = 'Unknown'; % Valor por defecto
    for i = 1:length(disartria)
        if contains(linea, disartria{i})
            clase = 'Dysarthria';
            return; % Salir de la función si se encuentra una coincidencia
        end
    end
    for i = 1:length(no_disartria)
        if contains(linea, no_disartria{i})
            clase = 'No_Dysarthria';
            return; % Salir de la función si se encuentra una coincidencia
        end
    end
end
