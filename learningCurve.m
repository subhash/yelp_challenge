function [error_train, error_val] = learningCurve(X, y, lambda)

% Number of training examples
m = size(X, 1);

% You need to return these values correctly
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

for i = 10:m
  [~, ~, error_train(i), error_val(i)] = optimize_for_eval(X(1:i,:), y(1:i,:), lambda);
end

end
