#!/usr/bin/python
import lxml.etree
import math

#
# Functions follow - skip down for the XPath stuff
#

def great_circle(long_1, lat_1, long_2, lat_2):
    """This function returns the seperation between two points 
       on the Earth's surface in km given the latitude and longitude
       in degrees. Takes four arguments: long_1, lat_1, long_2, lat_2."""

    long_1 = deg2rad(long_1)
    lat_1 = deg2rad(lat_1)
    long_2 = deg2rad(long_2)
    lat_2 = deg2rad(lat_2)

    d = 2 * 6367.45 * math.asin(
       math.sqrt(haversine(lat_2 - lat_1))
            + math.cos(lat_1)*math.cos(lat_2) *
            haversine(long_2 - long_1))
    return d

def haversine(x):
    """The haversine formula - see http://en.wikipedia.org/wiki/Haversine_formula"""

    hav = (math.sin(x/2))**2
    return hav

def deg2rad(deg):
    rad = deg * (3.141592653589793/180)
    return rad

#
#  End of functions - start of XPath stuff
#

namespaces = {'kml':'http://earth.google.com/kml/2.0',
              'dc':'http://purl.org/dc/elements/1.1/',
              'qml':'http://quakeml.ethz.ch/ns/eventlist/location'}

docRoot = lxml.etree.parse(source="hypoDD.kml")

placemarks = docRoot.xpath("//kml:Folder[kml:name='Initial positions']/kml:Placemark", namespaces)
# print placemarks

for node in placemarks:
    event_id = node.xpath("qml:location/@unique_id", namespaces)[0]
#    print "This event has id:" + event_id

    initial_latitude = node.xpath("qml:location/qml:latitude/text()", namespaces)[0]
#    print "This event's initial latitude is:" + initial_latitude
 
    initial_longitude = node.xpath("qml:location/qml:longitude/text()", namespaces)[0]
#    print "This event's initial longitude is:" + initial_longitude

    final_latitude = node.xpath("//kml:Folder[kml:name='Final positions']/kml:Placemark/qml:location[@unique_id='" 
      + event_id + "']/qml:latitude/text()", namespaces)[0]
#    print "This event's final latitude is " + final_latitude 

    final_longitude = node.xpath("//kml:Folder[kml:name='Final positions']/kml:Placemark/qml:location[@unique_id='" 
      + event_id + "']/qml:longitude/text()", namespaces)[0]
#    print "This event's final longtude is: " + final_longitude

    distance = great_circle(eval(initial_longitude),
             eval(initial_latitude), eval(final_longitude), eval(final_latitude))

    print "Event " + event_id + " was moved by " + str(distance) + " km"

