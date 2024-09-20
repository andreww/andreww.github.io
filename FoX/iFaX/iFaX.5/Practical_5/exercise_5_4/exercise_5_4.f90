program example_5_4

  use FoX_dom 
  implicit none

  integer :: i
  type(Node), pointer :: doc, placemark, point
  type(NodeList), pointer :: placemarkList, pointList

  doc => parseFile("hypoDD.kml")

  placemarkList => getElementsByTagname(doc, "Placemark")

  print*, "There are ", getLength(placemarkList), " Placemarks in this KML file."

  do i = 0, getLength(placemarkList) - 1
    placemark => item(placemarkList, i)
    print*, getNodeName(placemark)
  enddo

  do i = 0, getLength(placemarkList) - 1
    placemark => item(placemarkList, i)
    pointList => getElementsByTagname(placemark, "Point")
    print*, "Placemark number ", i, " has ", getLength(pointList), "Points."
    point => item(pointlist, 0)
    print*, "Obviously, it's name is ", getNodeName(point)
  enddo

  call destroy(doc)

end program example_5_4
