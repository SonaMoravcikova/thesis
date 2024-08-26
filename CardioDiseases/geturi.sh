#!/bin/bash

# Step 1: Get URI for "Cardiovascular System Disease"
parent_uri=$(xmllint --xpath "//*[local-name()='label' and text()='cardiovascular system disease']/parent::*/@*[local-name()='about']" doid.owl | cut -d\" -f2)
echo "Extracted URI: $parent_uri"
# Step 2: Extract all subclasses (URIs) under "Cardiovascular System Disease"
grep -B 1 "<rdfs:subClassOf rdf:resource=\"$parent_uri\"/>" doid.owl | grep '<rdf:Description rdf:about=' | sed -n 's/.*rdf:about="\([^"]*\)".*/\1/p' > cardiovascular_diseases_uris.txt

