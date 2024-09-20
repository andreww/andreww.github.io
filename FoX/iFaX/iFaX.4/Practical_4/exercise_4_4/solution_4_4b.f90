module m_handlers
  use FoX_sax
  implicit none

  logical, save :: kml_desc = .false.
  logical, save :: dc_desc = .false.

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
    if (localname=="description") then
      if (namespaceURI=="http://earth.google.com/kml/2.0") then
        kml_desc = .true.
      elseif (namespaceURI=="http://purl.org/dc/elements/1.1/") then
        dc_desc = .true.
      endif
    endif
  end subroutine startElement_handler

  subroutine endElement_handler(namespaceURI, localname, name)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name

    call deal_with_characters
    if (localname=="description") then
      if (namespaceURI=="http://earth.google.com/kml/2.0") then
        kml_desc = .false.
      elseif (namespaceURI=="http://purl.org/dc/elements/1.1/") then
        dc_desc = .false.
      endif
    endif
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
      if (kml_desc) then
         print*, 'KML description:'
         print*, string
      elseif (dc_desc) then
         print*, 'Dublin Code description:'
         print*, string
      endif
    endif
    lastEventWasCharacter = .false.
  end subroutine deal_with_characters

end module m_handlers

program exercise_4_4

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
end program exercise_4_4
