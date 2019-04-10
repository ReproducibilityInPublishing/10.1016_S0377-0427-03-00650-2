function result = E2G(x)
	result = zeros(2,1);
	result(1) = abs(x(1)-1)^(3/2);
	result(2) = abs(x(2))^(3/2);
end
