program bisection_method
    implicit none

    real(8) :: a, b, c, fa, fb, fc, tol
    integer :: iter, max_iter

    print *, 'Enter interval endpoints a and b:'
    read *, a, b

    print *, 'Enter tolerance:'
    read *, tol

    print *, 'Enter maximum number of iterations:'
    read *, max_iter

    fa = f(a)
    fb = f(b)

    if (fa * fb > 0.0d0) then
        print *, 'Error: f(a) and f(b) must have opposite signs.'
        stop
    end if

    print *, 'Iter', 'a', 'b', 'c', 'f(c)'

    do iter = 1, max_iter
        c = 0.5d0 * (a + b)
        fc = f(c)

        print '(I4, 4F16.8)', iter, a, b, c, fc

        if (abs(fc) < tol .or. abs(b - a) / 2.0d0 < tol) then
            print *, 'Approximate root = ', c
            stop
        end if

        if (fa * fc < 0.0d0) then
            b = c
            fb = fc
        else
            a = c
            fa = fc
        end if
    end do

    print *, 'Maximum iterations reached.'
    print *, 'Approximate root = ', c

contains

    real(8) function f(x)
        implicit none
        real(8), intent(in) :: x

        ! Example equation: x^3 - x - 2 = 0
        f = x**3 - x - 2.0d0
    end function f

end program bisection_method