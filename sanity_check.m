
for i=1:size(ruid,2)
	if(sum(ismember(uuid, ruid(:,i))))
	else
		if(sum(ismember(muid, ruid(:,i))))
		else
			fprintf("%d %s\n", i, ruid(:, i));
		endif
	endif
end