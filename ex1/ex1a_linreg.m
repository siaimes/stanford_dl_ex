%
%This exercise uses a data from the UCI repository:
% Bache, K. & Lichman, M. (2013). UCI Machine Learning Repository
% http://archive.ics.uci.edu/ml
% Irvine, CA: University of California, School of Information and Computer Science.
%
%Data created by:
% Harrison, D. and Rubinfeld, D.L.
% ''Hedonic prices and the demand for clean air''
% J. Environ. Economics & Management, vol.5, 81-102, 1978.
%
clear

% Using functions
% functions = [false, false];
% functions = [true, false];
functions = [false, true];
% functions = [true, true];

addpath ../common
addpath ../common/minFunc_2012/minFunc
addpath ../common/minFunc_2012/minFunc/compiled

% Load housing data from file.
data = load('housing.data');
data=data'; % put examples in columns

% Include a row of 1s as an additional intercept feature.
data = [ ones(1,size(data,2)); data ];

% Shuffle examples.
data = data(:, randperm(size(data,2)));

% Split into train and test sets
% The last row of 'data' is the median home price.
train.X = data(1:end-1,1:400);
train.y = data(end,1:400);

test.X = data(1:end-1,401:end);
test.y = data(end,401:end);

m=size(train.X,2);
n=size(train.X,1);

options = struct('MaxIter', 200);

% Run the minFunc optimizer with linear_regression.m as the objective.
%
% TODO:  Implement the linear regression objective and gradient computations
% in linear_regression.m
%
% Set functions(1) as true to run your looping over code.
if functions(1) == true
    % Initialize the coefficient vector theta to random values.
    theta = rand(n,1);
%     % Gradient Checking
%     average_error = grad_check(@linear_regression, theta, train.X, train.y)
    tic;
    theta = minFunc(@linear_regression, theta, options, train.X, train.y);
    time1 = toc;
end

% Run minFunc with linear_regression_vec.m as the objective.
%
% TODO:  Implement linear regression in linear_regression_vec.m
% using MATLAB's vectorization features to speed up your code.
% Compare the running time for your linear_regression.m and
% linear_regression_vec.m implementations.
%
% Set functions(2) as true to run your vectorized code.
if functions(2) == true
    % Initialize the coefficient vector theta to random values.
    theta = rand(n,1);
%     % Gradient Checking
%     average_error = grad_check(@linear_regression_vec, theta, train.X, train.y)
    tic;
    theta = minFunc(@linear_regression_vec, theta, options, train.X, train.y);
    time2 = toc;
end

% print the running time.
if exist('time1','var') && exist('time2','var')
    fprintf('Optimization took %f %f seconds respectively.\n', time1, time2);
elseif exist('time1','var')
    fprintf('Optimization took %f seconds.\n', time1);
elseif exist('time2','var')
    fprintf('Optimization took %f seconds.\n', time2);
else
    error('arg errer!');
end

% Plot predicted prices and actual prices from training set.
actual_prices = train.y;
predicted_prices = theta'*train.X;

% Print out root-mean-squared (RMS) training error.
train_rms=sqrt(mean((predicted_prices - actual_prices).^2));
fprintf('RMS training error: %f\n', train_rms);

% Print out test RMS error
actual_prices = test.y;
predicted_prices = theta'*test.X;
test_rms=sqrt(mean((predicted_prices - actual_prices).^2));
fprintf('RMS testing error: %f\n', test_rms);


% Plot predictions on test data.
plot_prices=true;
if (plot_prices)
  [actual_prices,I] = sort(actual_prices);
  predicted_prices=predicted_prices(I);
  plot(actual_prices, 'rx');
  hold on;
  plot(predicted_prices,'bx');
  legend('Actual Price', 'Predicted Price');
  xlabel('House #');
  ylabel('House price ($1000s)');
end