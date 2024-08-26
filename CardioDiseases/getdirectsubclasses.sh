#!/bin/bash

# Check if argument is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <OWL_FILE> <PARENT_URI>"
  exit 1
fi

OWLFILE=$1
PARENT_URI=$2

# Escape slashes in the URI
ESCAPED_URI=$(echo "$PARENT_URI" | sed 's/\//\\\//g')

# Extract direct subclasses
grep -A 1 "rdfs:subClassOf rdf:resource=\"$ESCAPED_URI\"" "$OWLFILE" | 	grep '<rdfs:label' | sed -n 's/.*rdfs:label="\(.*\)".*/\1/p'

