function tables()

[ x1, err1 ] = example2(0);

fprintf("Table 1\n");
for n = 1:numel(err1)
	fprintf("n: %i x(1)n: %.16f x(2)n: %.16f err: %e\n", n, x1(n,1), x1(n,2), err1(n));
end

[ x2, err2 ] = example2(0.5);

fprintf("Table 2\n");
for n = 1:numel(err2)
	fprintf("n: %i x(1)n: %.16f x(2)n: %.16f err: %e\n", n, x2(n,1), x2(n,2), err2(n));
end

[ x3, err3 ] = example2(0.99);

fprintf("Table 3\n");
for n = 1:numel(err3)
	fprintf("n: %i x(1)n: %.16f x(2)n: %.16f err: %e\n", n, x3(n,1), x3(n,2), err3(n));
end

end
