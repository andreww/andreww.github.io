#!/usr/bin/perl 
use XML::LibXML;

my $docRoot =XML::LibXML->new()->parse_file('monty_ns.xml');

my $context = XML::LibXML::XPathContext->new($docRoot);
$context->registerNs('q', 'http://www.example.com/quotes');
$context->registerNs('f', 'http://www.example.com/films');

my $result = $context->findnodes('/f:film/@name');

print $result . "\n";


