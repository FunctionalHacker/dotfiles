#!/bin/sh

checkupdates -d

CODE=$?

if [ $CODE -eq 2 ]; then
  echo "No updates available"
  exit 0
fi

exit $CODE
