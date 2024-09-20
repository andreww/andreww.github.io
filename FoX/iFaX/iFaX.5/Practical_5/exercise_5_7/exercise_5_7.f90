program example_5_7

  use FoX_dom 
  implicit none

  integer :: i
  type(Node), pointer :: doc, location, year
  type(NodeList), pointer :: locationList

  integer :: year_value, id

  doc => parseFile("hypoDD.kml")

  locationList => getElementsByTagname(doc, "location")

  print*, "There are ", getLength(locationList), " locations in this XML file."

  do i = 0, getLength(locationList) - 1
    location => item(locationList, i)
    year => item( getElementsByTagname(location, "year"), 0)

    call extractDataContent(year, year_value)
    call extractDataAttribute(location, "unique_id", id)

    print*, "Earthquake number ", i, " has a unique_id ", id, " and took place in the year ", year_value
  enddo

  call destroy(doc)

end program example_5_7
