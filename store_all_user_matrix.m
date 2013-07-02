tic
all_review = [ rmfield(cell2mat(review), 'votes') ; cell2mat(test_review') ];
all_review = mat2cell(all_review, ones(1, size(all_review, 1)), ones(1, size(all_review, 2)));
all_user = [ rmfield(cell2mat(user), 'votes') ; cell2mat(test_user') ];
all_user = mat2cell(all_user, ones(1, size(all_user, 1)), ones(1, size(all_user, 2)));

ruid = {cell2mat(all_review).user_id};
uuid = {cell2mat(all_user).user_id};
missing_user_ids = setdiff( ruid, uuid );
[all_missing_users, all_actual_users] = find_user_matrix(missing_user_ids, all_review, ruid, all_user, uuid)
save all_user_matrix.mat all_missing_users all_actual_users;
toc
