# NumericalLab

NumericalLab is a small collection of standalone Fortran 90 programs for common numerical methods. Each source file solves one specific problem class and uses simple console input so the programs can be compiled and run independently.

## Contents

- `bisection_method.f90` - root finding using the Bisection Method
- `newton_raphson_method.f90` - root finding using the Newton-Raphson Method
- `numerical_differentiation.f90` - first and second numerical differentiation
- `numerical_integration.f90` - trapezoidal rule, Simpson's 1/3 rule, Simpson's 3/8 rule, and accuracy analysis
- `lagrange_interpolation.f90` - Lagrange interpolation for a given dataset
- `newton_forward_interpolation.f90` - Newton forward-difference interpolation
- `jacobi_method.f90` - solving linear systems using the Jacobi iterative method
- `gauss_seidel_method.f90` - solving linear systems using the Gauss-Seidel iterative method
- `sor_method.f90` - solving linear systems using the Successive Over-Relaxation method

## Requirements

- A Fortran compiler such as `gfortran`
- A terminal or command prompt

## How to Compile

Each program is independent, so compile only the file you want to run.

```bash
gfortran bisection_method.f90 -o bisection_method
gfortran newton_raphson_method.f90 -o newton_raphson_method
gfortran numerical_differentiation.f90 -o numerical_differentiation
gfortran numerical_integration.f90 -o numerical_integration
gfortran lagrange_interpolation.f90 -o lagrange_interpolation
gfortran newton_forward_interpolation.f90 -o newton_forward_interpolation
gfortran jacobi_method.f90 -o jacobi_method
gfortran gauss_seidel_method.f90 -o gauss_seidel_method
gfortran sor_method.f90 -o sor_method
```

If you want to compile and run in one step, you can use:

```bash
gfortran file_name.f90 -o program_name && ./program_name
```

## How to Run

After compiling, run the executable from the same folder:

```bash
./program_name
```

The programs are interactive and will prompt for input values in the terminal.

## Program Documentation

### 1. Bisection Method

File: `bisection_method.f90`

This program finds an approximate root of a nonlinear equation using the Bisection Method.

It uses the example function:

\[
f(x) = x^3 - x - 2
\]

#### What it solves

It solves for a root of the equation \(f(x) = 0\) by repeatedly shrinking an interval where the function changes sign.

#### Input format

The program asks for:

1. Lower endpoint `a`
2. Upper endpoint `b`
3. Tolerance `tol`
4. Maximum number of iterations `max_iter`

#### Important note

- `f(a)` and `f(b)` must have opposite signs.
- If they do not, the program stops with an error.

#### Output

The program prints the values of `a`, `b`, midpoint `c`, and `f(c)` at each iteration, then prints the approximate root.

### 2. Newton-Raphson Method

File: `newton_raphson_method.f90`

This program finds an approximate root using the Newton-Raphson method.

It uses the same example function:

\[
f(x) = x^3 - x - 2
\]

and its derivative:

\[
f'(x) = 3x^2 - 1
\]

#### What it solves

It solves \(f(x) = 0\) by starting from an initial guess and iterating with:

\[
x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}
\]

#### Input format

The program asks for:

1. Initial guess `x0`
2. Tolerance `tol`
3. Maximum number of iterations `max_iter`

#### Important note

- If the derivative becomes too close to zero, the program stops to avoid division by zero.

#### Output

The program prints the current approximation and function value at each iteration, then prints the approximate root.

### 3. Numerical Differentiation

File: `numerical_differentiation.f90`

This program estimates the first or second derivative of a function using finite-difference formulas.

It uses the example function:

\[
f(x) = x^3 - x - 2
\]

#### What it solves

It estimates:

- first derivative using the central difference formula
- second derivative using the central second-difference formula

#### Input format

The program asks for:

1. Method choice:
   - `1` for first derivative
   - `2` for second derivative
2. Point `x`
3. Step size `h`

#### Important note

- Step size `h` must be positive.

#### Output

The program prints the approximate derivative value at the chosen point.

### 4. Numerical Integration

File: `numerical_integration.f90`

This program estimates the integral of a function using several numerical integration formulas and also performs accuracy analysis.

It uses the example function:

\[
f(x) = x^3 - x - 2
\]

The exact antiderivative used for error analysis is:

\[
F(x) = \frac{x^4}{4} - \frac{x^2}{2} - 2x
\]

#### What it solves

It approximates the definite integral of the example function on an interval \([a, b]\) using:

- Trapezoidal Rule
- Simpson's 1/3 Rule
- Simpson's 3/8 Rule
- A comparison mode that reports all available methods

#### Input format

The program asks for:

1. Method choice:
   - `1` Trapezoidal Rule
   - `2` Simpson's 1/3 Rule
   - `3` Simpson's 3/8 Rule
   - `4` Compare All Methods
2. Lower limit `a`
3. Upper limit `b`
4. Number of subintervals `n`

#### Important notes

