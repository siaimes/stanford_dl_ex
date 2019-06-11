clear

% Using functions
% functions = [false, false];
% functions = [true, false];
functions = [false, true];
% functions = [true, true];

addpath ../common
addpath ../common/minFunc_2012/minFunc
addpath ../common/minFunc_2012/minFunc/compiled

% Load the MNIST data for this exercise.
% train.X and test.X will contain the training and testing images.
%   Each matrix has size [n,m] where:
%      m is the number of examples.
%      n is the number of pixels in each image.
% train.y and test.y will contain the corresponding labels (0 or 1).
binary_digits = true;
[train,test] = ex1_load_mnist(binary_digits);

% Add row of 1s to the dataset to act as an intercept term.
train.X = [ones(1,size(train.X,2)); train.X]; 
test.X = [ones(1,size(test.X,2)); test.X];

% Training set dimensions
m=size(train.X,2);
n=size(train.X,1);

% Train logistic regression classifier using minFunc
options = struct('MaxIter', 100);

% Call minFunc with the logistic_regression.m file as the objective function.
%
% TODO:  Implement batch logistic regression in the logistic_regression.m file!
%
% Set functions(1) as true to run your looping over code.
if functions(1) == true
    % First, we initialize theta to some small random values.
    theta = rand(n,1)*0.001;
%     % Gradient Checking
%     average_error = grad_check(@logistic_regression, theta, train.X, train.y)
    tic;
    theta = minFunc(@logistic_regression, theta, options, train.X, train.y);
    time1 = toc;
end

% Now, call minFunc again with logistic_regression_vec.m as objective.
%
% TODO:  Implement batch logistic regression in logistic_regression_vec.m using
% MATLAB's vectorization features to speed up your code.  Compare the running
% time for your logistic_regression.m and logistic_regression_vec.m implementations.
%
% Set functions(2) as true to run your vectorized code.
if functions(2) == true
    % First, we initialize theta to some small random values.
    theta = rand(n,1)*0.001;
%     % Gradient Checking
%     average_error = grad_check(@logistic_regression_vec, theta, train.X, train.y)
    tic;
    theta = minFunc(@logistic_regression_vec, theta, options, train.X, train.y);
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

% Print out training accuracy.
accuracy = binary_classifier_accuracy(theta,train.X,train.y);
fprintf('Training accuracy: %2.1f%%\n', 100*accuracy);

% Print out accuracy on the test set.
accuracy = binary_classifier_accuracy(theta,test.X,test.y);
fprintf('Test accuracy: %2.1f%%\n', 100*accuracy);

