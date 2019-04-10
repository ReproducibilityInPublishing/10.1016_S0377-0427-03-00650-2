function [x, inf_err, n] = mod_newton_solve(x0, xm, F, DF, G, tolerance, lambda, N=0)
    xprev = xm;
    xcurrent = x0;

    inf_err = 10;
    % For some reason, was starting at 1 before..
    n = 1;
    %fprintf("Called with N=%i\n",N);
    while ((inf_err > tolerance) && ((N==0)||(n<=N)))
        %fprintf("Iteration\n");
	    xnext = mod_newton_iteration(xcurrent, xprev, lambda, F, DF, G);
        xprev = xcurrent;
        xcurrent = xnext;
        inf_err = norm(xprev-xcurrent, Inf);
        n += 1;
    end
    x = xcurrent;
end
