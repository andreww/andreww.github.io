#!/bin/sh
# Toby's pure sh xpath script. See http://uszla.me.uk/space/blog/2007/09/21
# with command line and namespace support removed for this exercise. 

XPATH='/film/@name'
FILE='monty.xml'

echo "xpath $XPATH" | xmllint --noent --shell "$FILE" \
              | sed -e 's/.*:\(.*\)/\1/;$d'
