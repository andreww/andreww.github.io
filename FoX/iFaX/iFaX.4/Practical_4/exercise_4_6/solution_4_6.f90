module m_handlers
  use FoX_sax
  implicit none

  integer, parameter :: NOWHERE = 0
  integer, parameter :: LATITUDE = 1
  integer, parameter :: LONGITUDE = 2
  integer, parameter :: DEPTH = 3
  integer, parameter :: MAGNITUDE = 4

  integer, save :: location

  character(len=20), save :: id(10)
  character(len=20), save :: lat(10)
  character(len=20), save :: lon(10)
  character(len=20), save :: dep(10)
  character(len=20), save :: mag(10)

  integer, save :: i

  logical, save :: lastEventWasCharacter = .false.
  character(len=200) :: string = ""
  integer :: stringLength = 0

contains

  subroutine startDocument_handler
    i = 0
    location = NOWHERE
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
    elseif (name=='depth') then
      location = DEPTH
    elseif (name=='magnitude') then
      location = MAGNITUDE
    endif

    if (i<=10) then
      if (hasKey(atts, 'unique_id')) &
        id(i) = getValue(atts, 'unique_id')
    endif
  end subroutine startElement_handler

  subroutine endElement_handler(namespaceURI, localname, name)
    character(len=*), intent(in) :: namespaceURI
    character(len=*), intent(in) :: localname
    character(len=*), intent(in) :: name

    call deal_with_characters
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
    if (stringLength>0) then
      if (i <= 10) then
        select case(location)
        case (LATITUDE)
          lat(i) = string
        case (LONGITUDE)
          lon(i) = string
        case (MAGNITUDE)
          mag(i) = string
        case (DEPTH)
          dep(i) = string
        end select
      endif
    endif
    lastEventWasCharacter = .false.
  end subroutine deal_with_characters

  subroutine print_result

    real :: rlat(10), rlon(10)
    real :: centroid(2)
    do i = 1, 10
      read(lat(i), *) rlat(i)
      read(lon(i), *) rlon(i)
    enddo

    centroid(1) = sum(rlat)/10.0
    centroid(2) = sum(rlon)/10.0

    print*, "ID                  | LATITUDE           | LONGITUDE          | DEPTH              | MAGNITUDE"
    do i = 1, 10
      print*, id(i)//"|"//lat(i)//"|"//lon(i)//"|"//dep(i)//"|"//mag(i)
    enddo

    print*, 'Centroid lies at lat: ', centroid(1), ', lon: ', centroid(2)
  end subroutine print_result

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

  call print_result

end program exercise_4_6
