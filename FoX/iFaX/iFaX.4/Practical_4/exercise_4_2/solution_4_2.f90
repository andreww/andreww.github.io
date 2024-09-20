module m_handlers
  use FoX_sax
  implicit none

  character(len=10), save :: string = 'EMPTY'

contains

  subroutine startDocument_handler
    print*,'Started Document'
  end subroutine startDocument_handler

  subroutine startElement_handler(namespaceURI, localname, name, atts)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name
    type(dictionary_t), intent(in) :: atts
    integer :: i
    print*, 'Started Element ', name
    do i = 1, len(atts)
      if (name=='latitude'.and.getQName(atts, i)=='unit') then
        string = getValue(atts, i)
      endif
    enddo
  end subroutine startElement_handler

  subroutine endElement_handler(namespaceURI, localname, name)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name
  end subroutine endElement_handler

  subroutine characters_handler(chars)
    character(len=*), intent(in) :: chars
  end subroutine characters_handler

  subroutine endDocument_handler
  end subroutine endDocument_handler

  subroutine print_result
    print*,' Result was ', string
  end subroutine print_result
end module m_handlers

program exercise_4_2

  use FoX_sax
  use m_handlers
  implicit none

  type(xml_t) :: xf
  integer :: iostat
  
  call open_xml_file(xf, 'input.xml', iostat)
  if (iostat/=0) then
    print*,'error opening file'
    stop
  endif

  call parse(xf, &
    startDocument_handler = startDocument_handler, &
    startElement_handler = startElement_handler, &
    endElement_handler = endElement_handler, &
    characters_handler = characters_handler, &
    endDocument_handler = endDocument_handler &
    )

  call close_xml_t(xf)

  call print_result
end program exercise_4_2
