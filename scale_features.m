function [X_scaled] = scale_features(X, mu, sigma)
	% mean_norm  = repmat(mu, size(X,1), 1);
	% std_norm = repmat(sigma, size(X,1), 1);
	% X_scaled = (X-mean_norm)./std_norm;
	
	X_scaled = bsxfun(@minus, X, mu);
	X_scaled = bsxfun(@rdivide, X_scaled, sigma);
end