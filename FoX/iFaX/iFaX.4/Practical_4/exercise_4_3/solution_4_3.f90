module m_handlers
  use FoX_sax
  implicit none

  logical, save :: in_latitude = .false.
  logical, save :: in_longitude = .false.

  character(len=20), save :: latitude
  character(len=20), save :: longitude
  character(len=20), save :: lat_units
  character(len=20), save :: lon_units

contains

  subroutine startDocument_handler
  end subroutine startDocument_handler

  subroutine startElement_handler(namespaceURI, localname, name, atts)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name
    type(dictionary_t), intent(in) :: atts

    if (name=='latitude') then
      in_latitude = .true.
      if (hasKey(atts, 'unit')) then
        lat_units = getValue(atts, 'unit')
      endif
    elseif (name=='longitude') then
      in_longitude = .true.
      if (hasKey(atts, 'unit')) then
        lon_units = getValue(atts, 'unit')
      endif
    endif
  end subroutine startElement_handler

  subroutine endElement_handler(namespaceURI, localname, name)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name
    if (name=='latitude') then
      in_latitude = .false.
    elseif (name=='longitude') then
      in_longitude = .false.
    endif
  end subroutine endElement_handler

  subroutine characters_handler(chars)
    character(len=*), intent(in) :: chars

    if (in_latitude) then
      latitude = chars
    elseif (in_longitude) then
      longitude = chars
    endif
  end subroutine characters_handler

  subroutine endDocument_handler
  end subroutine endDocument_handler

  subroutine print_result
    print*, 'Earthquake location was at latitude '//trim(latitude)//' '//trim(lat_units) &
	//' and longitude '//trim(longitude)//' '//trim(lon_units)
  end subroutine print_result

end module m_handlers

program exercise_4_3

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

  call print_result

end program exercise_4_3
