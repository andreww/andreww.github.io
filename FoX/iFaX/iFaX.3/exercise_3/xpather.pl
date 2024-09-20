#!/usr/bin/perl 
use XML::LibXML;

my $docRoot =XML::LibXML->new()->parse_file('monty_ns.xml');

my $result = XML::LibXML::XPathContext->new($docRoot)->findnodes('/film/@name');

print $result . "\n";


