% Ruta del archivo wav_to_mfc_paths.txt
inputFile = 'C:\Users\root\Desktop\htk-3.2.1\wav_to_mfc_paths_CORRECT.txt';

% Ruta del archivo .scp de salida
outputScpFile = 'C:\Users\root\Desktop\htk-3.2.1\mfc_paths.scp';

% Leer el archivo wav_to_mfc_paths.txt
fileID = fopen(inputFile, 'r');
if fileID == -1
    error('No se pudo abrir el archivo %s', inputFile);
end

% Leer líneas del archivo
data = textscan(fileID, '%s %s', 'Delimiter', '\t');
fclose(fileID);

% Extraer la segunda columna (rutas de .mfc)
mfcPaths = data{2};

% Guardar las rutas en el archivo .scp
fileID = fopen(outputScpFile, 'w');
if fileID == -1
    error('No se pudo crear el archivo %s', outputScpFile);
end

for i = 1:length(mfcPaths)
    fprintf(fileID, '%s\n', mfcPaths{i});
end
fclose(fileID);

% Confirmación
fprintf('Archivo .scp generado en: %s\n', outputScpFile);
