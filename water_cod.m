CountryIncome = readtable('CountryIncome.csv', 'HeaderLines', 1);
WaterCountry = readtable('WaterIncome.csv');
CountryCOD = readtable('CountryCOD.csv', 'HeaderLines', 1);

CountryIncome = table2array(CountryIncome);
%% 
year = 2000; 
wateryear = table2array(WaterCountry(2:height(WaterCountry), 2));
wateryear = str2double(wateryear);
%this picks out the year column of the water sorted by country data

Water = table2array(WaterCountry(find(wateryear == year) + 1, [1, 5, 8]) );
%this picks out the year of xxxx's water data:
% country name, improved drinking water, and sanitation

codyear = table2array(CountryCOD(:, 2));
codyear = str2double(codyear);
if year == 2015,
    year = 2012;
end;
cod = table2array(CountryCOD(find(codyear == year), [1, 3, 4]) );
%%
[row, column] = size(Water);
[codrow, column] = size(cod);
[incomerow, column] = size(CountryIncome);

for i = 1:row,
    for c = 1:codrow,
        if strcmpi(Water(i, 1), cod(c, 1) ) == 1,
            Water(i, 4:5) = cod(c, 2:3);
            break;
        end;
    end;
    for a = 1:incomerow,
        if strcmpi(Water(i, 1), CountryIncome(a, 1) ) == 1,
             Water(i, 6) = CountryIncome(a, 4);
             break;
        end;
    end;
end;

%[row, column] = size(Water);
%delcount = 0;
%%
empty = any(cellfun('isempty', Water), 2);
Water(empty, :) = [];

%% 
figure;
hold on;

x = str2double(Water(:, 3));
y = str2double(Water(:, 5));
[fitresult, gof] = fit( x, y, 'poly2', 'Robust', 'Bisquare' );
% bisquare fit, good r2 value
plot(x, y, 'r.');
plot(fitresult);

x = str2double(Water(:, 2));
y = str2double(Water(:, 5));
[fitresult, gof] = fit( x, y, 'poly2', 'Robust', 'Bisquare' );

plot(x, y, 'b.');
plot(fitresult, 'b-');

title('Communicable Diseases Death vs. % Imporved Water and Sanitation');
legend('Sanitation', 'poly 2 bisquare fit', 'Drinking Water', 'poly 2 bisquare fit');
xlabel('Percentage Population Using Improved Drinking Water and Sanitation');
ylabel('Deaths per 100,000 Population from Communicable Diseases');
%print('drinking_water_death_trend','-dpng','-r300');
%%
