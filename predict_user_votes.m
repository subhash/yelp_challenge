tic;

%%%%%%%%%%%%% Predict user votes %%%%%%%%%%%

% Users without votes
uwv = all(isnan(aumm(:,3:5)), 2);
Xpred = aumm(uwv, [1,2,6,7,11,12,13,14,15]);
X = aumm(!uwv, [1,2,6,7,11,12,13,14,15]);
y = aumm(!uwv, [3,4,5]);

%r = randperm(size(X,1));
%X = X(r,:);
%y = y(r,:);

y_funny = y(:,1);
y_useful = y(:,2);
y_cool = y(:,3);

X = [X X.^2 ];
Xpred = [Xpred Xpred.^2 ];


[X_norm, mu, sigma] = normalize_features(X);
theta_funny = optimize(X_norm, y_funny);
theta_useful = optimize(X_norm, y_useful);
theta_cool = optimize(X_norm, y_cool);

Xpred = [ones(size(Xpred,1),1) scale_features(Xpred, mu, sigma)];
pred_funny = Xpred * theta_funny;
pred_useful = Xpred * theta_useful;
pred_cool = Xpred * theta_cool;

puvm = nan(size(aumm));
puvm(:,:) = aumm(:,:);
puvm(uwv,[3 4 5]) = [pred_funny pred_useful pred_cool];


toc;

