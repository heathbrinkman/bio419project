% Takes the a COD cell and returns two cells, one of the 2000 data and one
% of the 2012 data with all zero rows removed
function [noZeros2000, noZeros2012] = trimmedSortedCOD(CODcell)
zeroIndexes = [];
for i = 1:size(CODcell, 1) 
    if str2double(CODcell(i, 3)) == 0
        zeroIndexes(end + 1) = i; 
    end;
end;
noZeros = {};
for i = 1:size(CODcell, 1)
    if ismember(i, zeroIndexes) == 0;
        noZeros(end + 1, :) = CODcell(i, :);
    end;
end;

noZeros2000 = {};
noZeros2012 = {};
for i = 1:size(noZeros, 1)
    if strcmp(noZeros(i, 1), '2000') == 1
        noZeros2000(end + 1, :) = noZeros(i, :);
    else
        noZeros2012(end + 1, :) = noZeros(i, :);
    end;
end;

for i = 1:size(noZeros2000, 1)
    noZeros2000{i, 3} = str2double(noZeros2000(i, 3));
end;
noZeros2000 = sortrows(noZeros2000, 3);
noZeros2000 = flip(noZeros2000);

for i = 1:size(noZeros2012, 1)
    noZeros2012{i, 3} = str2double(noZeros2012(i, 3));
end;
noZeros2012 = sortrows(noZeros2012, 3);
noZeros2012 = flip(noZeros2012);
    


