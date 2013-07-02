tic;


%%%%%%%%%%%%% Training - review %%%%%%%%%%%

rmm = zeros( size(rm,1),  size(rm,2) + size(abm,2) + size(aum,2) + size(acm,2) );
for i = 1:size(rmm,1)
	bi = find( ismember( abcid, rcbid{i} ) );
	ui = find( ismember( aucid, rcuid{i} ) );
	ci = find( ismember( acbid, rcbid{i} ) );
	
	if(isempty(bi))
		fprintf("Something wrong for %s at %d\n", rcbid{i}, i);
	else
		brow = abm(bi, :);
	endif
	
	if(isempty(ui))
		urow = nan(1, size(aum,2));
	else
		urow = aum(ui, :);
	endif
	
	if(isempty(ci))
		crow = [0];
	else
		crow = acm(ci, :);
	endif
	
	rmm(i,:) = [rm(i,:) brow urow crow];
end

% save rmm.mat rmm;



%%%%%%%%%%%%% Testing - review %%%%%%%%%%%

trmm = zeros( size(trm,1),  size(trm,2) + 3 + size(abm,2) + size(aum,2) + size(acm,2) );
for i = 1:size(trmm, 1)
	bi = find( ismember( abcid, trcbid{i} ) );
	ui = find( ismember( aucid, trcuid{i} ) );
	ci = find( ismember( acbid, trcbid{i} ) );
	
	if(isempty(bi))
		fprintf("Something wrong for %s at %d\n", trcbid{i}, i);
	else
		brow = abm(bi, :);
	endif
	
	if(isempty(ui))
		% NaN for missing user
		urow = nan(1, size(aum,2));
	else
		urow = aum(ui, :);
	endif
	
	if(isempty(ci))
		crow = [0];
	else
		crow = acm(ci, :);
	endif	
	
	% NaNs for missing review votes in test set, adjust for jutting text size col
	trmm(i,:) = [trm(i,1:2) nan(1,3) trm(i,3) brow urow crow];
end

% save trmm.mat trmm;

%{


%%%%%%%%%%%%% Combining all reviews %%%%%

% Appending with NaNs for missing votes in test set - better to do this upstream
arm = [ rm ; [trm nan(size(trm,1), 3)] ];
armm = [ rmm ; trmm ];




%%%%%%%%%%%%% All users %%%%%%%%%%%

aumm = zeros( size(aum,1),  size(aum,2) + size(arm,2) + size(abm,2)  );
for i = 1:size(aumm,1)
	ri = find( ismember( aruid, aucid{i} ) );
	
	if(isempty(ri))
		fprintf("Something wrong for %s at %d\n", aucid{i}, i);
	else
		% pull in review and business columns only
		urmat = armm(ri, 1 : (size(rm,2) + size(abm,2)));
		% urrow = [mean(urmat(:,1:2),1) sum(urmat(:,3:5),1) mean(urmat(:,6:10),1) ];
		urrow = [nanmean(urmat(:,1)) nanmean(urmat(:,2)) nansum(urmat(:,3)) nansum(urmat(:,4)) nansum(urmat(:,5)) nanmean(urmat(:,6)) nanmean(urmat(:,7)) nanmean(urmat(:,8)) nanmean(urmat(:,9)) nanmean(urmat(:,10)) nanmean(urmat(:,11))];
		if(sum(isnan(urrow)))
			fprintf("%d %s", i, aucid{i});
			urrow
		endif
	endif
	aumm(i,:) = [aum(i,:) urrow];
end

save aumm.mat aumm


%%%%%%%%%%%%% Missing users %%%%%%%%%%%

muid = setdiff(aruid, aucid);
mumm = zeros( size(muid,1), size(arm,2) + size(abm,2)  );
for i = 1:size(mumm,1)
	ri = find( ismember( aruid, muid{i} ) );
	
	if(isempty(ri))
		fprintf("Something wrong for %s at %d\n", aucid{i}, i);
	else
		% pull in review and business columns only
		urmat = armm(ri, 1 : (size(rm,2) + size(abm,2)));
		urmat = urmat(all(!isnan(urmat),2), :);
		% urrow = [mean(urmat(:,1:2),1) sum(urmat(:,3:5),1) mean(urmat(:,6:10),1) ];
		urrow = [nanmean(urmat(:,1)) nanmean(urmat(:,2)) nansum(urmat(:,3)) nansum(urmat(:,4)) nansum(urmat(:,5)) nanmean(urmat(:,6)) nanmean(urmat(:,7)) nanmean(urmat(:,8)) nanmean(urmat(:,9)) nanmean(urmat(:,10)) nanmean(urmat(:,11))];
	endif
	mumm(i,:) = [urrow];
end

%}

toc;

