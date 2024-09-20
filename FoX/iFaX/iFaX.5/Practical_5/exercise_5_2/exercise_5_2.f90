program example_5_2

  use FoX_dom 
  implicit none

  type(Node), pointer :: document, element 

  document => parseFile("output.xml")

  element => getDocumentElement(document)

  print*, "Root element is: ", getNodeName(element)
  print*, "Root element's namespace is: ", getNamespaceURI(element)
  print*, "Root element's localname is: ", getLocalName(element)

  call destroy(document)

end program example_5_2
