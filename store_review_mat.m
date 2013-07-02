tic
new_review_mat = extract_review_matrix(review(1:1000), business, checkin, user, {})
%save review_mat.mat review_mat;
toc
