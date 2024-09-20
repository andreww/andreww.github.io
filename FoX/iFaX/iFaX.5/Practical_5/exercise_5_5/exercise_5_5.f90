program example_5_5

  use FoX_dom 
  implicit none

  integer :: i
  type(Node), pointer :: doc, placemark, description
  type(NodeList), pointer :: placemarkList, descriptionList

  doc => parseFile("hypoDD.kml")

  placemarkList => getElementsByTagname(doc, "Placemark")

  print*, "There are ", getLength(placemarkList), " Placemarks in this KML file."

  do i = 0, getLength(placemarkList) - 1
    placemark => item(placemarkList, i)
    descriptionList => getElementsByTagname(placemark, "description")
    print*, "Placemark number ", i, " has ", getLength(descriptionList), "descriptions."
    description => item(descriptionlist, 0)
    print*, "Obviously, its nodename is ", getNodeName(description)
  enddo

  call destroy(doc)

end program example_5_5
