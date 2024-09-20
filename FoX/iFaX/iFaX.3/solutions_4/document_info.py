#!/usr/bin/python
import lxml.etree

namespaces = {'kml':'http://earth.google.com/kml/2.0',
              'dc':'http://purl.org/dc/elements/1.1/',
              'qml':'http://quakeml.ethz.ch/ns/eventlist/location'}

docRoot = lxml.etree.parse(source="hypoDD.kml")

answer = docRoot.xpath("/kml:kml/kml:Document/kml:name/text()", namespaces)[0]
print "The document is called: " + answer

answer = docRoot.xpath("count(/kml:kml/kml:Document/kml:Folder)", namespaces)
print "There are a total of: " + str(int(answer)) + " Folders"

answer = docRoot.xpath("count(/kml:kml/kml:Document/kml:Folder/kml:Placemark)", namespaces)
print "And: " + str(int(answer)) + " Placemarks"

