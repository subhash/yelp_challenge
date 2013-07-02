function [ns] = nansum(x)
	ns = 0.0;
	for i = 1 : size(x)
		if( !isnan(x(i)) )
			ns = ns + x(i);
		endif
	end
end