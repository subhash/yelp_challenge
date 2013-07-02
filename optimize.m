function [theta, cost, trj, vj] = optimize(X, y)
	
	[m, n] = size(X);
	
	% Add intercept term 
	X = [ones(m, 1) X];

	[X, y, Xval, yval, Xtest, ytest] = divide(X, y);
	
	% Selected values of lambda (you should not change this)
	lambda_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10]';
	
	theta_vec = zeros(n+1, length(lambda_vec));
	cost_vec = zeros(length(lambda_vec), 1);
	
	for i = 1:length(lambda_vec)
		lambda = lambda_vec(i);
		theta_vec(:, i) = train_linear_reg(X, y, lambda, m, n);
		cost_vec(i) = cost_function(theta_vec(:,i), Xval, yval, lambda);
		%cost_vec(i) = costFunctionReg(theta_vec(:, i), Xval, yval, lambda);
		%cost_vec(i) = abs(mean(Xval * theta_vec(:,i) - yval));
	end
	
	[cost_v, idx] = min(cost_vec);
	theta = theta_vec(:, idx);
	cost_t = cost_function(theta, Xtest, ytest, lambda_vec(idx));
	
	trj = costFunctionReg(theta, X, y, lambda_vec(idx));
	vj = costFunctionReg(theta, Xval, yval, lambda_vec(idx)); 
		
  	fprintf("%d X %d - vcost = %f, tcost = %f\n", m, n, cost_v, cost_t);

end



function [theta, cost] = train_linear_reg(X, y, lambda, m, n)
	% Initialize fitting parameters
	initial_theta = zeros(n + 1, 1);
	
	% Compute and display initial cost and gradient
	[cost, grad] = costFunctionReg(initial_theta, X, y, lambda);
	
	%  Set options for fminunc
	options = optimset('GradObj', 'on', 'MaxIter', 400);
	
	%  Run fminunc to obtain the optimal theta
	%  This function will return theta and the cost 
	[theta, cost] = ...
		fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);
end



function [Xtrain, ytrain, Xval, yval, Xtest, ytest] = divide(X, y)
	rows = size(X, 1);
	train_n = floor(rows * 0.6);
	valid_n = floor(rows * 0.8);
	
	Xtrain = X(1 : train_n,:);
	Xval = X((train_n + 1) : valid_n,:);
	Xtest = X((valid_n + 1) : end,:);
	
	ytrain = y(1 : train_n,:);
	yval = y((train_n + 1) : valid_n,:);
	ytest = y((valid_n + 1) : end,:);
end


function [c] = cost_function(theta, X, y, lambda)
	m = size(y, 1);
	err = X*theta - y;
	reg = sum(theta(2:end).^2);
	c = ( 1/(2*m) ) * ( sum(err.^2) + (lambda * reg) );
end

function [c] = log_cost_function(theta, X, y, lambda)
	m = size(y,1);
	h = X*theta;
	error = sum((log(h.+1) - log(y.+1)).^2);
	c = (1/m)*sqrt(error);
end

