module m_handlers
  use FoX_sax
  implicit none

contains

  subroutine startDocument_handler
    print*,'Started Document'
  end subroutine startDocument_handler

  subroutine startElement_handler(name, localname, namespaceURI, atts)
    character(len=*), intent(in) :: name
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: namespaceURI
    type(dictionary_t), intent(in) :: atts
    integer :: i
    print*, 'Started Element'
    do i = 1, len(atts)
      print*, 'Found Attribute'
    enddo
  end subroutine startElement_handler

  subroutine endElement_handler(name, localname, namespaceURI)
    character(len=*), intent(in) :: name
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: namespaceURI
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

program exercise_4_3

  use FoX_sax
  use m_handlers
  implicit none

  integer :: iostat
  type(xml_t) :: xf
  
  call open_xml_file(xf, 'input.xml')

  call parse(xf, &
    startDocument_handler = startDocument_handler, &
    startElement_handler = startElement_handler, &
    endElement_handler = endElement_handler, &
    characters_handler = characters_handler, &
    endDocument_handler = endDocument_handler &
    )

  call close_xml_t(xf)

end program exercise_4_3
