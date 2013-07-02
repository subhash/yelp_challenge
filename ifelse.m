function [ret] = ifelse(expr, true_val, false_val)
	if(expr)
		ret = true_val;
	else
		ret = false_val;
	endif
end