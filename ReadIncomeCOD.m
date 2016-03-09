function [IncomeCOD] = ReadIncomeCOD(IncomeCOD)

IncomeCOD = sortrows(IncomeCOD,'Causes','ascend');
IncomeCOD = sortrows(IncomeCOD, 'Year', 'ascend');

% this could be written as a function
IncomeCOD = table2array(IncomeCOD);
IncomeCOD = IncomeCOD(strcmpi(IncomeCOD(:, 5), 'Both sexes'), :);
% finds data for both sexes and all ages, death per 100 000
IncomeCOD = IncomeCOD(:, [3, 7, 9]);

%x = strcmpi(LowerMidCOD(:, 2), UpperMidCOD(:, 2)) & strcmpi(LowerMidCOD(:, 1), UpperMidCOD(:, 1));
%verified data sorted correctly with disease and year
