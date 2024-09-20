#!/usr/bin/python
import lxml.etree

namespaces = {'q':'http://www.example.com/quotes', 'f':'http://www.example.com/films'}

docRoot = lxml.etree.parse(source="monty_ns.xml")

answer = docRoot.xpath("/f:film/@name", namespaces)

print answer

