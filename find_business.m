function [b] = find_business(business_id, business, bid)
	%f = cellfun(@(x) strcmp(x.business_id, business_id), business);
	f = ismember(bid, business_id);
	b = business(f);
end