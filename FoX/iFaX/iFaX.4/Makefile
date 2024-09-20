
default: iFaX.4.html iFaX.4.pdf

iFaX.4.html: iFaX.4.txt
	asciidoc iFaX.4.txt

iFaX.4.pdf: iFaX.4.txt
	asciidoc -bdocbook iFaX.4.txt && dblatex -P doc.collab.show=0 -P latex.output.revhistory=0 -P doc.toc.show=0 iFaX.4.xml

clean:
	rm -f iFaX.4.html iFaX.4.xml iFaX.4.fo iFaX.4.pdf
