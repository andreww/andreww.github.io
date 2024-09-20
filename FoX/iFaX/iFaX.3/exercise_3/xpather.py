#!/usr/bin/python
import lxml.etree

docRoot = lxml.etree.parse(source="monty_ns.xml")

answer = docRoot.xpath("/film/@name")

print answer

