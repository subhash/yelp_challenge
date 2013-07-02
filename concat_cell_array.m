function [c] = concat_cell_array(a, b)
	na = size(a, 1);
	nb = size(b, 1);
	c = cell( na + nb, 1);
	c(1:na, :) = a(:,:);
	c(na+1:end, :) = b(:,:);
end