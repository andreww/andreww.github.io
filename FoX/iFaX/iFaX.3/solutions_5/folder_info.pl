#! /usr/bin/perl -w

use strict;

use XML::LibXML;

my $xpc = XML::LibXML::XPathContext->new();
$xpc->registerNs('kml', 'http://earth.google.com/kml/2.0');
$xpc->registerNs('dc', 'http://purl.org/dc/elements/1.1/');
$xpc->registerNs('qml', 'http://quakeml.ethz.ch/ns/eventlist/location');

my $dr = XML::LibXML->new()->parse_file('hypoDD.kml');
$xpc->setContextNode($dr);
my $folders = $xpc->findnodes("//kml:Folder");          # XPath needed (1)
my $name = 0;

foreach my $folder_node ($folders->get_nodelist) {
   $xpc->setContextNode($folder_node);

   print "Found a <folder>:\n";
   $name = $xpc->findvalue("kml:name");                 # XPath needed (2)
   if ($name) {
       print "\tFolder <name> is $name\n";
   } else {
       print "\tand the folder had no <name>\n";
   }
   print "\tthis folder has " . $xpc->findvalue('count(kml:Placemark)') . " <Placemark>s\n";   # XPath needed (3)
   $name = 0;
}

