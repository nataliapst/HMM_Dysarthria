% === CONFIGURA AQUÍ TU CARPETA Y ARCHIVOS ===
carpeta = 'C:\Users\root\Desktop';  % carpeta donde están los .txt
archivo_excel = 'C:\Users\root\Desktop\RESULT_CORREGIDO2.xlsx';  % Excel destino
hoja_salida = 'HTK_Resultados';  % hoja del Excel donde guardar

archivos_txt = { ...
    'HResultF01.txt', ...
    'HResultF03.txt', ...
    'HResultF04.txt', ...
    'HResultM01.txt', ...
    'HResultM02.txt', ...
    'HResultM03.txt', ...
    'HResultM04.txt', ...
    'HResultM05.txt' ...
};

% === Crear tabla vacía con encabezados ===
gaussianas = 1:40;
n_gauss = numel(gaussianas);
columnas = strcat("Var", string(gaussianas));
tabla = cell2table(cell(0, n_gauss), 'VariableNames', columnas);
tabla.Properties.RowNames = {};

% === Añadir fila de Speaker (número de gaussianas) ===
speaker_row = array2table(gaussianas, 'VariableNames', columnas);
speaker_row.Properties.RowNames = {'Speaker'};
tabla = [speaker_row; tabla];

% === PROCESAR TODOS LOS ARCHIVOS TXT ===
for f = 1:length(archivos_txt)
    archivo_txt = fullfile(carpeta, archivos_txt{f});
    fprintf('Procesando: %s\n', archivo_txt);

    fid = fopen(archivo_txt, 'r');
    if fid == -1
        warning('No se pudo abrir: %s', archivo_txt);
        continue;
    end

    linea = fgetl(fid);
    fila = ''; gauss = NaN;

    while ischar(linea)
        % Buscar combinación y número de gaussianas
        recinfo = regexp(linea, 'recout_([FM]\d{2}_[FM]C\d{2})_(\d+)_corrected\.mlf', 'tokens');
        if ~isempty(recinfo)
            fila = recinfo{1}{1};
            gauss = str2double(recinfo{1}{2});
        end

        % Buscar valor de %Correct
        corinfo = regexp(linea, '%Correct=([\d.]+)', 'tokens');
        if ~isempty(corinfo) && ~isempty(fila) && ~isnan(gauss)
            valor = str2double(corinfo{1}{1});
            nombre_columna = sprintf('Var%d', gauss);

            % Si la fila no existe, se añade
            if ~any(strcmp(tabla.Properties.RowNames, fila))
                nueva_fila = array2table(nan(1, n_gauss), 'VariableNames', columnas);
                nueva_fila.Properties.RowNames = {fila};
                tabla = [tabla; nueva_fila];
            end

            % Guardar valor en su posición
            tabla{fila, nombre_columna} = valor;

            fila = ''; gauss = NaN;
        end

        linea = fgetl(fid);
    end
    fclose(fid);
end

% === GUARDAR RESULTADO EN EXCEL ===
writetable(tabla, archivo_excel, 'WriteRowNames', true, 'Sheet', hoja_salida);
disp('¡Resultados añadidos al Excel correctamente!');
