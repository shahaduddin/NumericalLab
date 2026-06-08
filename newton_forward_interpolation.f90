program newton_forward_interpolation
    implicit none

    integer :: n, i, j
    real(8) :: x_query, h, u, result, term
    real(8), allocatable :: x(:), diff(:,:)

    print *, 'Newton Forward Difference Interpolation Program'
    print *, 'Enter number of data points:'
    read *, n

    if (n < 2) then
        print *, 'Error: at least two data points are required.'
        stop
    end if

    allocate(x(n), diff(n, n))
    diff = 0.0d0

    print *, 'Enter equally spaced x and y values as pairs:'
    do i = 1, n
        read *, x(i), diff(i, 1)
    end do

    h = x(2) - x(1)
    if (abs(h) < 1.0d-12) then
        print *, 'Error: x values must be distinct.'
        deallocate(x, diff)
        stop
    end if

    do i = 2, n
        if (abs((x(i) - x(i - 1)) - h) > 1.0d-10) then
            print *, 'Error: x values must be equally spaced.'
            deallocate(x, diff)
            stop
        end if
    end do

    do j = 2, n
        do i = 1, n - j + 1
            diff(i, j) = diff(i + 1, j - 1) - diff(i, j - 1)
        end do
    end do

    print *, 'Forward Difference Table:'
    call print_table(x, diff, n)

    print *, 'Enter the point where interpolation is required:'
    read *, x_query

    u = (x_query - x(1)) / h
    result = diff(1, 1)
    term = 1.0d0

    do i = 1, n - 1
        term = term * (u - real(i - 1, kind=8)) / real(i, kind=8)
        result = result + term * diff(1, i + 1)
    end do

    print *, 'Interpolated value at x = ', x_query, ' is ', result

    deallocate(x, diff)

contains

    subroutine print_table(xvals, table, size)
        implicit none
        integer, intent(in) :: size
        real(8), intent(in) :: xvals(size), table(size, size)
        integer :: row, col

        do row = 1, size
            write(*,'(F12.6,1X)', advance='no') xvals(row)
            do col = 1, size - row + 1
                write(*,'(F12.6,1X)', advance='no') table(row, col)
            end do
            print *
        end do
    end subroutine print_table

end program newton_forward_interpolation