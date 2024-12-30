#!/bin/bash

# import it with mongoimport and log an error if it fails
mongoimport --uri $CONNECTION_STRING --collection=restaurants --db=myplaces --file=/tmp/restaurants.json || echo "Failed to import data" > /tmp/import-error.txt
