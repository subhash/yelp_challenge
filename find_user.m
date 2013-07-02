function [u] = find_user(user_id, user, uid, user_test, utid)
	%f = cellfun(@(x) strcmp(x.user_id, user_id), user);
	f = ismember(uid, user_id);
	u = user(f);
	if(isempty(u))
		f = ismember(utid, user_id);
		u = user_test(f);
	endif
end