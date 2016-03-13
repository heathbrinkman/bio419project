%%
% read from file
LowIncomeCOD = readtable('CauseOfDeathLow.csv');
LowerMidCOD = readtable('CauseOfDeathLowerMid.csv');
UpperMidCOD = readtable('CauseOfDeathUpperMid.csv');
HighIncomeCOD = readtable('CauseOfDeathHigh.csv');

%%
% pull death cause of both sexes, 2000 and 2010
year = '2012'; %or 2000
LowIncomeCOD = ReadIncomeCOD(LowIncomeCOD, year);
LowerMidCOD = ReadIncomeCOD(LowerMidCOD, year);
UpperMidCOD = ReadIncomeCOD(UpperMidCOD, year);
HighIncomeCOD = ReadIncomeCOD(HighIncomeCOD, year);
% mean of each cause in lower and upper middle income countries
MidIncomeCOD = (str2double(LowerMidCOD(:, 3)) + str2double(UpperMidCOD(:, 3)) )/2;


%%
% intial visual comparison of data
figure;
hold on;
plot(str2double(LowIncomeCOD(find(str2double(LowerMidCOD(:, 3))) > 0, 3)  ), '.');
plot(str2double(LowerMidCOD(find(str2double(LowerMidCOD(:, 3))) > 0, 3)  ), '^');
plot(str2double(UpperMidCOD(find(str2double(LowerMidCOD(:, 3))) > 0, 3)  ), '^');
plot(str2double(HighIncomeCOD(find(str2double(LowerMidCOD(:, 3))) > 0, 3)  ), 'o');
title('Causes of Death in Low, Lower Middle, Uppper Middle and High Income Countries in 2000');
legend('lower income', 'lower mid income', 'upper mid income', 'high income');
ylabel('deaths per 10 000 population');
xlabel('cause, too many to display at this moment');

print('intial','-dpng','-r300'); 
%%
% 2012
[sorted,sortedIndex] = sort(str2double(HighIncomeCOD(:, 3)),'descend');
HighSortValueIndices = sortedIndex(1:10);

[sorted,sortedIndex] = sort(MidIncomeCOD,'descend');
MidSortValueIndices = sortedIndex(1:10);

[sorted,sortedIndex] = sort(str2double(LowIncomeCOD(:, 3)),'descend');
LowSortValueIndices = sortedIndex(1:10);

TopDeathIndex = unique([HighSortValueIndices; MidSortValueIndices; LowSortValueIndices]);

%cod(:, 1) = HighIncomeCOD(TopDeathIndex, 2);
%cod(:, 2) = HighIncomeCOD(TopDeathIndex, 3);
%cod(:, 3) = MidIncomeCOD(TopDeathIndex, 3);
%cod(:, 4) = LowIncomeCOD(TopDeathIndex);

%%
stddev=[1:3, 5:158];
% removed 'all causes'
% the stddev still will be inflated a little bit but the difference is
% still significant for the causes we are looking at

figure;
hold on;
% [1, 2, 4, 6, 7] are some of the top communicable\infectious diseases


errorlow = std(str2double(LowIncomeCOD(stddev, 3)) );
errorbar(str2double(LowIncomeCOD(TopDeathIndex, 3)), errorlow*ones(size(TopDeathIndex)), 'rs-');

errormid = std(MidIncomeCOD(stddev) );
errorbar(MidIncomeCOD(TopDeathIndex), errormid*ones(size(TopDeathIndex)), 'b^-');

errorhigh = std(str2double(HighIncomeCOD(stddev, 3)) );
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
%% Bar graph of sorted COD
figure;
hold on;
totalCOD = compiledCOD(LowIncomeCOD, MidIncomeCOD, HighIncomeCOD);
totalCOD = flip(sortrows(totalCOD, 2));
bar(cell2mat(totalCOD(2:17, 2:4)));

ax = gca;
ax.XTick = [1:16];
set(gca,'XTickLabel',totalCOD(2:17, 1));
ax.XTickLabelRotation=40;
title('Top 16 Causes of Death in Low, Middle and High Income Countries');
legend('Low Income Countries', 'Mid-Income Countries', 'High Income Countries');
ylabel('Deaths per 100,000 Population');
