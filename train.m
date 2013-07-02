

tic;

review_matrix = review_mat;
review_rows = size(review_matrix, 1);
train_n = floor(review_rows * 0.6);
valid_n = floor(review_rows * 0.8);
training = review_matrix(1 : train_n,:);
validation = review_matrix((train_n + 1) : valid_n,:);
testing = review_matrix((valid_n + 1) : end,:);


[X, y] = select_features(training);

X_norm = normalize_features(X, mean(X), std(X));




% plot(X(:,6), y(:),'rx','MarkerSize',10); 
% stars, breview, bstars, ustars, ureview, uuseful
% xlabel('U useful votes');
% ylabel('Useful votes');


%% ============ Part 2: Compute Cost and Gradient ============
%  In this part of the exercise, we will implement the cost and gradient
%  for linear regression

%  Setup the data matrix appropriately, and add ones for the intercept term
[m, n] = size(X_norm);

% Add intercept term 
X_norm = [ones(m, 1) X_norm];

% Initialize fitting parameters
initial_theta = zeros(n + 1, 1);

lambda = 0.1;

% Compute and display initial cost and gradient
[cost, grad] = costFunctionReg(initial_theta, X_norm, y, lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);

%fprintf('\nProgram paused. Press enter to continue.\n');
%pause;


%% ============= Part 3: Optimizing using fminunc  =============
%  In this exercise, we will use a built-in function (fminunc) to find the
%  optimal parameters theta.

%  Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  Run fminunc to obtain the optimal theta
%  This function will return theta and the cost 
[theta, cost] = ...
	fminunc(@(t)(costFunctionReg(t, X_norm, y, lambda)), initial_theta, options);

% Print theta to screen
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('theta: \n');
fprintf(' %f \n', theta);


% Compute accuracy on our training set


fprintf('Train Accuracy: %f\n', find_accuracy(training, theta));
fprintf('Validation Accuracy: %f\n', find_accuracy(validation, theta));
fprintf('Testing Accuracy: %f\n', find_accuracy(testing, theta));

test_matrix = test_review_mat;
test_matrix(:, 13:15) = zeros(size(test_matrix,1), 3);
fprintf('Testset predictions: \n');
p = find_predictions(test_matrix, theta);


toc;
