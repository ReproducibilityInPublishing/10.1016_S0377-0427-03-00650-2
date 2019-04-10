function result = E2F(x)
	result = zeros(2,1);
	result(1) = 3*x(1)^2*x(2)+x(2)^2-1;
	result(2) = x(1)^4+x(1)*x(2)^3-1;
end
