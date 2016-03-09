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
% mean of each cause in lower and upper middle income countries
MidIncomeCOD = (str2double(LowerMidCOD(:, 3)) + str2double(UpperMidCOD(:, 3)) )/2;


%%
% intial visual comparison of data
figure;
hold on;
% plotting only the 2000 data or the 2012 data, not both at once
plot(str2double(LowIncomeCOD(find(str2double(LowIncomeCOD(1:158, 3))) > 0, 3)  ), '*');
plot(str2double(LowerMidCOD(find(str2double(LowerMidCOD(1:158, 3))) > 0, 3)  ), '.');
plot(str2double(UpperMidCOD(find(str2double(UpperMidCOD(1:158, 3))) > 0, 3)  ), '.');
plot(str2double(HighIncomeCOD(find(str2double(HighIncomeCOD(1:158, 3))) > 0, 3)  ), 'o');
title('Causes of Death in Low, Lower Middle, Uppper Middle and High Income Countries in 2000');
legend('lower income', 'lower mid income', 'upper mid income', 'high income');
ylabel('deaths per 10 000 population');
xlabel('cause, too many to display at this moment');

print('intial','-dpng','-r300'); 
%% work in progress
% threshold value for significant deaths per 10 000 population needs to be
% determined
[row, column] = size(HighIncomeCOD);
low = ones(row, 1);
lmid= ones(row, 1)*2;
umid = ones(row, 1)*3;
high = ones(row, 1)*4;

%obj = fitcdiscr([str2double(LowCOD(:, 3)); 
%    str2double(LowerMidCOD(:, 3)); 
%    str2double(UpperMidCOD(:, 3)); str2double(HighIncomeCOD(:, 3))],  [low; lmid; umid; high])

%%
% 2012
[sorted,sortedIndex] = sort(str2double(HighIncomeCOD(159:316, 3)),'descend');
HighSortValueIndices = sortedIndex(1:10);

[sorted,sortedIndex] = sort(MidIncomeCOD(159:316),'descend');
MidSortValueIndices = sortedIndex(1:10);

[sorted,sortedIndex] = sort(str2double(LowIncomeCOD(159:316, 3)),'descend');
LowSortValueIndices = sortedIndex(1:10);

TopDeathIndex = unique([HighSortValueIndices; MidSortValueIndices; LowSortValueIndices]);

%cod(:, 1) = HighIncomeCOD(TopDeathIndex, 2);
%cod(:, 2) = HighIncomeCOD(TopDeathIndex, 3);
%cod(:, 3) = MidIncomeCOD(TopDeathIndex, 3);
%cod(:, 4) = LowIncomeCOD(TopDeathIndex);

%%
stddev2000=[1:3, 5:158];
stddev2012=[159:161, 163:316]; 
% removed 'all causes'

figure;
hold on;
% [1, 2, 4, 6, 7] are some of the top communicable\infectious diseases


errorlow = std(str2double(LowIncomeCOD(stddev2012, 3)) );
errorbar(str2double(LowIncomeCOD(TopDeathIndex, 3)), errorlow*ones(size(TopDeathIndex)), 'rs-');

errormid = std(MidIncomeCOD(stddev2012) );
errorbar(MidIncomeCOD(TopDeathIndex), errormid*ones(size(TopDeathIndex)), 'b^-');

errorhigh = std(str2double(HighIncomeCOD(stddev2012, 3)) );
errorbar(str2double(HighIncomeCOD(TopDeathIndex, 3)), errorhigh*ones(size(TopDeathIndex)), 'go-');

set(gca,'xdir','reverse')
ax = gca;
ax.XTick = [1:numel(TopDeathIndex)];
set(gca,'XTickLabel',LowIncomeCOD(TopDeathIndex, 2))
ax.XTickLabelRotation=30;
legend('Low Income Countries', 'Mid-Income Countries', 'High Income Countries');
ylabel('Deaths per 100,000 Population');

%print('top16','-dpng','-r300'); 
% print 300dpi figure for report/presentation