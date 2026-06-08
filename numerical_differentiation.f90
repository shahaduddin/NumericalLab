program numerical_differentiation
    implicit none

    real(8) :: x, h, result
    integer :: choice

    print *, 'Numerical Differentiation Program'
    print *, 'Choose an option:'
    print *, '1. First derivative'
    print *, '2. Second derivative'
    read *, choice

    print *, 'Enter the value of x:'
    read *, x

    print *, 'Enter step size h:'
    read *, h

    if (h <= 0.0d0) then
        print *, 'Error: step size must be positive.'
        stop
    end if

    select case (choice)
    case (1)
        result = first_derivative(x, h)
        print *, 'Approximate first derivative at x = ', x, ' is ', result
    case (2)
        result = second_derivative(x, h)
        print *, 'Approximate second derivative at x = ', x, ' is ', result
    case default
        print *, 'Invalid option selected.'
    end select

contains

    real(8) function f(t)
        implicit none
        real(8), intent(in) :: t

        ! Example function: f(x) = x^3 - x - 2
        f = t**3 - t - 2.0d0
    end function f

    real(8) function first_derivative(t, step)
        implicit none
        real(8), intent(in) :: t, step

        first_derivative = (f(t + step) - f(t - step)) / (2.0d0 * step)
    end function first_derivative

    real(8) function second_derivative(t, step)
        implicit none
        real(8), intent(in) :: t, step

        second_derivative = (f(t + step) - 2.0d0 * f(t) + f(t - step)) / (step**2)
    end function second_derivative

end program numerical_differentiation