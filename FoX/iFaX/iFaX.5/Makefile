
default: iFaX.5.html iFaX.5.pdf

iFaX.5.html: iFaX.5.txt
	asciidoc iFaX.5.txt

iFaX.5.pdf: iFaX.5.txt
	asciidoc -bdocbook iFaX.5.txt && dblatex -P doc.collab.show=0 -P latex.output.revhistory=0 -P doc.toc.show=0 iFaX.5.xml

clean:
	rm -f iFaX.5.html iFaX.5.xml iFaX.5.fo iFaX.5.pdf
