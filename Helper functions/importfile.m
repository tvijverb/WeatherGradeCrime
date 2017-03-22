function [isdhistory] = importfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as a matrix.
%   UNTITLED = IMPORTFILE(FILENAME) Reads data from text file FILENAME for
%   the default selection.
%
%   UNTITLED = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows
%   STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   Untitled = importfile('008411-99999-2014.op', 1, 365);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2015/12/19 01:10:02

%% Initialize variables.
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%6s%6s%10s%8s%3s%8s%3s%8s%3s%10s%1s%7s%3s%7s%3s%7s%7s%9s%8s%6s%7s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', '', 'WhiteSpace', '', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', '', 'WhiteSpace', '', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
Untitled = table;
Untitled.STN = cell2mat(raw(:, 1));
Untitled.WBAN = cell2mat(raw(:, 2));
Untitled.YEARMODA = cell2mat(raw(:, 3));
Untitled.TEMP = cell2mat(raw(:, 4));
Untitled.VarName5 = cell2mat(raw(:, 5));
Untitled.DEWP = cell2mat(raw(:, 6));
Untitled.VarName7 = cell2mat(raw(:, 7));
Untitled.SLP = cell2mat(raw(:, 8));
Untitled.VarName9 = cell2mat(raw(:, 9));
Untitled.STP = cell2mat(raw(:, 10));
Untitled.VarName11 = cell2mat(raw(:, 11));
Untitled.VISIB = cell2mat(raw(:, 12));
Untitled.VarName13 = cell2mat(raw(:, 13));
Untitled.WDSP = cell2mat(raw(:, 14));
Untitled.VarName15 = cell2mat(raw(:, 15));
Untitled.MXSPD = cell2mat(raw(:, 16));
Untitled.GUST = cell2mat(raw(:, 17));
Untitled.MAX = cell2mat(raw(:, 18));
Untitled.MIN = cell2mat(raw(:, 19));
Untitled.PRCP = cell2mat(raw(:, 20));
Untitled.SNDP = cell2mat(raw(:, 21));
Untitled.FRSHTT = cell2mat(raw(:, 22));

