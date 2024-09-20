program exercise_5_1

  use FoX_dom
  implicit none

  type(Node), pointer :: doc

  doc => parseFile("output.xml")

  call destroy(doc)

end program exercise_5_1
