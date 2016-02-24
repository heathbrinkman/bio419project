%% Initial read data
CountryIncome = readtable('CountryIncome.csv', 'HeaderLines', 1);

WaterCountry = readtable('WaterIncome.csv');


%% 
wateryear = table2array(WaterCountry(2:height(WaterCountry), 2));
wateryear = str2double(wateryear);
%this picks out the year column of the water sorted by country data

Water2015 = WaterCountry((find(wateryear ==2015)+1), [1, 5, 8]);
%this picks out the year of 2015's water data, percentage of people using
%improved drinking water and sanitation

%% Find water data that has matching income data
% this section runs quite slow, any suggestions?
hasincome = zeros(height(CountryIncome), 1);
income = cell(height(CountryIncome), 1);
for i = 1:height(CountryIncome),
    countryname = table2array(CountryIncome(i, 1));
    for c = 1:height(Water2015),
        if strcmpi(countryname, table2array(Water2015(c, 1)) ) == 1,
            % this line no longer used //hasincome(i, 1) = 1;
            hasincome(i) = c;
            income(i) = table2array(CountryIncome(i, 4));
            %index of water countries that has income data
            c = height(Water2015); % stop this loop
        end;
    end;
end;
income(find(hasincome == 0)) = [];
hasincome = hasincome(find(hasincome ~= 0));
%% 
WaterIncome2015 = Water2015(hasincome, :);
WaterIncome2015 = table2array(WaterIncome2015);
WaterIncome2015(:, 4) = income;
%%
[row, column] = size(WaterIncome2015);
delcount = 0;
for i = 1:row, %height(WaterIncome2015)
    if strcmpi(WaterIncome2015(i, 3), '') | strcmpi(WaterIncome2015(i, 2), '') % find empty data
    	delcount = delcount + 1;
        waterdel(delcount) = i;
        %mark for deletion
    end
end

WaterIncome2015(waterdel, :) = []; % delete rows missing data
%% sort data into income group and calculate group water status

[row, column] = size(WaterIncome2015);
WaterHigh = zeros(row, 2);
WaterMid = zeros(row, 2);
WaterLow = zeros(row, 2);

for i = 1:row,
    if strcmpi(WaterIncome2015(i, 4), 'High'),
        WaterHigh(i, 1) = str2double(WaterIncome2015(i, 2));
        WaterHigh(i, 2) = str2double(WaterIncome2015(i, 3));
    elseif strcmpi(WaterIncome2015(i, 4), 'Middle'),
        WaterMid(i, 1) = str2double(WaterIncome2015(i, 2));
        WaterMid(i, 2) = str2double(WaterIncome2015(i, 3));
    elseif strcmpi(WaterIncome2015(i, 4), 'Low'),
        WaterLow(i, 1) = str2double(WaterIncome2015(i, 2));
        WaterLow(i, 2) = str2double(WaterIncome2015(i, 3));
    end
end

% delete empty rows
WaterLow(all(WaterLow==0, 2),:)=[];
WaterMid(all(WaterMid==0, 2),:)=[];
WaterHigh(all(WaterHigh==0, 2),:)=[];

%% Mean of Income Groups
watermean = [mean(WaterLow(:, 1)), mean(WaterLow(:, 2)); 
    mean(WaterMid(:, 1)), mean(WaterMid(:, 2)); 
    mean(WaterHigh(:, 1)), mean(WaterHigh(:, 2)) ];

%% Simple Bar Graph
figure;
hold on;
bar(watermean);
ylabel('% Population');
legend('Improved Drinking Water', 'Improved Sanitation');
set(gca,'XTickLabel',{'', 'Low Income Countries', '', 'Mid-Income Countries', '', 'High Income Countries'})


