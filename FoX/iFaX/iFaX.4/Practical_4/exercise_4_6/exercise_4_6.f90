module m_handlers
  use FoX_sax
  implicit none

  logical, save :: lastEventWasCharacter = .false.
  character(len=200) :: string = ""
  integer :: stringLength = 0

contains

  subroutine startDocument_handler
  end subroutine startDocument_handler

  subroutine startElement_handler(namespaceURI, localname, name, atts)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name
    type(dictionary_t), intent(in) :: atts

    call deal_with_characters
    print*, "startElement_handler ", name
  end subroutine startElement_handler

  subroutine endElement_handler(namespaceURI, localname, name)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name

    call deal_with_characters
    print*, "endElement_handler ", name
  end subroutine endElement_handler

  subroutine characters_handler(chars)
    character(len=*), intent(in) :: chars

    if (lastEventWasCharacter) then
      string = string(:stringLength)//chars
      stringLength = stringLength + len(chars)
    else
      string = chars
      stringLength = len(chars)
    endif
    lastEventWasCharacter = .true.
  end subroutine characters_handler

  subroutine endDocument_handler
  end subroutine endDocument_handler

  subroutine deal_with_characters
    if (stringLength>0) then
      print*, "Amalgamated character event"
    endif
    lastEventWasCharacter = .false.
  end subroutine deal_with_characters

end module m_handlers

program exercise_4_6

  use FoX_sax
  use m_handlers
  implicit none
  
  type(xml_t) :: xf
  integer :: iostat
  
  call open_xml_file(xf, 'hypoDD.kml', iostat)
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
end program exercise_4_6
