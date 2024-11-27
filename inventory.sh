#!/bin/bash

# Input file containing the list of filenames
filelist="inventory_list.txt"

# Output file to store the combined extracted output
output_file="inventory_output.txt"
> inventory_output.txt
sed -i 's/ *$//' inventory_list.txt
# Loop through each filename in the filelist
while IFS= read -r inventory_list; do
  # Execute the sed command and append the output to the output file
  config_file="/var/rancid/routers/configs/$inventory_list"
  sed -n '/show chassis hardware models/,/show chassis routing-engine/p' "$config_file" >> "$output_file"

  # Add a separator between outputs from different files (optional)
  echo "--------------------------------------------------------------------------------" >> "$output_file"
done < "$filelist"

echo "Combined output saved to: $output_file"
