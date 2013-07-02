tic
all_review = test_review';
all_business = [ cell2mat(business) ; cell2mat(test_business') ];
all_business = mat2cell(all_business, ones(1, size(all_business, 1)), ones(1, size(all_business, 2)));
% all_user = [ cell2mat(user) ; cell2mat(test_user') ];
% all_user = mat2cell(all_user, ones(1, size(all_user, 1)), ones(1, size(all_user, 2)));
test_review_mat = extract_review_matrix(all_review, all_business, test_checkin', user, test_user');
% save test_review_mat.mat test_review_mat;
toc
