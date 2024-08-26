#!/bin/bash

# Check if arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <OWL_FILE> <PARENT_URI>"
  exit 1
fi

OWLFILE=$1
PARENT_URI=$2

# Initialize lists
CLASSES=$(./getdirectsubclasses.sh $OWLFILE "$PARENT_URI")
ALL_CLASSES=""

while [[ ! -z "$CLASSES" ]]
do
  # Collect current classes
  ALL_CLASSES="$ALL_CLASSES\n$CLASSES"
  # Find subclasses of current classes
  NEW_CLASSES=$(for CLASS in $CLASSES; do ./getdirectsubclasses.sh $OWLFILE "$CLASS"; done | sort -u)
  # Update classes for the next iteration
  CLASSES=$NEW_CLASSES
done

# Output all collected classes
echo -e "$ALL_CLASSES" | sort -u

