program newton_raphson_method
    implicit none

    real(8) :: x0, x1, fx, dfx, tol
    integer :: iter, max_iter

    print *, 'Enter initial guess x0:'
    read *, x0

    print *, 'Enter tolerance:'
    read *, tol

    print *, 'Enter maximum number of iterations:'
    read *, max_iter

    print *, 'Iter', 'x', 'f(x)'

    do iter = 1, max_iter
        fx = f(x0)
        dfx = df(x0)

        if (abs(dfx) < 1.0d-12) then
            print *, 'Error: derivative too close to zero.'
            stop
        end if

        x1 = x0 - fx / dfx
        print '(I4, 2F16.8)', iter, x1, f(x1)

        if (abs(x1 - x0) < tol .or. abs(f(x1)) < tol) then
            print *, 'Approximate root = ', x1
            stop
        end if

        x0 = x1
    end do

    print *, 'Maximum iterations reached.'
    print *, 'Approximate root = ', x1

contains

    real(8) function f(x)
        implicit none
        real(8), intent(in) :: x

        ! Example equation: x^3 - x - 2 = 0
        f = x**3 - x - 2.0d0
    end function f

    real(8) function df(x)
        implicit none
        real(8), intent(in) :: x

        df = 3.0d0 * x**2 - 1.0d0
    end function df

end program newton_raphson_method