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

verifymatch = strcmpi( [LowIncomeCOD(:, 2), LowIncomeCOD(:, 2), LowIncomeCOD(:, 2)], [LowerMidCOD(:, 2), UpperMidCOD(:, 2), HighIncomeCOD(:, 2)]);
if all(verifymatch(:) == 1),
    display('Death causes match, data sorted correctly!');
end;
%verified data sorted correctly with disease, all groups match


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
%% sort top death causes
% 2012
[sorted,sortedIndex] = sort(str2double(HighIncomeCOD(:, 3)),'descend');
HighSortValueIndices = sortedIndex(1:10);

[sorted,sortedIndex] = sort(MidIncomeCOD,'descend');
MidSortValueIndices = sortedIndex(1:10);

[sorted,sortedIndex] = sort(str2double(LowIncomeCOD(:, 3)),'descend');
LowSortValueIndices = sortedIndex(1:10);

TopDeathIndex = unique([HighSortValueIndices; MidSortValueIndices; LowSortValueIndices]);

%% Bar graph of sorted COD, top 16
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
print('top_16_bar','-dpng','-r300');
%% top communicable diseases deaths
stddev=[1:3, 5:158];
% removed 'all causes'
% the stddev still will be inflated a little bit but the difference is
% still significant for the causes we are looking at

figure;
hold on;
Communicable = TopDeathIndex([3; 4; 7; 13; 14]);
errorlow = std(str2double(LowIncomeCOD(stddev, 3)) );
errorbar(str2double(LowIncomeCOD(Communicable, 3)), errorlow*ones(size(Communicable)), 'rs-');

errormid = std(MidIncomeCOD(stddev) );
errorbar(MidIncomeCOD(Communicable), errormid*ones(size(Communicable)), 'b^-');

errorhigh = std(str2double(HighIncomeCOD(stddev, 3)) );
errorbar(str2double(HighIncomeCOD(Communicable, 3)), errorhigh*ones(size(Communicable)), 'go-');

set(gca,'xdir','reverse')
ax = gca;
ax.XTick = [1:numel(Communicable)];
set(gca,'XTickLabel',LowIncomeCOD(Communicable, 2))
ax.XTickLabelRotation=15;
title('Top Communicable Diseases Deaths');
legend('Low Income Countries', 'Mid-Income Countries', 'High Income Countries');
ylabel('Deaths per 100,000 Population');
print('top_16_communicable','-dpng','-r300');