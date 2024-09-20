program erf
    use FoX_wxml
    implicit none                

    integer, parameter :: long = selected_real_kind(9, 99)
    real(kind=long), parameter :: SqrtPI = 1.77245385091
    real(kind=long) :: arg
    real(kind=long) :: result
    integer         :: its
    type(xmlf_t)    :: xf


    its = 0
    arg = 0
    print*, "Enter the argument to be evaluated by the Error Function:"
    read*, arg
    if ((arg.gt.1.0).or.(arg.le.0.0)) stop "argument must be between 0 and 1"
    print*, "Enter the number of cycles to iterate through the series:"
    read*, its

    call xml_OpenFile(filename='erf.xhtml', xf=xf, unit=28, broken_indenting=.true.)
    call xml_DeclareNamespace(xf, nsURI='http://www.w3.org/1999/xhtml')
    call xml_NewElement(xf, name='html')
      call xml_NewElement(xf, name='head')
        call xml_NewElement(xf, name='title')
          call xml_AddCharacters(xf, chars='Error Function')
        call xml_EndElement(xf, name='title')
      call xml_EndElement(xf, name='head')
      call xml_NewElement(xf, name='body')
        call xml_NewElement(xf, name='h1')
          call xml_AddCharacters(xf, chars='Error Function')
        call xml_EndElement(xf, name='h1')

        call xml_NewElement(xf, name='h2')
          call xml_AddCharacters(xf, chars='Using a do loop')
        call xml_EndElement(xf, name='h2')

        print*, "Using a do loop to evaluate the Error Function."
        result = erf_loop(arg,its)
        print*, "Value is:", result

        call xml_NewElement(xf, name='p')
           call xml_AddCharacters(xf, chars='Result is:')
           call xml_AddCharacters(xf, chars=result)
        call xml_EndElement(xf, name='p')

        call xml_NewElement(xf, name='h2')
          call xml_AddCharacters(xf, chars='Using a recursive approach')
        call xml_EndElement(xf, name='h2')

        print*, "Using a recursive approach to evaluate the Error Function."
        result = erf_recur(arg,its)
        print*, "Value is:", result

        call xml_NewElement(xf, name='p')
           call xml_AddCharacters(xf, chars='Result is:')
           call xml_AddCharacters(xf, chars=result)
        call xml_EndElement(xf, name='p')

      call xml_EndElement(xf, name='body')
    call xml_EndElement(xf, name='html')
    call xml_Close(xf)

    contains

    function erf_loop(x,i)
        real(kind=long) :: erf_loop
        real(kind=long), intent(in) :: x
        integer, intent(in) :: i

        integer :: n
        
        erf_loop = 0.0

        do n = 0, i 
          erf_loop = erf_loop + ( (2*((-1)**n)) / (SqrtPI*(2*n+1)*factorial(n)) *(x**(2*n+1)) )
        end do

    end function erf_loop

    recursive real(kind=long) function erf_recur(x,n) result(erf)
        real(kind=long), intent(in) :: x
        integer, intent(in) :: n

        if (n.ge.1) then 
          erf = erf_recur(x,n-1) + ( (2*((-1)**n)) / (SqrtPI*(2*n+1)*factorial(n)) *(x**(2*n+1)) )
        else if (n.eq.0) then 
          erf = ( (2*((-1)**n)) / (SqrtPI*(2*n+1)*factorial(n)) *(x**(2*n+1)) )
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
