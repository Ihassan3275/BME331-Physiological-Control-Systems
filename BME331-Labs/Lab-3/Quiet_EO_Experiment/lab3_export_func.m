
% Read the data from the 'quiet_standing.data' file as text
data = readmatrix('quiet_standing.data', 'FileType', 'text');

% Get the number of columns in the data matrix
numCols = size(data, 2);

% Loop through each column and write it to a .txt file
for colIdx = 1:numCols
    colData = data(:, colIdx);
    fileName = sprintf('column%d.txt', colIdx);
    writematrix(colData, fileName);
end

% col 1 and col 3 are the same -> AP
% col 2 -> TA