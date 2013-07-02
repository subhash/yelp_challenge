tic

all_review = [ rmfield(cell2mat(review), 'votes') ; cell2mat(test_review') ];
all_review = mat2cell(all_review, ones(1, size(all_review, 1)), ones(1, size(all_review, 2)));
all_user = [ rmfield(cell2mat(user), 'votes') ; cell2mat(test_user') ];
all_user = mat2cell(all_user, ones(1, size(all_user, 1)), ones(1, size(all_user, 2)));

test_ruid = {cell2mat(all_review).user_id};
test_uuid = {cell2mat(all_user).user_id};
test_missing_user_ids = setdiff( test_ruid, test_uuid );
[test_missing_users, test_actual_users] = find_user_matrix(test_missing_user_ids, all_review, test_ruid, all_user, test_uuid)
save test_user_matrix.mat test_missing_users test_actual_users;
toc
