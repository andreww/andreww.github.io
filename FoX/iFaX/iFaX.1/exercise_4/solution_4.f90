program homepage

    use FoX_wxml
    
    implicit none
    type(xmlf_t) :: xf

! Open the xml document
    call xml_OpenFile(filename='homepage.xhtml', xf=xf, unit=20)
      call xml_DeclareNamespace(xf, nsURI='http://www.w3.org/1999/xhtml')
      call xml_NewElement(xf, name='html')
! The document head...
        call xml_NewElement(xf, name='head')
          call xml_NewElement(xf, name='title')
            call xml_AddCharacters(xf, chars="Andrew's home page")
          call xml_EndElement(xf, name='title')
        call xml_EndElement(xf, name='head')
! The document body...
        call xml_NewElement(xf, name='body')
          call xml_NewElement(xf, name='h1')
            call xml_AddCharacters(xf, chars="Andrew's home page")
          call xml_EndElement(xf, name='h1')
          call xml_NewElement(xf, name='p')
            call xml_AddCharacters(xf, &
             & chars="I'm a postdoctoral research fellow and was involved in the ")
            call xml_NewElement(xf, name='i')
              call xml_AddCharacters(xf, chars="e")
            call xml_EndElement(xf, name='i')
            call xml_AddCharacters(xf, &
             & chars="Minerals project. This is not my web site.")
          call xml_EndElement(xf, name='p')
        call xml_EndElement(xf, name='body')
! The end of the document.
      call xml_EndElement(xf, name='html')
    call xml_Close(xf)

end program homepage
