function [X_norm, mu, sigma] = normalize_features(X)
	mu = mean(X);
	sigma = std(X);
	
	mean_norm  = repmat(mu, size(X,1), 1);
	std_norm = repmat(sigma, size(X,1), 1);
	
	X_norm = (X-mean_norm)./std_norm;
end