- `n` must be positive.
- Simpson's 1/3 Rule requires `n` to be even.
- Simpson's 3/8 Rule requires `n` to be a multiple of 3.

#### Accuracy analysis

The program computes:

- approximate integral
- exact integral
- absolute error
- relative error percentage

#### Output

The program prints the chosen method result and the error analysis.

### 5. Lagrange Interpolation

File: `lagrange_interpolation.f90`

This program interpolates a value from a given dataset using the Lagrange interpolation polynomial.

#### What it solves

Given data points \((x_i, y_i)\), it estimates the value of the function at a user-specified point `x_query`.

#### Input format

The program asks for:

1. Number of data points `n`
2. `n` pairs of values `x(i), y(i)`
3. Query point `x_query`

#### Important note

- Duplicate `x` values are not allowed.

#### Output

The program prints the interpolated value at the requested point.

### 6. Newton Forward Difference Interpolation

File: `newton_forward_interpolation.f90`

This program interpolates a value using Newton's forward-difference formula.

#### What it solves

It estimates the value at a query point from equally spaced data points using a forward-difference table.

#### Input format

The program asks for:

1. Number of data points `n`
2. `n` equally spaced pairs of `x(i), y(i)`
3. Query point `x_query`

#### Important notes

- At least two data points are required.
- The `x` values must be equally spaced.
- Duplicate or repeated `x` values are not allowed.

#### Output

The program prints the forward difference table and the interpolated value at the requested point.

### 7. Jacobi Iterative Method

File: `jacobi_method.f90`

This program solves a system of linear equations using the Jacobi iterative method.

#### What it solves

It solves a linear system of the form:

\[
A x = b
\]

by repeatedly updating each variable using the previous iteration values.

#### Input format

The program asks for:

1. Number of unknowns `n`
2. Coefficient matrix `A` row by row
3. Right-hand side vector `b`
4. Initial guess vector `x0`
5. Tolerance `tol`
6. Maximum number of iterations `max_iter`

#### Important notes

- Diagonal entries of `A` must not be zero.
- The method works best when the system is diagonally dominant.

#### Output

The program prints the approximate solution vector after each iteration and reports convergence when the tolerance is met.

### 8. Gauss-Seidel Iterative Method

File: `gauss_seidel_method.f90`

This program solves a system of linear equations using the Gauss-Seidel method.

#### What it solves

It solves \(A x = b\) by updating each variable immediately during the iteration, using the newest available values.

#### Input format

The program asks for:

1. Number of unknowns `n`
2. Coefficient matrix `A` row by row
3. Right-hand side vector `b`
4. Initial guess vector `x0`
5. Tolerance `tol`
6. Maximum number of iterations `max_iter`

#### Important notes

- Diagonal entries of `A` must not be zero.
- The method usually converges faster than Jacobi for suitable systems.

#### Output

The program prints each iteration and the approximate solution vector when convergence is achieved.

### 9. Successive Over-Relaxation Method

File: `sor_method.f90`

This program solves a system of linear equations using the Successive Over-Relaxation (SOR) method.

#### What it solves

It solves \(A x = b\) using the Gauss-Seidel update with a relaxation factor \(\omega\):

\[
x_i^{(k+1)} = (1 - \omega)x_i^{(k)} + \omega \cdot x_{i,\text{new}}
\]

#### Input format

The program asks for:

1. Number of unknowns `n`
2. Coefficient matrix `A` row by row
3. Right-hand side vector `b`
4. Initial guess vector `x0`
5. Relaxation factor `omega`
6. Tolerance `tol`
7. Maximum number of iterations `max_iter`

#### Important notes

- `omega` must satisfy `0 < omega < 2`.
- Diagonal entries of `A` must not be zero.
- SOR is often used to speed up convergence when a suitable relaxation factor is chosen.

#### Output

The program prints each iteration and the approximate solution vector when convergence is achieved.

## Example Workflow

1. Choose a file such as `bisection_method.f90`.
2. Compile it with `gfortran`.
3. Run the generated executable.
4. Enter the requested input values in the terminal.
5. Read the method output and the approximate answer.

## Notes on the Example Functions

Several programs in this repository use the same sample function:

\[
f(x) = x^3 - x - 2
\]

This was chosen because it is simple and useful for demonstrating root finding, differentiation, and integration.

If needed, the function in each file can be modified to solve a different numerical problem.

## Suggested Test Values

These are only example values to help you test the programs quickly.

- Bisection / Newton-Raphson root finding: interval or guess near the root around `x = 1.5`
- Numerical differentiation: point `x = 2.0`, step size `h = 0.01`
- Numerical integration: `a = 0`, `b = 2`, `n = 6`
- Lagrange interpolation: any small set of distinct `(x, y)` pairs
- Newton forward interpolation: equally spaced points such as `x = 0, 1, 2, 3`
- Jacobi / Gauss-Seidel / SOR: a diagonally dominant linear system with a reasonable initial guess

## License

No license file is included yet. Add one if you want to share or publish the project formally.