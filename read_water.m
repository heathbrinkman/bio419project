function [watermean, watererror] = read_water(year);
%% Initial read data
CountryIncome = readtable('CountryIncome.csv', 'HeaderLines', 1);
WaterCountry = readtable('WaterIncome.csv');

%% 
wateryear = table2array(WaterCountry(2:height(WaterCountry), 2));
wateryear = str2double(wateryear);
%this picks out the year column of the water sorted by country data

Water = table2array(WaterCountry((find(wateryear == year)+1), [1, 5, 8]) );
%this picks out the year of xxxx's water data, percentage of people using
%improved drinking water and sanitation


%% Find water data that has matching income data
% solved//this section runs quite slow
haveincome = zeros(height(CountryIncome), 1);
income = cell(height(CountryIncome), 1);
countrynames = table2array(CountryIncome(:, 1));
[row, column] = size(Water);
for i = 1:height(CountryIncome),
    for c = 1:row,
        if strcmpi(countrynames(i), Water(c, 1) ) == 1,
            haveincome(i) = c;
            income(i) = table2array(CountryIncome(i, 4));
            %index of water countries that has income data
            break;
            %c = height(Water2015); % stop this loop
        end;
    end;
end;
income(find(haveincome == 0)) = [];
haveincome = haveincome(find(haveincome ~= 0));

WaterIncome = Water(haveincome, :);
WaterIncome(:, 4) = income;
%%
[row, column] = size(WaterIncome);
delcount = 0;
for i = 1:row, %height(WaterIncome2015)
    if strcmpi(WaterIncome(i, 3), '') | strcmpi(WaterIncome(i, 2), '') % find empty data
    	delcount = delcount + 1;
        waterdel(delcount) = i;
        %mark for deletion
    end
end

WaterIncome(waterdel, :) = []; % delete rows missing data
%% sort data into income group and calculate group water status

[row, column] = size(WaterIncome);
WaterHigh = zeros(row, 2);
WaterMid = zeros(row, 2);
WaterLow = zeros(row, 2);

for i = 1:row,
    if strcmpi(WaterIncome(i, 4), 'High'),
        WaterHigh(i, 1) = str2double(WaterIncome(i, 2));
        WaterHigh(i, 2) = str2double(WaterIncome(i, 3));
    elseif strcmpi(WaterIncome(i, 4), 'Middle'),
        WaterMid(i, 1) = str2double(WaterIncome(i, 2));
        WaterMid(i, 2) = str2double(WaterIncome(i, 3));
    elseif strcmpi(WaterIncome(i, 4), 'Low'),
        WaterLow(i, 1) = str2double(WaterIncome(i, 2));
        WaterLow(i, 2) = str2double(WaterIncome(i, 3));
    end
end

% delete empty rows
WaterLow(all(WaterLow==0, 2),:)=[];
WaterMid(all(WaterMid==0, 2),:)=[];
WaterHigh(all(WaterHigh==0, 2),:)=[];

watererror = [std(WaterLow); std(WaterMid); std(WaterHigh)];

%% Mean of Income Groups
watermean = [mean(WaterLow(:, 1)), mean(WaterLow(:, 2)); 
    mean(WaterMid(:, 1)), mean(WaterMid(:, 2)); 
    mean(WaterHigh(:, 1)), mean(WaterHigh(:, 2)) ];
% this is the output
%% Simple Bar Graph
% removed from function, plot in main script instead
%%

