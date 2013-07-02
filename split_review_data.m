train_checkin = loadjson('yelp_training_set/yelp_training_set_checkin.json');
fprintf("Checkin done\n");
train_business = loadjson('yelp_training_set/yelp_training_set_business.json');
fprintf("Business done\n");
train_user = loadjson('yelp_training_set/yelp_training_set_user.json');
fprintf("User done\n");
train_review = loadjson('yelp_training_set/yelp_training_set_review.json');
fprintf("Review done\n");
save trainset.mat train_user train_business train_checkin train_review;
