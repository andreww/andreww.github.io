#! /usr/bin/perl -w

use strict;

use XML::LibXML;

my $xpc = XML::LibXML::XPathContext->new();
$xpc->registerNs('kml', 'http://earth.google.com/kml/2.0');
$xpc->registerNs('dc', 'http://purl.org/dc/elements/1.1/');
$xpc->registerNs('qml', 'http://quakeml.ethz.ch/ns/eventlist/location');

my $dr = XML::LibXML->new()->parse_file('hypoDD.kml');
$xpc->setContextNode($dr);


my $result = $xpc->findvalue("/kml:kml/kml:Document/kml:name/text()"); 
print "The document is called: " . $result . "\n";

$result = $xpc->findvalue("count(/kml:kml/kml:Document/kml:Folder)"); 
print "There are a total of: " . $result . " Folders\n";

$result = $xpc->findvalue("count(/kml:kml/kml:Document/kml:Folder/kml:Placemark)"); 
print "And: " . $result . " Placemarks\n";
