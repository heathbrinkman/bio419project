function compiledCOD = compiledCOD(lowCOD, midCOD, highCOD)
compiledCOD(:, 1) = lowCOD(:, 2);
compiledCOD(:, 2) = num2cell(str2double(lowCOD(:, 3)));
compiledCOD(:, 3) = num2cell(midCOD(:, 1));
compiledCOD(:, 4) = num2cell(str2double(highCOD(:, 3)));