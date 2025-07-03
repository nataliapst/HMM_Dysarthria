% Read table from Excel
filename = 'C:\Users\root\Desktop\finalResults_HRESULT.xlsx';
data = readtable(filename);

% Calculate accuracy per row only
accuracy = zeros(height(data),1);

for i = 1:height(data)
    TP = data.TP(i);
    FP = data.FP(i);
    FN = data.FN(i);
    TN = data.TN(i);

    total = TP + FP + FN + TN;
    if total > 0
        accuracy(i) = (TP + TN) / total;
    else
        accuracy(i) = NaN;
    end
end

% Add Accuracy column
data.Accuracy = accuracy;

% Initialize final table with original rows
finalTable = data;

% Every 7 rows calculate mean accuracy and add summary row
groupSize = 7;
numGroups = floor(height(data) / groupSize);

for g = 1:numGroups
    idxStart = (g-1)*groupSize + 1;
    idxEnd = g*groupSize;

    % Calculate mean accuracy of the group
    meanAccuracy = mean(data.Accuracy(idxStart:idxEnd), 'omitnan');

    % Create summary row (NaN for other columns)
    meanRow = data(idxStart,:);  % Copy structure
    
    % Replace 'Combination' with text "Mean group X"
    if iscell(meanRow.Combination)
        meanRow.Combination{1} = sprintf('Mean group %d', g);
    else
        meanRow.Combination(1) = sprintf('Mean group %d', g);
    end
    
    meanRow.TP = NaN;
    meanRow.FP = NaN;
    meanRow.FN = NaN;
    meanRow.TN = NaN;
    meanRow.Accuracy = meanAccuracy;

    % Add summary row to final table
    finalTable = [finalTable(1:idxEnd,:); meanRow; finalTable(idxEnd+1:end,:)];
end

% Save new Excel file with means
writetable(finalTable, 'C:\Users\root\Desktop\metrics_results_with_means.xlsx');

disp('File saved with added mean rows.');

% Given global totals (the ones you provided)
TP_total = 19688;
FN_total = 12960;
FP_total = 16592;
TN_total = 47420;

% Calculate global metrics
accuracy_global = (TP_total + TN_total) / (TP_total + TN_total + FP_total + FN_total);

% Display global metrics
fprintf('--- GLOBAL METRICS ---\n');
fprintf('Total TP: %d, FP: %d, FN: %d, TN: %d\n', TP_total, FP_total, FN_total, TN_total);
fprintf('Accuracy: %.4f\n', accuracy_global);

% Correct global confusion matrix: rows=actual, columns=predicted
confMatrixGlobal = [TP_total, FN_total; FP_total, TN_total];
classNames = {'Dysarthria', 'No Dysarthria'};

% Calculate total for percentage
totalSamples = sum(confMatrixGlobal, 'all');

% Plot global confusion matrix with numbers, global %, and per-class %
figure;
imagesc(confMatrixGlobal);
colormap(cool);
colorbar;
title('Global Confusion Matrix', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Prediction', 'FontSize', 12);
ylabel('Actual', 'FontSize', 12);
xticks([1 2]);
yticks([1 2]);
xticklabels(classNames);
yticklabels(classNames);

% Add numbers and percentages inside each cell
textStrings = strings(size(confMatrixGlobal));
labelNames = ["TP", "FN"; "FP", "TN"]; % labels according to new matrix
for i = 1:size(confMatrixGlobal,1)
    for j = 1:size(confMatrixGlobal,2)
        val = confMatrixGlobal(i,j);
        globalPercent = 100 * val / totalSamples;
        perClassPercent = 100 * val / sum(confMatrixGlobal(i,:));
        textStrings(i,j) = sprintf('%s = %d\nGlobal: %.2f%%\nPer class: %.2f%%', ...
            labelNames(i,j), val, globalPercent, perClassPercent);
    end
end

[x, y] = meshgrid(1:2);
textHandles = text(x(:), y(:), textStrings(:), ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 12, 'FontWeight', 'bold', 'Color', 'black');

% Adjust text color for readability based on background
ax = gca;
cLimits = ax.CLim;
for k = 1:numel(confMatrixGlobal)
    colorValue = (confMatrixGlobal(k) - cLimits(1)) / (cLimits(2) - cLimits(1));
    if colorValue > 0.5
        textHandles(numel(confMatrixGlobal)-k+1).Color = 'white';
    else
        textHandles(numel(confMatrixGlobal)-k+1).Color = 'black';
    end
end

% Add text with totals and percentages below the plot (in separate position)
totalsText = sprintf('Totals: TP = %d (%.2f%%), FP = %d (%.2f%%), FN = %d (%.2f%%), TN = %d (%.2f%%)', ...
    TP_total, 100*TP_total/totalSamples, ...
    FP_total, 100*FP_total/totalSamples, ...
    FN_total, 100*FN_total/totalSamples, ...
    TN_total, 100*TN_total/totalSamples);

ylim_vals = ylim;
text(0.5, ylim_vals(1) - 0.25*diff(ylim_vals), totalsText, ...
    'FontSize', 12, 'FontWeight', 'bold', 'Color', 'black');

% Save the figure
saveas(gcf, 'C:\Users\root\Desktop\confusion_matrix_global_correct_order.png');
