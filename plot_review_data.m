


for i = 1:size(X_full,2)
	plot(X_full(1:1000,i), y_full(1:1000),'rx','MarkerSize',10); 
	
	xlabel(sprintf("Column %d", i));
	ylabel('Useful votes');
	
	fprintf("Continue %d?\n",i+1);
	pause;
	

end
