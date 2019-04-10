function result = E2DF(x)
	result(1,1) = 6*x(1)*x(2);
	result(1,2) = 3*x(1)^2+2*x(2);
	result(2,1) = 4*x(1)^3+x(2)^3;
	result(2,2) = 3*x(1)*x(2)^2;
end
