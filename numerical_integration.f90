program numerical_integration
    implicit none

    real(8) :: a, b, approx, exact, abs_error, rel_error
    integer :: choice, n

    print *, 'Numerical Integration Program'
    print *, 'Choose a method:'
    print *, '1. Trapezoidal Rule'
    print *, '2. Simpson''s 1/3 Rule'
    print *, '3. Simpson''s 3/8 Rule'
    print *, '4. Compare All Methods'
    read *, choice

    print *, 'Enter lower limit a:'
    read *, a

    print *, 'Enter upper limit b:'
    read *, b

    print *, 'Enter number of subintervals n:'
    read *, n

    if (n <= 0) then
        print *, 'Error: number of subintervals must be positive.'
        stop
    end if

    exact = exact_integral(a, b)

    select case (choice)
    case (1)
        approx = trapezoidal_rule(a, b, n)
        call report_result('Trapezoidal Rule', approx, exact)
    case (2)
        if (mod(n, 2) /= 0) then
            print *, 'Error: Simpson''s 1/3 Rule requires an even number of subintervals.'
            stop
        end if
        approx = simpson_one_third(a, b, n)
        call report_result('Simpson''s 1/3 Rule', approx, exact)
    case (3)
        if (mod(n, 3) /= 0) then
            print *, 'Error: Simpson''s 3/8 Rule requires n to be a multiple of 3.'
            stop
        end if
        approx = simpson_three_eighth(a, b, n)
        call report_result('Simpson''s 3/8 Rule', approx, exact)
    case (4)
        print *, 'Accuracy comparison:'
        approx = trapezoidal_rule(a, b, n)
        call report_result('Trapezoidal Rule', approx, exact)

        if (mod(n, 2) == 0) then
            approx = simpson_one_third(a, b, n)
            call report_result('Simpson''s 1/3 Rule', approx, exact)
        else
            print *, 'Simpson''s 1/3 Rule skipped: n must be even.'
        end if

        if (mod(n, 3) == 0) then
            approx = simpson_three_eighth(a, b, n)
            call report_result('Simpson''s 3/8 Rule', approx, exact)
        else
            print *, 'Simpson''s 3/8 Rule skipped: n must be a multiple of 3.'
        end if
    case default
        print *, 'Invalid option selected.'
    end select

contains

    real(8) function f(x)
        implicit none
        real(8), intent(in) :: x

        ! Example function: f(x) = x^3 - x - 2
        f = x**3 - x - 2.0d0
    end function f

    real(8) function antiderivative(x)
        implicit none
        real(8), intent(in) :: x

        antiderivative = (x**4) / 4.0d0 - (x**2) / 2.0d0 - 2.0d0 * x
    end function antiderivative

    real(8) function exact_integral(lower, upper)
        implicit none
        real(8), intent(in) :: lower, upper

        exact_integral = antiderivative(upper) - antiderivative(lower)
    end function exact_integral

    real(8) function trapezoidal_rule(lower, upper, subintervals)
        implicit none
        real(8), intent(in) :: lower, upper
        integer, intent(in) :: subintervals
        real(8) :: h, x
        integer :: i

        h = (upper - lower) / real(subintervals, kind=8)
        trapezoidal_rule = 0.5d0 * (f(lower) + f(upper))

        do i = 1, subintervals - 1
            x = lower + real(i, kind=8) * h
            trapezoidal_rule = trapezoidal_rule + f(x)
        end do

        trapezoidal_rule = trapezoidal_rule * h
    end function trapezoidal_rule

    real(8) function simpson_one_third(lower, upper, subintervals)
        implicit none
        real(8), intent(in) :: lower, upper
        integer, intent(in) :: subintervals
        real(8) :: h, x
        integer :: i

        h = (upper - lower) / real(subintervals, kind=8)
        simpson_one_third = f(lower) + f(upper)

        do i = 1, subintervals - 1
            x = lower + real(i, kind=8) * h
            if (mod(i, 2) == 0) then
                simpson_one_third = simpson_one_third + 2.0d0 * f(x)
            else
                simpson_one_third = simpson_one_third + 4.0d0 * f(x)
            end if
        end do

        simpson_one_third = simpson_one_third * h / 3.0d0
    end function simpson_one_third

    real(8) function simpson_three_eighth(lower, upper, subintervals)
        implicit none
        real(8), intent(in) :: lower, upper
        integer, intent(in) :: subintervals
        real(8) :: h, x
        integer :: i

        h = (upper - lower) / real(subintervals, kind=8)
        simpson_three_eighth = f(lower) + f(upper)

        do i = 1, subintervals - 1
            x = lower + real(i, kind=8) * h
            if (mod(i, 3) == 0) then
                simpson_three_eighth = simpson_three_eighth + 2.0d0 * f(x)
            else
                simpson_three_eighth = simpson_three_eighth + 3.0d0 * f(x)
            end if
        end do

        simpson_three_eighth = simpson_three_eighth * 3.0d0 * h / 8.0d0
    end function simpson_three_eighth

    subroutine report_result(method_name, approx_value, exact_value)
        implicit none
        character(len=*), intent(in) :: method_name
        real(8), intent(in) :: approx_value, exact_value
        real(8) :: abs_error, rel_error

        abs_error = abs(exact_value - approx_value)
        if (abs(exact_value) > 1.0d-12) then
            rel_error = abs_error / abs(exact_value) * 100.0d0
        else
            rel_error = 0.0d0
        end if

        print *, 'Method: ', method_name
        print *, 'Approximate integral = ', approx_value
        print *, 'Exact integral       = ', exact_value
        print *, 'Absolute error       = ', abs_error
        print *, 'Relative error (%)   = ', rel_error
    end subroutine report_result

end program numerical_integration