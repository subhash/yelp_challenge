	tic;
	
	[X, y] = select_features(predicted_review_mat);
	[X_norm, mu, sigma] = normalize_features(X);
	theta = optimize(X_norm, y);
	
	Xpred = select_features(test_predicted_review_mat);
	Xpred = [ones(size(Xpred,1),1) scale_features(Xpred, mu, sigma)];
	pred = Xpred * theta;
	

	% dimensions
	% predict other user features
	% use text features?
	
	toc;


