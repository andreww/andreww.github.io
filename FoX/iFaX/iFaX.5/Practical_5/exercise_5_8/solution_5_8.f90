program example_5_8

  use FoX_dom 
  implicit none

  integer :: i
  type(Node), pointer :: doc, &
     folder_1, folder_2, point_1, point_2, coordinates_1, coordinates_2
  type(NodeList), pointer :: folderList, pointList_1, pointList_2

  real :: coords_1(2), coords_2(2), distance

  doc => parseFile("hypoDD.kml")

  folderList => getElementsByTagName(doc, "Folder")
  folder_1 => item(folderList, 0)
  folder_2 => item(folderList, 1)

  pointList_1 => getElementsByTagname(folder_1, "Point")
  pointList_2 => getElementsByTagname(folder_2, "Point")

  do i = 0, getLength(pointList_1) - 1
    !Here we assume that both pointLists are the same length
    point_1 => item(pointList_1, i)
    point_2 => item(pointList_2, i)

    coordinates_1 => item( getElementsByTagname(point_1, "coordinates"), 0)
    coordinates_2 => item( getElementsByTagname(point_2, "coordinates"), 0)

    call extractDataContent(coordinates_1, coords_1)
    call extractDataContent(coordinates_2, coords_2)

    distance = great_circle(coords_1, coords_2)

    print*, "The calculated position of earthquake number ", i, " moved ", distance, "km"
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
