#!/bin/sh
# Toby's pure sh xpath script. See http://uszla.me.uk/space/blog/2007/09/21
# with command line support removed for this exercise. 


XPATH='/f:film/@name'
FILE='monty_ns.xml'
NSD='setns q=http://www.example.com/quotes 
setns f=http://www.example.com/films'


XPATH="$NSD
xpath $XPATH" 

echo "$XPATH" | xmllint --noent --shell "$FILE" \
              | sed -e 's/.*:\(.*\)/\1/;$d'
