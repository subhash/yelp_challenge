tic;

X = X_full(1:1000,:);
y = y_full(1:1000,:);
lambda = 0;

m = size(X,1);

[et, ev] = learningCurve(X, y, lambda);
plot(1:m, et, 1:m, ev);

title(sprintf('Linear Regression Learning Curve (lambda = %f)', lambda));
xlabel('Number of training examples')
ylabel('Error')
%axis([0 13 0 100])
legend('Train', 'Cross Validation')

toc;