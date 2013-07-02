function [pred] = find_predictions(data, theta)
	[X, y] = select_features(data);
	X_norm = normalize_features(X);
	X_norm = [ones(size(X_norm,1), 1) X_norm];
	pred = X_norm * theta;
end