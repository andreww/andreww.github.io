program example_5_8

  use FoX_dom 
  implicit none

  integer :: i
  type(Node), pointer :: doc, point, coordinates
  type(NodeList), pointer :: pointList

  real :: coords(2)

  doc => parseFile("hypoDD.kml")

  pointList => getElementsByTagname(doc, "Point")

  print*, "There are ", getLength(pointList), " points in this XML file."

  do i = 0, getLength(pointList) - 1
    point => item(pointList, i)
    coordinates => item( getElementsByTagname(point, "coordinates"), 0)

    call extractDataContent(coordinates, coords)

    print*, "Earthquake number ", i, " took place at the coordinates ", coords
  enddo

  call destroy(doc)

contains

  function great_circle(initial, final)
  ! Calculate a great circle distance.
  ! Input is two sets of coordinates, 
  !       given in degrees lat/lon
  ! Output is a distance in km.

    real :: initial(2), final(2)
    real :: great_circle

    real :: x1, y1, x2, y2
    real, parameter :: deg2rad = (3.141592653589793/180.0)

    x1 = initial(1)*deg2rad
    y1 = initial(2)*deg2rad
    x2 = final(1)*deg2rad
    y2 = final(2)*deg2rad

    great_circle = 6367.35 *                                          &
      2 * asin(sqrt(                                                  &
        (sin((x2-x1)/2.0))**2 + cos(x1)*cos(x2)*(sin((y2-y1)/2.0))**2 &
      ))

  end function great_circle

end program example_5_8
