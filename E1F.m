function result = E1F(x)
	result = zeros(2,1);
	result(1) = x(1)^(3/2)-x(2)-(3/4);
	result(2) = (2/9)*x(1)+x(2)^(3/2)-(3/8);
end
