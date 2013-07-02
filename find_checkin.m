function [c] = find_checkin(business_id, checkin, cbid)
	%f = cellfun(@(x) strcmp(x.business_id, business_id), checkin);
	f = ismember(cbid, business_id);
	c = checkin(f);
end