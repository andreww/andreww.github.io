#! /usr/bin/perl -w

use strict;

use XML::LibXML;

my $xpc = XML::LibXML::XPathContext->new();
$xpc->registerNs('kml', 'http://earth.google.com/kml/2.0');
$xpc->registerNs('dc', 'http://purl.org/dc/elements/1.1/');
$xpc->registerNs('qml', 'http://quakeml.ethz.ch/ns/eventlist/location');

my $dr = XML::LibXML->new()->parse_file('hypoDD.kml');
$xpc->setContextNode($dr);


my $placemarks = $xpc->findnodes("##-XPATH-1-##");

foreach my $location ($placemarks->get_nodelist) {
   $xpc->setContextNode($location);
   my $event_id = $xpc->findvalue('##-XPATH-2-##');
   my $initial_latitude = $xpc->findvalue("##-XPATH-3-##");
   my $initial_longitude = $xpc->findvalue("##-XPATH-4-##");
   $xpc->setContextNode($dr);
   my $final_latitude = $xpc->findvalue("##-XPATH-5-##"
      . $event_id . "##-more-XPATH-5-##");
   my $final_longitude = $xpc->findvalue("##-XPATH-6-##"
      . $event_id . "##-more-XPATH-6-##");

   my $seperation = &great_circle($initial_longitude, $initial_latitude, $final_longitude, $final_latitude);

   print "Event $event_id was moved by $seperation km\n";

}



sub great_circle {
# This subroutine returns the seperation between two points 
# on the Earth's surface in km given the latitude and longitude
# in degrees. Takes four arguments: long 1, lat 1, long 2, lat 2.

   die "great_circle needs exactly four arguments\n"
      unless ((scalar @_) == 4);
   my ($long_1, $lat_1, $long_2, $lat_2) = @_;
   $long_1 = &deg2rad($long_1);
   $lat_1 = &deg2rad($lat_1);
   $long_2 = &deg2rad($long_2);
   $lat_2 = &deg2rad($lat_2);

   # Assuming a spherical earth of radius 6367.45
   # km - this is the mean radius of the oblate spheroid 
   # and I am sure there are better ways to do this.
   # Also, I'm making sure that the delta rads are positive.
   my $d = 2 * 6367.45 * asin (sqrt(
      haversine($lat_2 - $lat_1) + cos($lat_1)*cos($lat_2) *
      haversine($long_2 - $long_1)
      ));
}

# Some trig functions. See man perlfunc and 
# http://en.wikipedia.org/wiki/Haversine_formula
sub haversine { (sin($_[0]/2))**2 }
sub asin { atan2($_[0], sqrt(1 - $_[0] * $_[0])) }
sub deg2rad { $_[0] * (3.141592653589793/180) }
