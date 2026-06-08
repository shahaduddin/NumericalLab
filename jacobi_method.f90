program jacobi_method
    implicit none

    integer :: n, i, j, iter, max_iter
    real(8) :: tol, diff, sum, temp
    real(8), allocatable :: a(:,:), b(:), x(:), x_new(:)

    print *, 'Jacobi Iterative Method Program'
    print *, 'Enter number of unknowns:'
    read *, n

    if (n <= 0) then
        print *, 'Error: number of unknowns must be positive.'
        stop
    end if

    allocate(a(n, n), b(n), x(n), x_new(n))

    print *, 'Enter the coefficient matrix A row by row:'
    do i = 1, n
        read *, (a(i, j), j = 1, n)
    end do

    print *, 'Enter the right-hand side vector b:'
    read *, (b(i), i = 1, n)

    print *, 'Enter the initial guess vector x0:'
    read *, (x(i), i = 1, n)

    print *, 'Enter tolerance:'
    read *, tol

    print *, 'Enter maximum number of iterations:'
    read *, max_iter

    do i = 1, n
        if (abs(a(i, i)) < 1.0d-12) then
            print *, 'Error: zero diagonal element encountered at row ', i
            deallocate(a, b, x, x_new)
            stop
        end if
    end do

    print *, 'Iterative solution process:'
    do iter = 1, max_iter
        do i = 1, n
            sum = 0.0d0
            do j = 1, n
                if (j /= i) then
                    sum = sum + a(i, j) * x(j)
                end if
            end do
            x_new(i) = (b(i) - sum) / a(i, i)
        end do

        diff = 0.0d0
        do i = 1, n
            diff = max(diff, abs(x_new(i) - x(i)))
            x(i) = x_new(i)
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

    deallocate(a, b, x, x_new)
end program jacobi_method