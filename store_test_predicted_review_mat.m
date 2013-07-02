all_review = [ rmfield(cell2mat(review), 'votes') ; cell2mat(test_review') ];
all_review = mat2cell(all_review, ones(1, size(all_review, 1)), ones(1, size(all_review, 2)));
all_user = [ rmfield(cell2mat(user), 'votes') ; cell2mat(test_user') ];
all_user = mat2cell(all_user, ones(1, size(all_user, 1)), ones(1, size(all_user, 2)));

ruid = {cell2mat(all_review).user_id};
uuid = {cell2mat(all_user).user_id};
missing_user_id = setdiff( ruid, uuid );


[all_predicted_users, test_predicted_review_mat] = store_predicted_review_mat(...
	test_review_mat, test_review, all_user, all_actual_users, all_missing_users, missing_user_id);
%save test_predicted_review_mat.mat all_predicted_users test_predicted_review_mat;
