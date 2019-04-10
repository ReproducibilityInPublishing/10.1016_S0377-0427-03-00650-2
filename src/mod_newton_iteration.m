function xnext = mod_newton_iteration(xcurrent, xprev, lambda, F, DF, G)
	y = lambda*xcurrent+(1-lambda)*xprev;
	Diffmat = DF(xcurrent)+GDiff(y, xcurrent, G);
	xnext = xcurrent-inv(Diffmat)*(F(xcurrent)+G(xcurrent));
end
