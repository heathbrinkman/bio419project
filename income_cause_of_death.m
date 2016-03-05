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

%% work in progress
% threshold value for significant deaths per 10 000 population needs to be
% determined
[row, column] = size(HighIncomeCOD);
low = ones(row, 1);
lmid= ones(row, 1)*2;
umid = ones(row, 1)*3;
high = ones(row, 1)*4;

obj = fitcdiscr([str2double(LowCOD(:, 3)); 
    str2double(LowerMidCOD(:, 3)); 
    str2double(UpperMidCOD(:, 3)); str2double(HighIncomeCOD(:, 3))],  [low; lmid; umid; high])

