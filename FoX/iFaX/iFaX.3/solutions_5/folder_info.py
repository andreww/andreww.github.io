#!/usr/bin/python
import lxml.etree

namespaces = {'kml':'http://earth.google.com/kml/2.0',
              'dc':'http://purl.org/dc/elements/1.1/',
              'qml':'http://quakeml.ethz.ch/ns/eventlist/location'}

docRoot = lxml.etree.parse(source="hypoDD.kml")

folders = docRoot.xpath("//kml:Folder", namespaces)
# print folders # For debugging

for node in folders:
    answer = node.xpath("kml:name/text()", namespaces)[0]
    print "A folder called: " + str(answer)

    answer = node.xpath("count(kml:Placemark)", namespaces)
    print "has: " + str(int(answer)) + " Placemarks"

