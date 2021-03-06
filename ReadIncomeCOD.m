function [IncomeCOD] = ReadIncomeCOD(IncomeCOD, year)

IncomeCOD = sortrows(IncomeCOD, 'Causes', 'ascend');
IncomeCOD = sortrows(IncomeCOD, 'Year', 'ascend');

% this could be written as a function
IncomeCOD = IncomeCOD(strcmp(table2array(IncomeCOD(:, 'Year')), year), :);
IncomeCOD = IncomeCOD(strcmpi(table2array(IncomeCOD(:, 'Sex')), 'Both sexes'), :);
IncomeCOD = IncomeCOD(:, {'Year', 'Causes', 'Numeric'});
IncomeCOD = table2array(IncomeCOD);
% finds data for both sexes and all ages, death per 100 000


