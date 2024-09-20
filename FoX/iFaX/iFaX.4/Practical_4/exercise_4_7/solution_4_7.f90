module m_handlers

  use FoX_common
  use FoX_sax
  implicit none

  integer, parameter :: NOWHERE = 0
  integer, parameter :: LATITUDE = 1
  integer, parameter :: LONGITUDE = 2
  integer, parameter :: DEPTH = 3
  integer, parameter :: MAGNITUDE = 4

  type(xml_t), save :: xf

  integer, save :: location

  real :: centroid(2)

  integer, save :: i

  logical, save :: lastEventWasCharacter = .false.
  character(len=200) :: string = ""
  integer :: stringLength = 0

contains

  subroutine startDocument_handler
    i = 0
    location = NOWHERE
    centroid = (/0, 0/)
  end subroutine startDocument_handler

  subroutine startElement_handler(namespaceURI, localname, name, atts)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name
    type(dictionary_t), intent(in) :: atts

    call deal_with_characters

    if (name=='location') then
      i = i + 1
    elseif (name=='latitude') then
      location = LATITUDE
    elseif (name=='longitude') then
      location = LONGITUDE
    endif

  end subroutine startElement_handler

  subroutine endElement_handler(namespaceURI, localname, name)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name

    call deal_with_characters

    if (localName=='Folder') then
      ! End of the first folder, so now we
      ! can calculate the average and quit
      centroid = centroid/i
      call stop_parser(xf)
    endif

    location = NOWHERE

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

    real :: lat, lon
    if (stringLength>0) then
      if (location/=FINISHED) then
        select case(location)
        case (LATITUDE)
          call rts(string, lat)
          centroid(1) = centroid(1) + lat
        case (LONGITUDE)
          call rts(string, lon)
          centroid(2) = centroid(2) + lon
        end select
      endif
    endif
    lastEventWasCharacter = .false.
  end subroutine deal_with_characters

  subroutine print_result

    print*, 'Centroid lies at lat: ', centroid(1), ', lon: ', centroid(2)
  end subroutine print_result

end module m_handlers

program exercise_4_6

  use FoX_sax
  use m_handlers
  implicit none
  
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

  call print_result

end program exercise_4_6
