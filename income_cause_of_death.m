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

%%
% intial visual comparison of data
figure;
hold on;
plot(str2double(LowerMidCOD(:, 3)), 'r.');
plot(str2double(UpperMidCOD(:, 3)), '.');
plot(str2double(HighIncomeCOD(:, 3)), 'g.');
legend('lower mid income', 'upper mid income', 'high income');
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

