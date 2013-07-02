function [r] = find_review(user_id, review, ruid)
	%f = cellfun(@(x) strcmp(x.business_id, business_id), checkin);
	f = ismember(ruid, user_id);
	r = review(f);
end