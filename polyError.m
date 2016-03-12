%% Finds the average error in a polynomial fit after a given number of iterations
% Takes an [x, y] data set, a polynomial degree, iterations, and a test
% fraction, and returns the average error in that type of model after
% random selection of test and training data over the given iterations. 
function averagePolyError = polyError(data, fitType, iterations, test_frac)
modelError = 0;
for i = 1:iterations
    permuted = randperm(numel(data(:,1)));
    test = permuted(1:floor(numel(data(:,1))*test_frac)); 
    train = permuted(ceil((numel(data(:,1))*test_frac)):end);
    regression = fit(data(train, 1), data(train, 2), fitType, 'Robust', 'Bisquare');
    for j = 1:size(test)
        modelError = modelError+((data(test(j), 2)-regression(j)).^2)/numel(test);
    end;
end;
averagePolyError = modelError/iterations;