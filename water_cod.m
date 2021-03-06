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
             Water(i, 7) = CountryIncome(a, 3);
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
y1 = str2double(Water(:, 5));
[fitresult1, gof1] = fit( x, y1, 'poly1', 'Robust', 'Bisquare' );
[fitresult2, gof2] = fit( x, y1, 'poly2', 'Robust', 'Bisquare' );

plot(x, y1, 'r.');
plot(fitresult1, 'm-');
plot(fitresult2);

SanitationError = polyError([x, y1], 'poly2', 20, 0.2);
SanitationErrorLinear = polyError([x, y1], 'poly1', 20, 0.2);

x = str2double(Water(:, 2));
y1 = str2double(Water(:, 5));
[fitresult, gof] = fit( x, y1, 'poly2', 'Robust', 'Bisquare' );

plot(x, y1, 'b.');
plot(fitresult, 'b-');

WaterError = polyError([x, y1], 'poly2', 20, 0.2);
display(abs([SanitationError, SanitationErrorLinear, WaterError]), 'Sanitation Poly2 fit error, sanitation linear error, water poly2 error');

title('Communicable Diseases Death vs. % Improved Water and Sanitation');
legend('Sanitation', 'linear bisquare fit', 'poly 2 bisquare fit', 'poly 2 bisquare fit');
xlabel('Percentage Population Using Improved Drinking Water and Sanitation');
ylabel('Deaths per 100,000 Population from Communicable Diseases');
%print('drinking_water_death_trend','-dpng','-r300');
%% Relationship between income and water quality/sanitation
figure;
hold on;
for i = 1:size(Water, 1) %removes the spaces from the income strings
    Water{i, 7}(Water{i, 7}== ' ') = '';
end;
x = log(str2double(Water(:, 7)));
y1 = str2double(Water(:, 3));
y2 = str2double(Water(:, 2));
plot(x, y1, 'r.', x, y2, 'b.');
[logFitSan, gof1] = fit(x, y1, 'poly1');
[logFitWater, gof2] = fit(x, y2, 'poly1');
plot(logFitSan);
plot(logFitWater, 'b');
title('Country Income vs. % Improved Water and Sanitation');
xlabel('Gross National Income per Capita (USD)(Log Scale)');
ylabel('Percent Population With Access to Improved Water/Sanitation');
legend('Sanitation', 'Improved Water', 'Log Fit Sanitation', 'Log Fit Water');

%% PCA of Income, Water, Sanitation and Communicable Disease Death Rate
[coeff, score, latent] = pca(str2double(Water(:, [2, 3, 5, 7])));
figure; 
plot(score(:, 1), score(:, 2), '.'); 
xlabel('pc1'); ylabel('pc2'); 
title('Data Projected onto the Principal Component Directions'); 
axis equal; 
grid on;



