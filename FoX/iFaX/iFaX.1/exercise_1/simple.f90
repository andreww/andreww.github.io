program simple_document

    use FoX_wxml                   ! <- we need to USE the FoX module
    
    implicit none                
    type(xmlf_t) :: xf             ! <- this is the opaque representation of the
                                   !    XML file handle.
! Open the xml document
    call xml_OpenFile(filename='simple.xml', xf=xf, unit=20)
! Write the document
      call xml_NewElement(xf, name='MyXmlRoot')
        call xml_NewElement(xf, name='MyXmlElement')
          call xml_AddAttribute(xf, name='ANumericAttribute', value=2.0) 
          call xml_AddCharacters(xf, chars="Some text - a text node if you like")
        call xml_EndElement(xf, name='MyXmlElement')
        call xml_NewElement(xf, name='MyXmlElement')
          call xml_AddAttribute(xf, name='AStringAttribute',  & 
            & value='A string with embedded stuff - < > & and a space     .') 
          call xml_AddCharacters(xf, chars="Some text - a second text node if you like")
        call xml_EndElement(xf, name='MyXmlElement')
      call xml_EndElement(xf, name='MyXmlRoot')
! Close the document
    call xml_Close(xf)

end program simple_document
