program sor_method
    implicit none

    integer :: n, i, j, iter, max_iter
    real(8) :: tol, omega, diff, sum, old_value, new_value
    real(8), allocatable :: a(:,:), b(:), x(:)

    print *, 'Successive Over-Relaxation (SOR) Method Program'
    print *, 'Enter number of unknowns:'
    read *, n

    if (n <= 0) then
        print *, 'Error: number of unknowns must be positive.'
        stop
    end if

    allocate(a(n, n), b(n), x(n))

    print *, 'Enter the coefficient matrix A row by row:'
    do i = 1, n
        read *, (a(i, j), j = 1, n)
    end do

    print *, 'Enter the right-hand side vector b:'
    read *, (b(i), i = 1, n)

    print *, 'Enter the initial guess vector x0:'
    read *, (x(i), i = 1, n)

    print *, 'Enter relaxation factor omega (0 < omega < 2):'
    read *, omega

    if (omega <= 0.0d0 .or. omega >= 2.0d0) then
        print *, 'Error: omega must satisfy 0 < omega < 2.'
        deallocate(a, b, x)
        stop
    end if

    print *, 'Enter tolerance:'
    read *, tol

    print *, 'Enter maximum number of iterations:'
    read *, max_iter

    do i = 1, n
        if (abs(a(i, i)) < 1.0d-12) then
            print *, 'Error: zero diagonal element encountered at row ', i
            deallocate(a, b, x)
            stop
        end if
    end do

    print *, 'Iterative solution process:'
    do iter = 1, max_iter
        diff = 0.0d0

        do i = 1, n
            sum = 0.0d0
            do j = 1, n
                if (j /= i) then
                    sum = sum + a(i, j) * x(j)
                end if
            end do

            old_value = x(i)
            new_value = (b(i) - sum) / a(i, i)
            x(i) = (1.0d0 - omega) * old_value + omega * new_value
            diff = max(diff, abs(x(i) - old_value))
        end do

        write(*,'(A,I4,A,100F14.8)') 'Iteration ', iter, ': ', (x(i), i = 1, n)

        if (diff < tol) then
            print *, 'Converged after ', iter, ' iterations.'
            exit
        end if
    end do

    if (diff >= tol) then
        print *, 'Maximum iterations reached without full convergence.'
    end if

    print *, 'Approximate solution vector:'
    write(*,'(100F14.8)') (x(i), i = 1, n)

    deallocate(a, b, x)
end program sor_method