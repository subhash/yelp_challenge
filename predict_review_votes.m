tic;

%%%%%%%%% Data prep %%%%%%%%%


muf = all(isnan(rmm(:,12:16)),2);
murm = rmm(muf, :);						% missing users
eurm = rmm(!muf, :);
etsuf = all(isnan(eurm(:,14:16)),2);
etrurm = eurm(!etsuf, :);				% users from training set
etsurm = eurm( etsuf, :);				% users from test set


tmuf = all(isnan(trmm(:,12:16)),2);
tmurm = trmm(tmuf, :);
tseurm = trmm(!tmuf, :);
tetsuf = all(isnan(tseurm(:,14:16)),2);
tetrurm = tseurm(!tetsuf, :);
tetsurm = tseurm( tetsuf, :);


%%%%%%%%%% Validate %%%%%%%%%%%%%


bsize = (size(rmm,1) == size(murm,1) + size(etrurm,1) + size(etsurm,1));
bcol = (size(rmm,2) == size(murm,2)) & (size(etrurm,2) == size(etsurm,2)) & (size(murm,2) == size(etrurm,2));

tbsize = (size(trmm,1) == size(tmurm,1) + size(tetrurm,1) + size(tetsurm,1));
tbcol = (size(trmm,2) == size(tmurm,2)) & (size(tetrurm,2) == size(tetsurm,2)) & (size(tmurm,2) == size(tetrurm,2));



%%%%%%%%%%%%%% Predict %%%%%%%%%%%%%%%%%%

% 1			2		3		4			5		6
% rc.stars rtcc rvc.funny rvc.useful rvc.cool rta

%  7		8				9			10				11
% bc.open bc.review_count bc.latitude  bc.longitude  bc.stars 

%	12					13			14			15			16
% uc.average_stars  uc.review_count uvc.funny uvc.useful uvc.cool 

% 17
% cc


X_col = [1 2 6 7 8 9 10 11 17];
X_full = etrurm(:,[X_col 12:16]);
X_partial = etsurm(:,[X_col 12:13]);
X_missing = murm(:,[X_col]);

y_full = etrurm(:,[4]);
y_partial = etsurm(:,[4]);
y_missing = murm(:,[4]);

Xpred_full = tetrurm(:,[X_col 12:16]);
Xpred_partial = tetsurm(:,[X_col 12:13]);
Xpred_missing = tmurm(:,[X_col]);

bxnan = ! (sum(sum(isnan(X_full))) + sum(sum(isnan(X_partial))) + sum(sum(isnan(X_missing))));

if(!(bsize & bcol & tbsize & tbcol & bxnan))
	fprintf(" ***** FOUL *****");
endif



% X_full = [  X_full multinom(X_full(:,[1,5,8,9,10]),2)  ];
% Xpred_full = [ Xpred_full multinom(Xpred_full(:,[1,5,8,9,10]), 2) ];


[X_norm_full, mu_full, sigma_full] = normalize_features(X_full);
[X_norm_partial, mu_partial, sigma_partial] = normalize_features(X_partial);
[X_norm_missing, mu_missing, sigma_missing] = normalize_features(X_missing);


theta_full = optimize(X_norm_full, y_full);
theta_partial = optimize(X_norm_partial, y_partial);
theta_missing = optimize(X_norm_missing, y_missing);

Xpred_full = [ones(size(Xpred_full,1),1) scale_features(Xpred_full, mu_full, sigma_full)];
Xpred_partial = [ones(size(Xpred_partial,1),1) scale_features(Xpred_partial, mu_partial, sigma_partial)];
Xpred_missing = [ones(size(Xpred_missing,1),1) scale_features(Xpred_missing, mu_missing, sigma_missing)];

pred_full = Xpred_full * theta_full;
pred_partial = Xpred_partial * theta_partial;
pred_missing = Xpred_missing * theta_missing;

pred_partial = Xpred_partial(:,1:end-2) * theta_missing;


%%%%%%% Reporting predictions  %%%%%%%%

pred_eu = nan(size(tseurm,1),1);
pred_eu(!tetsuf,:) = pred_full(:);
pred_eu(tetsuf,:) = pred_partial(:);
pred_all = nan(size(trmm,1),1);
pred_all(!tmuf, :) = pred_eu(:); 
pred_all(tmuf,:) = pred_missing(:);


bp_missing = ( sum(pred_all(tmuf,:) - pred_missing(:)) == 0 );
bp_partial = ( sum(pred_all(!tmuf,:)(tetsuf,:) - pred_partial(:)) == 0 );
bp_full =  ( sum(pred_all(!tmuf,:)(!tetsuf,:) - pred_full(:)) == 0 );

if( ! (bp_missing & bp_partial & bp_full) )
	fprintf("***** FOUL ***** Predictions\n");
endif 







pred_all = abs(pred_all);

file = fopen("final2.csv","w");
fprintf(file,"id,votes\n");
for i=1:size(pred_all)
	fprintf(file,"%s,%f\n",trcid{i},pred_all(i));
end
fclose(file);

%{

%%%%%%%%%%%%% Predict review votes %%%%%%%%%%%

f = any(isnan(rmm(:,[])),2);
X = rmm(!f,[1,2,6,7,8,9,10,11]);
y = rmm(!f,4);

fpred = any(isnan(trmm(:,[])),2);
Xpred = trmm(!fpred,[1,2,3,7,8,9,10,11]); 

%r = randperm(size(X,1));
%X = X(r,:);
%y = y(r,:);

X = [X ];
Xpred = [Xpred ];


[X_norm, mu, sigma] = normalize_features(X);
theta = optimize(X_norm, y);

Xpred = [ones(size(Xpred,1),1) scale_features(Xpred, mu, sigma)];
pred = Xpred * theta;


file = fopen("with_review_date.csv","w");
for i=1:size(pred)
	fprintf(file,"%s,%f\n",trcid{i},pred(i));
end
fclose(file);

%}

toc;

