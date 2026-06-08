program lagrange_interpolation
    implicit none

    integer :: n, i, j
    real(8) :: x_query, y_interp, term
    real(8), allocatable :: x(:), y(:)

    print *, 'Lagrange Interpolation Program'
    print *, 'Enter number of data points:'
    read *, n

    if (n <= 0) then
        print *, 'Error: number of data points must be positive.'
        stop
    end if

    allocate(x(n), y(n))

    print *, 'Enter the data points as x and y pairs:'
    do i = 1, n
        read *, x(i), y(i)
    end do

    print *, 'Enter the point where interpolation is required:'
    read *, x_query

    y_interp = 0.0d0

    do i = 1, n
        term = y(i)
        do j = 1, n
            if (j /= i) then
                if (abs(x(i) - x(j)) < 1.0d-12) then
                    print *, 'Error: duplicate x-values are not allowed.'
                    deallocate(x, y)
                    stop
                end if
                term = term * (x_query - x(j)) / (x(i) - x(j))
            end if
        end do
        y_interp = y_interp + term
    end do

    print *, 'Interpolated value at x = ', x_query, ' is ', y_interp

    deallocate(x, y)
end program lagrange_interpolation