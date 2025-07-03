function HeatMap_Accuracy
    % Ruta del archivo Excel
    filename = 'C:\Users\root\Desktop\metrics_results_with_means.xlsx'; % Cambia a tu archivo
    T = readtable(filename, 'VariableNamingRule', 'preserve');

    % Extraer combinaciones y accuracy
    combinations = string(T.Combination); % asegurar tipo string
    accuracy = T.('Accuracy'); % columna Accuracy del archivo

    % Listas ordenadas de hablantes disartricos y controles
    dysList = ["F01", "F03", "F04", "M01", "M02", "M03", "M04", "M05"];
    ctrlList = ["FC01", "FC02", "FC03", "MC01", "MC02", "MC03", "MC04"];

    % Inicializar matriz vacía (controles filas, disartricos columnas)
    A = NaN(numel(ctrlList), numel(dysList));

    % Llenar matriz A con datos de accuracy
    for i = 1:length(combinations)
        splitStr = split(combinations(i), "_");
        if numel(splitStr) == 2
            dys = splitStr(1);
            ctrl = splitStr(2);
            r = find(ctrlList == ctrl);
            c = find(dysList == dys);
            if ~isempty(r) && ~isempty(c)
                A(r,c) = accuracy(i);
            end
        end
    end

    % Dibujar heatmap de Accuracy
    figure;
    h1 = heatmap(dysList, ctrlList, A, ...
        'Colormap', cool, ...
        'MissingDataColor', [0.9 0.9 0.9], ...
        'ColorLimits', [min(accuracy) max(accuracy)], ...
        'CellLabelFormat','%.3f');
    h1.Title = 'Test Set Accuracy Heatmap';
    h1.XLabel = 'Dysarthric Speaker';
    h1.YLabel = 'Control Speaker';
end
