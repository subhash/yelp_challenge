tic;

%%%%%%%%%%%%% Predict missing users %%%%%%%%%%%


muwrv = all(isnan(mumm(:,3:5)),2);
Xpred = mumm(!muwrv, :);

f = any(isnan(armm(:,[3,4,5,11,12,13,14,15])),2);
X = armm(!f,[1:10]);
y = armm(!f,[11,12]); 

%r = randperm(size(X,1));
%X = X(r,:);
%y = y(r,:);

y_ave_stars = y(:,1);
y_review_count = y(:,2);

X = [X X.^2 ];
Xpred = [Xpred Xpred.^2 ];


[X_norm, mu, sigma] = normalize_features(X);
theta_ave_stars = optimize(X_norm, y_ave_stars);
theta_review_count = optimize(X_norm, y_review_count);

Xpred = [ones(size(Xpred,1),1) scale_features(Xpred, mu, sigma)];
pred_ave_stars = Xpred * theta_ave_stars;
pred_review_count = Xpred * theta_review_count;

pmum = [mumm nan(size(mumm,1), 2)];
pmum(!muwrv,[11,12]) = [pred_ave_stars pred_review_count];  



toc;

