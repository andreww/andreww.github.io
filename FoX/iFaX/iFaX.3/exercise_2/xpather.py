#!/usr/bin/python
import lxml.etree

docRoot = lxml.etree.parse(source="monty.xml")

result = docRoot.xpath("/film/@name")

print result

