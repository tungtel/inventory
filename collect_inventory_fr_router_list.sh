#!/bin/bash

# Input file containing the list of filenames
filelist="inventory_list.txt"

# Output file to store the combined extracted output
output_file="inventory_output.txt"

> inventory_output.txt
sed -i 's/ *$//' inventory_list.txt

# Loop through each filename in the filelist
while IFS= read -r filelist; do
  # Execute the sed command and append the output to the output file
  config_file="/var/rancid/routers/configs/$filelist"
  sed -n '/show chassis hardware models/,/show chassis routing-engine/p' "$config_file" >> "$output_file"
  sed -n '/show version detail/,+20p' "$config_file" >> "$config_file" >> "$output_file"
  echo "****** ping test *****" >> "$output_file"
  ping -c 1 -n -W 1 "$filelist" && 
  echo "Ping Status of $filelist : Success" >> "$output_file" || 
  echo "Ping Status of $filist : Failed" >> "$output_file"
  
  # Add a separator between outputs from different files (optional)
  echo "--------------------------------------------------------------------------------" >> "$output_file"
  
done < "$filelist"
