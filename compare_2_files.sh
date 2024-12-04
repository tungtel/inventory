#!/bin/bash

#missing_file : file contains list of patterns of lines to search for 
#router_db.txt : database file where script search for the matches 

missing_file="missing.txt"
router_db="router_db.txt"

# Read each line from missing.txt
# Ensures that leading/trailing whitespace is preserved
# Prevents backslashes from being interpreted as escape characters.

while IFS= read -r line; do
  # Check if the content of the line exists in router_db.txt and print the matching line
  # pattern="$line" : Assigns the content of the current line to the variable pattern
  # '$0 ~ pattern' : Checks if the current line in router_db.txt ($0) matches the pattern (~ is the match operator).
  # If a match is found, awk prints the matching line from router_db.txt . this case it will record to file matched_result.txt
  awk -v pattern="$line" '$0 ~ pattern' "$router_db"
done < "$missing_file" > matched_result.txt
