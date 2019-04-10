function example1()

h = @(t) t.^(1/2);
omega1 = @(z) (3/2)*z^(1/2);
omega2 = @(s1,s2) (2/9);
pF = @(x) E1F(x);
pDF = @(x) E1DF(x);
pG = @(x) E1G(x);

xm = [5;5];
x0 = [1;0];
lambda = 0;

xprev = xm;
xcurrent = x0;

tolerance = 1e-16;

[xnew, inf_err, n] = mod_newton_solve(xcurrent, xprev, pF, pDF, pG, tolerance, lambda, 1);
xprev = xcurrent;
xcurrent = xnew;
[xnew, inf_err, n] = mod_newton_solve(xcurrent, xprev, pF, pDF, pG, tolerance, lambda, 1);
xprev = xcurrent;
xcurrent = xnew;
[xnew, inf_err, n] = mod_newton_solve(xcurrent, xprev, pF, pDF, pG, tolerance, lambda, 1);
xprev = xcurrent;
xcurrent = xnew;

fprintf("z2 = (%.6f,%.6f)\n", xprev(1), xprev(2));
fprintf("z3 = (%.6f,%.6f)\n", xcurrent(1), xcurrent(2));

alpha = norm(xprev-xcurrent, Inf);

fprintf("alpha = %.7f\n", alpha);
y = lambda*xcurrent+(1-lambda)*xprev;
Diffmat = pDF(xcurrent)+GDiff(y,xcurrent, pG);
beta = norm(inv(Diffmat), Inf);
fprintf("beta = %.5f\n", beta);

eta = norm(inv(Diffmat)*(pF(xcurrent)+pG(xcurrent)), Inf);
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

[xcurrent, inf_err, n] = mod_newton_solve(xcurrent, xprev, pF, pDF, pG, tolerance, lambda);

fprintf("Solution is:\n");
fprintf("x* = (%f, %f)\n", xcurrent(1), xcurrent(2));

end
