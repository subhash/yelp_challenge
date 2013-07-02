function [X, y_rev_c, y_ave_s, y_funny, y_useful, y_cool] = select_user_features(user, user_matrix)
%SELECTFEATURES Find suitable features to use for training
	% 	(1) review count	(2) stars-mean	(3) funny-mean	(4) useful-mean	(5) cool-mean	
	% 	(6) stars-sum		(7) funny-sum	(8) useful-sum	(9) cool-sum
	
	%X = user_matrix(:, [1, 2, 3, 4, 5]);
	%[y_rev_c, y_ave_s, y_funny, y_useful, y_cool] = select_y(user);
	
	X = user_matrix(:, [1, 2]);
	[y_rev_c, y_ave_s] = select_y(user);
	
	% valid = all(!isnan(X), 2);

end

function [y_rev_c, y_ave_s] = select_y(user)		
	y_rev_c = cell2mat({cell2mat(user).review_count}');
	y_ave_s = cell2mat({cell2mat(user).average_stars}');
	#{
	votes = {cell2mat(user).votes};
	y_funny = [cell2mat(votes).funny]';
	y_useful = [cell2mat(votes).useful]';
	y_cool = [cell2mat(votes).cool]';
	#}
end
