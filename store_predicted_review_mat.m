function [predicted_users, predicted_review_mat] = store_predicted_review_mat(review_mat, review, user, actual_users, missing_users, missing_user_id)
	tic;
	predicted_users = predict_users(user, actual_users, missing_users);
	[predicted_review_mat] = rewrite_review_mat(review_mat, review, user, actual_users, missing_users, missing_user_id, predicted_users);
	% save predicted_review_mat.mat predicted_review_mat predicted_users;
	toc;
end

function [new_review_mat] = rewrite_review_mat(review_mat, review, user, actual_users, missing_users, missing_user_id, predicted_users)
	
	review_user_id = {cell2mat(review).user_id};
	% user_id = {cell2mat(user).user_id};
	% missing_user_id = setdiff(review_user_id, user_id);
	
	[m,n] = size(review_mat);
	new_review_mat = zeros(m,n);
	for i = 1:m
		new_review_mat(i, :) = review_mat(i,:);
		f = ismember(missing_user_id, review_user_id(i){1});
		if(sum(f))
			pred = predicted_users(find(f), :);
			new_review_mat(i,7) = pred(2);
		else
			if(isnan(review_mat(i,7)))
				fprintf("Something went wrong!\n");
				review_user_id(i){1}
			endif
		endif
	end
end


function [pred] = predict_users(user, actual_users, missing_users)
	[X, y_rev_c, y_ave_s, y_funny, y_useful, y_cool] = select_user_features(user, actual_users);
	[X_norm, mu, sigma] = normalize_features(X);
	
	% X_pred = missing_users(:, 1:5);
	X_pred = missing_users(:, 1:2);
	X_pred = [ones(size(missing_users, 1), 1) scale_features(X_pred, mu, sigma)];
	
	fprintf("\nPredicting user review count\n");
	theta_rev_c = optimize(X_norm, y_rev_c);
	pred_rev_c = X_pred * theta_rev_c;
		
	fprintf("\nPredicting user average stars\n");
	theta_ave_s = optimize(X_norm, y_ave_s);
	pred_ave_s = X_pred * theta_ave_s;
	
	#{
	fprintf("\nPredicting user funny \n");
	theta_funny = optimize(X, y_funny);
	pred_funny = X_pred * theta_funny;

	fprintf("\nPredicting user useful \n");
	theta_useful = optimize(X, y_useful);
	pred_useful = X_pred * theta_useful;

	fprintf("\nPredicting user cool \n");
	theta_cool = optimize(X, y_cool);
	pred_cool = X_pred * theta_cool;	
	
	pred = [pred_rev_c pred_ave_s pred_funny pred_useful pred_cool];
	#}
	
	pred = [pred_rev_c pred_ave_s];
	
end