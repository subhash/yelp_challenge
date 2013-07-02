function [c] = concat_matrix(a, b)
	[ax, ay] = size(a);
	[bx, by] = size(b);
	c = [a ; [ b nan(bx,(ay-by)) ] ];
end