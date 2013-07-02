tic;

%%%%%%%%%%%%% Include predicted user attr %%%%%%%%%%%

mu = any(isnan(trmm(:,[11:12])),2);
mtruid = trcuid(mu);
predicted = zeros(size(mtruid), 1);
for i = 1:size(mtruid)
	predicted(i) = pmum(find(ismember(muid, mtruid{i})), 11);
end
trmm(mu, 11) = predicted;

toc;

