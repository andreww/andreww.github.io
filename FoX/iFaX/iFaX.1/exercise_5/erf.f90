program erf

    implicit none                

    integer, parameter :: long = selected_real_kind(9, 99)
    real(kind=long), parameter :: SqrtPI = 1.77245385091
    real(kind=long) :: arg
    real(kind=long) :: result
    integer         :: its

    its = 0
    arg = 0
    print*, "Enter the argument to be evaluated by the Error Function:"
    read*, arg
    if ((arg.gt.1.0).or.(arg.le.0.0)) stop "argument must be between 0 and 1" 
    print*, "Enter the number of terms in the Taylor series:"
    read*, its

    print*, "Using a do loop to evaluate the Error Function."
    result = erf_loop(arg,its)
    print*, "Value is:", result
    
    print*, "Using a recursive approach to evaluate the Error Function."
    result = erf_recur(arg,its)
    print*, "Value is:", result
    
    contains

    function erf_loop(x,i)
        real(kind=long) :: erf_loop
        real(kind=long), intent(in) :: x
        integer, intent(in) :: i

        integer :: n
        
        erf_loop = 0.0

        do n = 0, i 
          erf_loop = erf_loop + ( (2*((-1)**n))*(x**(2*n+1)) / (SqrtPI*(2*n+1))*factorial(n)*(x**(2*n+1)) )
        end do

    end function erf_loop

    recursive real(kind=long) function erf_recur(x,n) result(erf)
        real(kind=long), intent(in) :: x
        integer, intent(in) :: n

        if (n.ge.1) then 
          erf = erf_recur(x,n-1) + ( (2*((-1)**n))*(x**(2*n+1)) / (SqrtPI*(2*n+1)*factorial(n))*(x**(2*n+1)) )
        else if (n.eq.0) then 
          erf = ( (2*((-1)**n))*(x**(2*n+1)) / (SqrtPI*(2*n+1)*factorial(n))*(x**(2*n+1)) )
        else
          stop "Error in erf_recur - negative value of n"
        end if
        
    end function erf_recur
    
    function factorial(y)
        integer :: factorial
        integer, intent(in) :: y
        integer :: j
        
        if (y.eq.0) then
          factorial = 1
        else if (y.ge.1) then
          factorial = 1
          do j = 1, y
              factorial = factorial * j
          end do
        else 
          stop "Factorial does not support negative arguments"
        end if
    end function factorial
        
end program erf
