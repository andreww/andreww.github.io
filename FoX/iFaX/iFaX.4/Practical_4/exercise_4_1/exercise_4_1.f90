module m_handlers
  use FoX_sax
  implicit none

contains

  subroutine startDocument_handler
    print*,'Started Document'
  end subroutine startDocument_handler

  subroutine startElement_handler(namespaceURI, localname, name, atts)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name
    type(dictionary_t), intent(in) :: atts
    print*, 'Started Element'
  end subroutine startElement_handler

  subroutine endElement_handler(namespaceURI, localname, name)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name
    print*, 'Ended Element'
  end subroutine endElement_handler

  subroutine characters_handler(chars)
    character(len=*), intent(in) :: chars
    print*, 'Found some characters'
  end subroutine characters_handler

  subroutine endDocument_handler
    print*, 'Ended Document'
  end subroutine endDocument_handler

end module m_handlers

program exercise_4_1

  use FoX_sax
  use m_handlers
  implicit none
  
  type(xml_t) :: xf
  integer :: iostat
  
  call open_xml_file(xf, 'input.xml', iostat)
  if (iostat/=0) then
    print*, 'error opening file'
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
end program exercise_4_1
