function result = GDiff(y, x, G)
	Guv = G([y(1), x(2)]);
	Gvv = G([x(1), x(2)]);
	Guu = G([y(1), y(2)]);
	result(1,1) = (Guv(1)-Gvv(1))/(y(1)-x(1));
	result(1,2) = (Guu(1)-Guv(1))/(y(2)-x(2));
	result(2,1) = (Guv(2)-Gvv(2))/(y(1)-x(1));
	result(2,2) = (Guu(2)-Guv(2))/(y(2)-x(2));
end
