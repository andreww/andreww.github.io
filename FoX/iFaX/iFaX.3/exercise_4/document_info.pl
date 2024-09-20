#! /usr/bin/perl -w

use strict;

use XML::LibXML;

my $xpc = XML::LibXML::XPathContext->new();
$xpc->registerNs('kml', 'http://earth.google.com/kml/2.0');
$xpc->registerNs('dc', 'http://purl.org/dc/elements/1.1/');
$xpc->registerNs('qml', 'http://quakeml.ethz.ch/ns/eventlist/location');

my $dr = XML::LibXML->new()->parse_file('hypoDD.kml');
$xpc->setContextNode($dr);


my $result = $xpc->findvalue("##-XPATH-1-##"); 
print "The document is called: " . $result . "\n";

$result = $xpc->findvalue("##-XPATH-2-##"); 
print "There are a total of: " . $result . " Folders\n";

$result = $xpc->findvalue("##-XPATH-3-##"); 
print "And: " . $result . " Placemarks\n";
