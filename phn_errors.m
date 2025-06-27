% === CONFIGURACIÓN INICIAL ===
basePath = 'C:\Users\root\Desktop\htk-3.2.1';

% Grupos de sujetos
grupos = {'F', 'FC', 'M', 'MC'};

% Sujetos por grupo
sujetos = struct( ...
    'F',  {{'F01', 'F03', 'F04'}}, ...
    'FC', {{'FC01', 'FC02', 'FC03'}}, ...
    'M',  {{'M01', 'M02', 'M03', 'M04', 'M05'}}, ...
    'MC', {{'MC01', 'MC02', 'MC03', 'MC04'}} ...
);

% Sesiones posibles
sesiones = {'Session1', 'Session2', 'Session3'};

% Carpetas de transcripción fonética
carpetasPhn = {'phn_arrayMic', 'phn_headMic'};

% Etiquetas no útiles (zumbidos, silencio, ruido, etc.)
etiquetasInutiles = {'sil', 'spn', 'noi', 'xxx'};

% Lista de archivos PHN inválidos
archivosInvalidos = {};

% === BÚSQUEDA AUTOMÁTICA ===
for i = 1:length(grupos)
    grupo = grupos{i};
    for j = 1:length(sujetos.(grupo))
        sujeto = sujetos.(grupo){j};
        for s = 1:length(sesiones)
            sesion = sesiones{s};
            for p = 1:length(carpetasPhn)
                carpetaPHN = fullfile(basePath, grupo, sujeto, sesion, carpetasPhn{p});
                
                if ~isfolder(carpetaPHN)
                    continue;
                end
                
                archivos = dir(fullfile(carpetaPHN, '*.PHN'));
                for k = 1:length(archivos)
                    ruta = fullfile(carpetaPHN, archivos(k).name);
                    
                    fid = fopen(ruta, 'r');
                    if fid == -1
                        warning('No se pudo abrir: %s', ruta);
                        continue;
                    end
                    
                    etiquetasPHN = {};
                    while ~feof(fid)
                        rawLine = fgetl(fid);
                        if ischar(rawLine)
                            linea = strtrim(rawLine);
                            if ~isempty(linea)
                                partes = strsplit(linea);
                                if numel(partes) == 3
                                    etiquetasPHN{end+1} = lower(partes{3}); 
                                end
                            end
                        end
                    end
                    fclose(fid);
                    
                    % ÚNICO CRITERIO: todas las etiquetas son inútiles
                    if ~isempty(etiquetasPHN) && all(ismember(etiquetasPHN, etiquetasInutiles))
                        archivosInvalidos{end+1} = ruta; 
                    end
                end
            end
        end
    end
end

% === GUARDAR RESULTADO ===
if ~isempty(archivosInvalidos)
    salida = fullfile('C:\Users\root\Desktop', 'phn_invalid_files2.txt');
    fid = fopen(salida, 'w');
    for i = 1:length(archivosInvalidos)
        fprintf(fid, '%s\n', archivosInvalidos{i});
    end
    fclose(fid);
    fprintf('✔️ Lista guardada en:\n%s\n', salida);
else
    fprintf('✅ No se encontraron archivos .PHN inválidos.\n');
end







% % === CONFIGURACIÓN INICIAL ===
% basePath ='C:\Users\root\Desktop\htk-3.2.1';
% %'/Users/nataliap.st./Desktop/TFG Natalia Pedrosa';
% 
% % Grupos de sujetos
% grupos = {'F', 'FC', 'M', 'MC'};
% 
% % Sujetos por grupo (usar doble llaves para evitar conflicto de dimensiones)
% sujetos = struct( ...
%     'F',  {{'F01', 'F03', 'F04'}}, ...
%     'FC', {{'FC01', 'FC02', 'FC03'}}, ...
%     'M',  {{'M01', 'M02', 'M03', 'M04', 'M05'}}, ...
%     'MC', {{'MC01', 'MC02', 'MC03', 'MC04'}} ...
%     );
% 
% % Sesiones posibles
% sesiones = {'Session1', 'Session2', 'Session3'};
% 
% % Carpetas de transcripción fonética
% carpetasPhn = {'phn_arrayMic', 'phn_headMic'};
% 
% % Etiquetas no útiles (zumbidos, silencio, ruido, etc.)
% etiquetasInutiles = {'sil', 'spn', 'noi', 'xxx'};
% 
% % Lista de archivos PHN vacíos, cortos o solo con etiquetas inútiles
% archivosInvalidos = {};
% 
% % === BÚSQUEDA AUTOMÁTICA ===
% for i = 1:length(grupos)
%     grupo = grupos{i};
%     for j = 1:length(sujetos.(grupo))
%         sujeto = sujetos.(grupo){j};
%         for s = 1:length(sesiones)
%             sesion = sesiones{s};
%             for p = 1:length(carpetasPhn)
%                 carpetaPHN = fullfile(basePath, grupo, sujeto, sesion, carpetasPhn{p});
% 
%                 if ~isfolder(carpetaPHN)
%                     continue; % Saltar si no existe esa carpeta
%                 end
% 
%                 archivos = dir(fullfile(carpetaPHN, '*.PHN'));
%                 for k = 1:length(archivos)
%                     ruta = fullfile(carpetaPHN, archivos(k).name);
% 
%                     fid = fopen(ruta, 'r');
%                     if fid == -1
%                         warning('No se pudo abrir: %s', ruta);
%                         continue;
%                     end
% 
%                     lineas = {};
%                     etiquetasPHN = {};
%                     while ~feof(fid)
%                         rawLine = fgetl(fid);
%                         if ischar(rawLine)
%                             linea = strtrim(rawLine);
%                             if ~isempty(linea)
%                                 lineas{end+1} = linea; %#ok<AGROW>
%                                 partes = strsplit(linea);
%                                 if numel(partes) == 3
%                                     etiquetasPHN{end+1} = lower(partes{3}); %#ok<AGROW>
%                                 end
%                             end
%                         end
%                     end
%                     fclose(fid);
% 
%                     % Criterio 1: vacío o muy corto
%                     if isempty(lineas) || length(lineas) < 2
%                         archivosInvalidos{end+1} = ruta; %#ok<AGROW>
%                         continue;
%                     end
% 
%                     % Criterio 2: todas las etiquetas son inútiles
%                     if all(ismember(etiquetasPHN, etiquetasInutiles))
%                         archivosInvalidos{end+1} = ruta; %#ok<AGROW>
%                     end
%                 end
%             end
%         end
%     end
% end
% 
% % === GUARDAR RESULTADO ===
% if ~isempty(archivosInvalidos)
%    % salida = fullfile(basePath, 'phn_invalid_files.txt');
%     salida = fullfile('C:\Users\root\Desktop', 'phn_invalid_files.txt');
%     fid = fopen(salida, 'w');
%     for i = 1:length(archivosInvalidos)
%         fprintf(fid, '%s\n', archivosInvalidos{i});
%     end
%     fclose(fid);
%     fprintf('✔️ Lista guardada en:\n%s\n', salida);
% else
%     fprintf('✅ No se encontraron archivos .PHN inválidos.\n');
% end