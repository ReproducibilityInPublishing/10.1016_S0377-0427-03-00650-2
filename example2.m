function [ x, err ] = example2(lambda)
xm = [5;5];
x0 = [1;0];
xstar = [0.9383410452297656; 0.3312445136375143];

xprev = xm;
xcurrent = x0;

tolerance = 1e-16;

inf_err = 10;
n = 1;
while inf_err > tolerance
	y = lambda*xcurrent+(1-lambda)*xprev;
	Diffmat = DF(xcurrent)+GDiff(y, xcurrent);
	xnext = xcurrent-inv(Diffmat)*(F(xcurrent)+G(xcurrent));
	x(n,1) = xnext(1);
	x(n,2) = xnext(2);
	inf_err = norm(xnext-xstar, Inf);
	err(n) = inf_err;
	xprev = xcurrent;
	xcurrent = xnext;
	n += 1;
end
end

function result = F(x)
	result = zeros(2,1);
	result(1) = 3*x(1)^2*x(2)+x(2)^2-1;
	result(2) = x(1)^4+x(1)*x(2)^3-1;
end

function result = G(x)
	result = zeros(2,1);
	result(1) = abs(x(1)-1)^(3/2);
	result(2) = abs(x(2))^(3/2);
end

function result = DF(x)
	result(1,1) = 6*x(1)*x(2);
	result(1,2) = 3*x(1)^2+2*x(2);
	result(2,1) = 4*x(1)^3+x(2)^3;
	result(2,2) = 3*x(1)*x(2)^2;
end

function result = GDiff(y, x)
	Guv = G([y(1), x(2)]);
	Gvv = G([x(1), x(2)]);
	Guu = G([y(1), y(2)]);
	result(1,1) = (Guv(1)-Gvv(1))/(y(1)-x(1));
	result(1,2) = (Guu(1)-Guv(1))/(y(2)-x(2));
	result(2,1) = (Guv(2)-Gvv(2))/(y(1)-x(1));
	result(2,2) = (Guu(2)-Guv(2))/(y(2)-x(2));
end
