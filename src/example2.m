function [ xout, err ] = example2(lambda, pF, pDF, pG)

xm = [5;5];
x0 = [1;0];
xstar = [0.9383410452297656; 0.3312445136375143];

xprev = xm;
xcurrent = x0;

tolerance = 1e-16;

inf_err = 10;
n = 1;
while inf_err > tolerance
    [xnew, err_out, m] = mod_newton_solve(xcurrent, xprev, pF, pDF, pG, tolerance, lambda, 1);
	xout(n,1) = xnew(1);
	xout(n,2) = xnew(2);
	inf_err = norm(xnew-xstar, Inf);
	err(n) = inf_err;
	xprev = xcurrent;
	xcurrent = xnew;
	n += 1;
end
end
