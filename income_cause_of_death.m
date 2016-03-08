%%
LowerMidCOD = readtable('CauseOfDeathLowerMid.csv');
UpperMidCOD = readtable('CauseOfDeathUpperMid.csv');

% included in function
UpperMidCOD = sortrows(UpperMidCOD,'Causes','ascend');
LowerMidCOD = sortrows(LowerMidCOD,'Causes', 'ascend');
LowerMidCOD = sortrows(LowerMidCOD, 'Year', 'ascend');
UpperMidCOD = sortrows(UpperMidCOD, 'Year','ascend');

%%
% this has been written as a function, will use function instead in final
% version
% functioin: IncomeCODProcess
UpperMidCOD = table2array(UpperMidCOD);
UpperMidCOD = UpperMidCOD(strcmpi(UpperMidCOD(:, 5), 'Both sexes'), :);
% finds data for both sexes and all ages, death per 100 000
UpperMidCOD = UpperMidCOD(:, [3, 7, 9]);

LowerMidCOD = table2array(LowerMidCOD);
LowerMidCOD = LowerMidCOD(strcmpi(LowerMidCOD(:, 5), 'Both sexes'), :);

LowerMidCOD = LowerMidCOD(:, [3, 7, 9]);
%%
% x = strcmpi(LowerMidCOD(:, 2), UpperMidCOD(:, 2)) & strcmpi(LowerMidCOD(:, 1), UpperMidCOD(:, 1));
% verified data sorted correctly with disease and year

%%
HighIncomeCOD = readtable('CauseOfDeathHigh.csv');
HighIncomeCOD = sortrows(HighIncomeCOD,'Causes', 'ascend');
HighIncomeCOD = sortrows(HighIncomeCOD, 'Year', 'ascend');

HighIncomeCOD = table2array(HighIncomeCOD);
HighIncomeCOD = HighIncomeCOD(strcmpi(HighIncomeCOD(:, 5), 'Both sexes'), :);
% finds data for both sexes and all ages, death per 100 000
HighIncomeCOD = HighIncomeCOD(:, [3, 7, 9]);

%%
LowIncomeCOD = readtable('CauseOfDeathLow.csv');
LowIncomeCOD = IncomeCODProcess(LowIncomeCOD);

%% Separate all Data by Year and remove zero values
[LowIncomeCOD2000, LowIncomeCOD2012] = trimmedSortedCOD(LowIncomeCOD);
[LowerMidIncomeCOD2000, LowerMidIncomeCOD2012] = trimmedSortedCOD(LowerMidCOD);
[UpperMidIncomeCOD2000, UpperMidIncomeCOD2012] = trimmedSortedCOD(UpperMidCOD);
[HighIncomeCOD2000, HighIncomeCOD2012] = trimmedSortedCOD(HighIncomeCOD);


%%
% intial visual comparison of data
figure;
hold on;
% plotting only the 2000 data or the 2012 data, not both at once
plot(str2double(LowIncomeCOD(1:158, 3)), '.');
plot(str2double(LowerMidCOD(1:158, 3)), '.');
plot(str2double(UpperMidCOD(1:158, 3)), '.');
plot(str2double(HighIncomeCOD(1:158, 3)), '.');
title('Causes of Death in Low, Lower Middle, Uppper Middle and High Income Countries in 2000');
legend('lower income', 'lower mid income', 'upper mid income', 'high income');
ylabel('deaths per 10 000 population');
xlabel('cause, too many to display at this moment');


%%
figure;
labels = LowIncomeCOD2012(2:11, 2);
bar(cell2mat(LowIncomeCOD2012(2:11, 3)));
set(gca,'XTickLabel',labels)
ax = gca;
ax.XTickLabelRotation=90;
ylabel('Deaths per 100,000');
title('Top ten causes of death for low income countries');

figure;
labels = HighIncomeCOD2012(2:11, 2);
bar(cell2mat(HighIncomeCOD2012(2:11, 3)));
set(gca,'XTickLabel',labels)
ax = gca;
ax.XTickLabelRotation=90;
ylabel('Deaths per 100,000');
title('Top ten causes of death for high income countries');



