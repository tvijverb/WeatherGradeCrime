%Load file database
MyDirInfo = dir('C:\path\to\isdhistory.mat');

%Load station data
load('isdhistory.mat');

%Crosslink station data to location
for i = 1:(size(MyDirInfo)-2)
    S(i).data = importfile(MyDirInfo(i+2).name);
    S(i).data(1,:)=[];
    S(i).Lon = isdhistory.LON(S(i).data.STN(2) == isdhistory.USAF);
    S(i).Lon = cellfun(@(x)str2double(x), S(i).Lon);
    S(i).Lat = isdhistory.RYSTCALLLAT(S(i).data.STN(2) == isdhistory.USAF);
    
    %Convert cell longitude and lattitude to double
    find_plus = find('+'== S(i).Lat{1}, 1, 'last');
    find_minus = find('-'== S(i).Lat{1}, 1, 'last');
    
    if(~isempty(find_plus))
        S(i).Lat = S(i).Lat{1}(find_plus:end);
    end
    if(~isempty(find_minus))
        S(i).Lat = S(i).Lat{1}(find_minus:end);
    end
    S(i).Lat = cellstr(S(i).Lat);
    S(i).Lat = cellfun(@(x)str2double(x), S(i).Lat);
    if(mod(i,10) == 0)
        disp(i);
    end
end
