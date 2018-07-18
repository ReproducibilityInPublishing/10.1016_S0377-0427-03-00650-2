format short g

function result = F(x)
	result = zeros(2,1);
	result(1) = x(1)^(3/2)-x(2)-(3/4);
	result(2) = (2/9)*x(1)+x(2)^(3/2)-(3/8);
end

function result = G(x)
	result = zeros(2,1);
	result(1) = (1/9)*abs(x(1)-1);
	result(2) = (1/9)*abs(x(2));
end

function result = DF(x)
	result(1,1) = (3/2)*x(1)^(1/2);
	result(1,2) = -1;
	result(2,1) = (2/9);
	result(2,2) = (3/2)*x(2)^(1/2);
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

function result = omega1(z)
	result = (3/2)*z^(1/2);
end

function result = omega2(s1,s2)
	result = (2/9);
end

%function result = h(t)
%	result = t^(1/2);
%end

h = @(t) t.^(1/2);

xm = [5;5];
x0 = [1;0];
lambda = 0;

xprev = xm;
xcurrent = x0;

n = 1;
N = 3;
while n <= N
	y = lambda*xcurrent+(1-lambda)*xprev;
	Diffmat = DF(xcurrent)+GDiff(y, xcurrent);
	xnext = xcurrent-inv(Diffmat)*(F(xcurrent)+G(xcurrent));
	xprev = xcurrent;
	xcurrent = xnext;
	n += 1;
end

fprintf("z2 = (%.6f,%.6f)\n", xprev(1), xprev(2));
fprintf("z3 = (%.6f,%.6f)\n", xcurrent(1), xcurrent(2));

alpha = norm(xprev-xcurrent, Inf);

fprintf("alpha = %.7f\n", alpha);
y = lambda*xcurrent+(1-lambda)*xprev;
Diffmat = DF(xcurrent)+GDiff(y,xcurrent);
beta = norm(inv(Diffmat), Inf);
fprintf("beta = %.5f\n", beta);

eta = norm(inv(Diffmat)*(F(xcurrent)+G(xcurrent)), Inf);
fprintf("eta = %.8f\n", eta);

T = quadgk(h, 0, 1);
fprintf("T = %.8f\n", T);
omega2((1-lambda)*alpha, eta)
omega2((1-lambda)*eta, eta)
m_vec = [beta*(omega2((1-lambda)*alpha,eta)+T*omega1(eta)), beta*(omega2((1-lambda)*eta, eta)+T*omega1(eta))];
m = max(m_vec);
fprintf("m = %.8f\n", m);

%rfun = @(r) ((3/2)*beta).*r.^(3/2)+(m+beta*(2/9)-1).*r-((3/2)*eta*beta)*r.^(1/2)+(eta-eta*beta*(2/9));
rfun = @(r) r.*(1.-(m./(1.-beta.*((3/2).*r.^(1/2).+(2/9))))).-eta;
R = fzero(rfun, [0 0.02]);
fprintf("R = %.8f\n", R);

d = beta*(omega1(R)+omega2(R+(1-lambda)*alpha, R));
fprintf("d = %.8f\n", d);

if m+d < 1
	fprintf("m+d < 1\n");
else
	fprintf("m+d is not < 1\n");
end

tolerance = 1e-16;
inf_err = 10;
while inf_err > tolerance
	y = lambda*xcurrent+(1-lambda)*xprev;
	Diffmat = DF(xcurrent)+GDiff(y, xcurrent);
	xnext = xcurrent-inv(Diffmat)*(F(xcurrent)+G(xcurrent));
	xprev = xcurrent;
	xcurrent = xnext;
	inf_err = norm(xprev-xcurrent, Inf);
	n += 1;
end

fprintf("Solution is:\n");
fprintf("x* = (%f, %f)\n", xcurrent(1), xcurrent(2));
