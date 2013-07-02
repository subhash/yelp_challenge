function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for linear regression with regularization

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta


h = X * theta;
square_error = (h - y) .^ 2;
J = (1/(2*m))*(sum(square_error) + lambda*sum(theta(2:end).^2));
grad = ((X' * (h - y))./m) + ((lambda/m)*[0; theta(2:end)]);




% =============================================================

end
