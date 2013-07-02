function [nm] = nanmean(x)
	n = 0;
	for i = 1 : size(x)
		if( !isnan(x(i)) )
			n = n + 1;
		endif
	end
	if(n>0)
		nm = nansum(x)/n;
	else
		nm = 0.0;
	endif
end