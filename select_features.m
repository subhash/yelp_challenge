function [X, y] = select_features(review)
%SELECTFEATURES Find suitable features to use for training
	
	% 	(1) stars			(2) b_open		(3) b_review_count		(4) b_stars		(5) b_latitude 
	% 	(6) b_longitude 	(7) u_ave_stars (8) u_review_count 		(9) u_funny 	(10) u_useful 
	% 	(11) u_cool 		(12) c_checkins (13) funny 				(14) useful 	(15) cool
	
	%size(review)
	%review = review(all(!isnan(review), 2), :);
	%size(review)
	
	
	X = review(:, [1, 3, 4, 5, 6, 7]);
	y = review(:, 14);
	
	valid = all(!isnan(X), 2);
	X = X(valid, :);
	y = y(valid, :);
end