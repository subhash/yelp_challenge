function [missing_users, actual_users] = find_user_matrix(muid, review, review_user_id, user, user_id)
	mu_reviews = cellfun(@(x) find_review(x, review, review_user_id), muid, "UniformOutput", false);
	mu_matrix = extract_user_matrix(mu_reviews);
	
	au_reviews = cellfun(@(x) find_review(x, review, review_user_id), user_id, "UniformOutput", false);
	au_matrix = extract_user_matrix(au_reviews);
	
	missing_users = mu_matrix;
	actual_users = au_matrix;
end
	
	
function [pred] = predict_users(mu_matrix, au_matrix)	
	% Should I include mu_matrix to find scaling params?
	[~, mu, sigma] = normalize_features( au_matrix );
	X = scale_features(au_matrix, mu, sigma);
	
	y_rev_c = cell2mat({cell2mat(user).review_count}');
	y_ave_s = cell2mat({cell2mat(user).average_stars}');
	
	X_pred = [ones(size(mu_matrix, 1), 1) scale_features(mu_matrix, mu, sigma)];
	
	fprintf("Predicting review count \n");
	theta_rev_c = optimize(X, y_rev_c);
	pred_rev_c = X_pred * theta_rev_c;

	fprintf("Predicting average stars \n");
	theta_ave_s = optimize(X, y_ave_s);
	pred_ave_s = X_pred * theta_ave_s;

	votes = {cell2mat(user).votes};
	y_funny = [cell2mat(votes).funny]';
	y_useful = [cell2mat(votes).useful]';
	y_cool = [cell2mat(votes).cool]';
	
	fprintf("Predicting funny \n");
	theta_funny = optimize(X, y_funny);
	fprintf("Predicting useful \n");
	theta_useful = optimize(X, y_useful);
	fprintf("Predicting cool \n");
	theta_cool = optimize(X, y_cool);
	
	pred_funny = X_pred * theta_funny;
	pred_useful = X_pred * theta_useful;
	pred_cool = X_pred * theta_cool;
	
	pred = [pred_rev_c pred_ave_s pred_funny pred_useful pred_cool];
end

function [m] = extract_user_matrix(rhash)

	c = cellfun(@(x) extract_user_row(x), rhash, "UniformOutput", false);
	m = cell2mat(c');
end

function [row] = extract_user_row(reviews)
	r = cell2mat(reviews);
	stars = cell2mat({r.stars});
	%votes = cell2mat({r.votes});
	%funny = cell2mat({votes.funny});
	%useful = cell2mat({votes.useful});
	%cool = cell2mat({votes.cool});
	%row = [size(r, 1) mean(stars) mean(funny) mean(useful) mean(cool) sum(stars) sum(funny) sum(useful) sum(cool)];
	row = [size(r, 1) mean(stars) ];
end

