%%
% read from file
LowIncomeCOD = readtable('CauseOfDeathLow.csv');
LowerMidCOD = readtable('CauseOfDeathLowerMid.csv');
UpperMidCOD = readtable('CauseOfDeathUpperMid.csv');
HighIncomeCOD = readtable('CauseOfDeathHigh.csv');
% pull death cause of both sexes, 2000 and 2010
LowIncomeCOD = ReadIncomeCOD(LowIncomeCOD);
LowerMidCOD = ReadIncomeCOD(LowerMidCOD);
UpperMidCOD = ReadIncomeCOD(UpperMidCOD);
HighIncomeCOD = ReadIncomeCOD(HighIncomeCOD);

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



