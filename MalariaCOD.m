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
%figure;
%hold on;
%plot(data(:, 3), data(:, 1), '.');
%[fit1, gof1] = fit(data(:, 3), data(:, 1), 'exp1', 'Robust', 'Bisquare');
%plot(fit1);
%error1 = polyError(data(:, [3, 1]), 'exp1', 100, 0.2);
%%
figure;
hold on;
plot(data(:, 3), data(:, 2), '.');
[fit2, gof2] = fit(data(:, 3), data(:, 2), 'exp1', 'Robust', 'Bisquare');
plot(fit2);
xlabel('Percent Population with Access to Improved Drinking Water');
ylabel('Deaths Per 100,000 due to Malaria');
title('Access to Improved Drinking Water vs. Malaria Death Rates');
legend();
%error2 = polyError(data(:, [3, 2]), 'exp1', 100, 0.2);










