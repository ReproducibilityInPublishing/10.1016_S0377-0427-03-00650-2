# A modification of Newton's method for nondifferentiable equations

This is an implementation of the techniques presented in [A modification of Newton's method for nondifferntiable equations](https://doi.org/10.1016/S0377-0427(03)00650-2)

The code for example 1 is contained in `example1.m`, and can be executed directly as `octave example1.m`.

The code for example 2 is contained in `example2.m`, and is executed through the `tables.m` script which can be executed directly as `octave tables.m`.

## Differences from the article

Our results differ from the article in Example 1 with differing m, R and d. The results of the article are unchanged, however our values for m, R, and d are correct. Other results from Example 1 are identical to those reported in the article.

Our results differ for some rows in tables 1, 2, and 3. These differences are restricted to the last 2-3 significant digits. We do not think these are important differences.

## Machine/Software Information

Arch linux (kernel 4.17.4-1-ARCH)

CPU: Intel Core i7-6900K

Octave 4.4.0
