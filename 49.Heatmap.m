function HeatMap_Accuracy
    % Path to the Excel file
    filename = 'C:\Users\root\Desktop\metrics_results_with_means.xlsx'; % Change to your file
    T = readtable(filename, 'VariableNamingRule', 'preserve');

    % Extract combinations and accuracy
    combinations = string(T.Combination); % ensure string type
    accuracy = T.('Accuracy'); % Accuracy column from the file

    % Ordered lists of dysarthric speakers and controls
    dysList = ["F03", "F04", "M01", "M02", "M04", "M05"];
    ctrlList = ["FC01", "FC02", "FC03", "MC01", "MC02", "MC03", "MC04"];

    % Initialize empty matrix (controls rows, dysarthric columns)
    A = NaN(numel(ctrlList), numel(dysList));

    % Fill matrix A with accuracy data
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
end
