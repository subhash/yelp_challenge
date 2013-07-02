function [r] = extract_review_matrix(review, business, checkin, user_train, user_test)
	business_id = {cell2mat(business).business_id};
	user_id_train = {cell2mat(user_train).user_id};
	if(isempty(user_test))
		user_id_test = {};
	else
	  	user_id_test = {cell2mat(user_test).user_id};
	endif
	checkin_business_id = {cell2mat(checkin).business_id};
	c = cellfun(@(x) extract_review_data(x, business, business_id, user_train, user_id_train, user_test, user_id_test, checkin, checkin_business_id), review, "UniformOutput", false);
	r = cell2mat(c);
end

function [review_data] = extract_review_data(r, business, bid, user, uid, user_test, utid, checkin, cbid)
	user_id = r.user_id;
	review_id = r.review_id;
	business_id = r.business_id;
	stars = r.stars;
	if(sum(ismember(fieldnames(r),'votes')))
		funny = r.votes.funny;
		useful = r.votes.useful;
		cool = r.votes.cool;
	else
		funny = NaN;
		useful = NaN;
		cool = NaN;
	end
	
	b = find_business(business_id, business, bid);
	u = find_user(user_id, user, uid, user_test, utid);
	c = find_checkin(business_id, checkin, cbid);
	
	b_latitude = b{1}.latitude;
	b_longitude = b{1}.longitude;
	b_open = b{1}.open;
	b_review_count = b{1}.review_count;
	b_stars = b{1}.stars;
	
	if(isempty(c))
	  c_checkins = 0;
	else
	  c_checkins = sum(cell2mat(struct2cell(c{1}.checkin_info)));
	endif
	
	if(isempty(u))
	  u_ave_stars = NaN;
	  u_review_count = NaN;
	  u_funny = NaN;
	  u_useful = NaN;
	  u_cool = NaN;	  
	else
	  u_ave_stars = u{1}.average_stars;
	  u_review_count = u{1}.review_count;
	  if(sum(ismember(fieldnames(u{1}),'votes')))
		  u_funny = u{1}.votes.funny;
		  u_useful = u{1}.votes.useful;
		  u_cool = u{1}.votes.cool;
	  else
		  u_funny = NaN;
		  u_useful = NaN;
		  u_cool = NaN;
	  endif
	endif
%					1		2		3			4			5			6		7				8			9		10		11		12		13		14	  15
	review_data = [stars b_open b_review_count b_stars b_latitude b_longitude u_ave_stars u_review_count u_funny u_useful u_cool c_checkins funny useful cool];

	
end

