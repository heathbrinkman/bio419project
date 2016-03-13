malariaDeaths = table2cell(readtable('MalariaDeaths.csv', 'HeaderLines', 1));
malariaCases = table2cell(readtable('MalariaCases.csv', 'HeaderLines', 1));
clear compiledMalaria;
clear malariaWater;
%%
[isA, locB] = ismember(malariaCases(:, 1), malariaDeaths(:, 1));
%%
compiledMalaria(:, 1) = malariaCases((isA~=0), 1);
compiledMalaria(:, 2) = malariaCases((isA~=0), 6);
compiledMalaria(:, 3) = malariaDeaths(locB(locB~=0), 2);
%% Adds 
empty = any(cellfun('isempty', compiledMalaria), 2);
compiledMalaria(empty, :) = [];
[isA, locB] = ismember(compiledMalaria(:, 1), Water(:, 1));
malariaWater(:, 1:3) = compiledMalaria((isA~=0), 1:3);
malariaWater(:, 4:5) = Water(locB(locB~=0), [3, 7]);
for i = 1:size(malariaWater, 1) %removes the spaces from the income strings
    malariaWater{i, 2}(malariaWater{i, 2}== ' ') = '';
end;
for i = 2:5
    malariaWater(:, i) = num2cell(str2double(malariaWater(:, i)));
end;
data = cell2mat(malariaWater(:, 2:5));
% data is Cases, Deaths per 100,000, Improved Drinking
% Water percentage and income
figure;
plot(data((data(:, 1)~=0), 3), data((data(:, 1)~=0), 1), '.');
figure;
plot(data((data(:, 1)~=0), 4), data((data(:, 1)~=0), 1), '.');






