function [r] = extract_review_mat(review, business, user, checkin)
	user_ids = cellfun(@(x) getfield(x,'user_id'), review, "UniformOutput", false);

	review_ids = cellfun(@(x) getfield(x,'review_id'), review, "UniformOutput", false);

	user_ids = cellfun(@(x) getfield(x,'user_id'), review, "UniformOutput", false);	
	users = cellfun(@(x) find_user(x, user), user_ids, "UniformOutput", false);

	u_ave_stars = cellfun(@(x) user_if_exists(x,'average_stars'), users, "UniformOutput", true);
	u_review_count = cellfun(@(x) user_if_exists(x,'review_count'), users, "UniformOutput", true);
	u_funny = cellfun(@(x) user_votes_if_exists(x,'funny'), users, "UniformOutput", true);
	u_useful = cellfun(@(x) user_votes_if_exists(x,'useful'), users, "UniformOutput", true);
	u_cool = cellfun(@(x) user_votes_if_exists(x,'cool'), users, "UniformOutput", true);
	
	fprintf('user done');

	
	business_ids = cellfun(@(x) getfield(x,'business_id'), review, "UniformOutput", false);	
	businesses = cellfun(@(x) find_business(x, business), business_ids, "UniformOutput", false);
	b_latitude = cellfun(@(x) getfield(x{1},'latitude'), businesses, "UniformOutput", true);
	b_longitude = cellfun(@(x) getfield(x{1},'longitude'), businesses, "UniformOutput", true);
	b_open = cellfun(@(x) getfield(x{1},'open'), businesses, "UniformOutput", true);
	b_review_count = cellfun(@(x) getfield(x{1},'review_count'), businesses, "UniformOutput", true);
	b_stars = cellfun(@(x) getfield(x{1},'stars'), businesses, "UniformOutput", true);
	
	fprintf('business done');
	
	checkins = cellfun(@(x) find_checkin(x, checkin), business_ids, "UniformOutput", false);
	c_checkins = cellfun(@(x) checkin_if_exists(x), checkins, "UniformOutput", true);
	
	fprintf('checkins done');
	
	
	stars = cellfun(@(x) getfield(x,'stars'), review, "UniformOutput", true);
	funny = cellfun(@(x) x.votes.funny, review, "UniformOutput", true);
	useful = cellfun(@(x) x.votes.useful, review, "UniformOutput", true);
	cool = cellfun(@(x) x.votes.cool, review, "UniformOutput", true);
	
	r = [stars b_open b_review_count b_stars b_latitude b_longitude u_ave_stars u_review_count u_funny u_useful u_cool c_checkins funny useful cool];
end

function [c] = checkin_if_exists(checkin)
	if(isempty(checkin))
		c = 0;
	else
		c = sum(cell2mat(struct2cell(checkin{1}.checkin_info)));
	endif
end

function [u] = user_if_exists(user, attr)
	if(isempty(user))
		u = NaN;
	else
		u = getfield(user{1}, attr);
	endif
end

function [u] = user_votes_if_exists(user, attr)
	if(isempty(user))
		u = NaN;
	else
		u = getfield(user{1}.votes, attr);
	endif
end

