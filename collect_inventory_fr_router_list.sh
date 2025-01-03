#!/bin/bash

# Input file containing the list of filenames
filelist="inventory_list.txt"

# Output file to store the combined extracted output
output_file="inventory_output.txt"

> inventory_output.txt
sed -i 's/[ \t]*$//' inventory_list.txt

# Loop through each filename in the filelist
while IFS= read -r filelist; do
  # Execute the sed command and append the output to the output file
  config_file="/var/rancid/routers/configs/$filelist"
  sed -n '/show chassis hardware models/,/show chassis routing-engine/p' "$config_file" >> "$output_file"
  
done < "$filelist"
