program example_5_3

  use FoX_dom 
  implicit none

  integer :: i
  type(Node), pointer :: doc, elem, att
  type(NamedNodeMap), pointer :: attlist 

  doc => parseFile("output.xml")

  elem => getDocumentElement(doc)

  print*, "The value of the attribute called 'one' is: ", getAttribute(elem, "one") 
  print*, "The value of the attribute called 'two' is: ", getAttribute(elem, "two") 
  print*, "The value of the attribute called 'three' is: ", getAttribute(elem, "three") 
  print*, "The value of the attribute called 'four' is: ", getAttribute(elem, "four") 

  att => getAttributeNode(elem, "three") 
  if (.not.associated(att)) then
    print*,  "There is no node called 'three'."
  else
    print*, "The value of the node called 'three' is: ", getValue(att)
  endif

  att => getAttributeNode(elem, "four") 
  if (.not.associated(att)) then
    print*,  "There is no node called 'four'."
  else
    print*, "The value of the node called 'four' is: ", getValue(att)
  endif

  ! For advanced users:

  attlist => getAttributes(elem)

  do i = 0, getLength(attlist)-1
    att => item(attlist, i)
    print*, "Looking at attribute number ", i
    print*, "Attribute name is: ", getName(att)
    print*, "Attribute value is: ", getValue(att)
  enddo

  call destroy(doc)

end program example_5_3
