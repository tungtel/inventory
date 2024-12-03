[rancid@netbackup1ext inventory]$ cat extract_output_v1.sh 
#!/bin/bash

# Input file path
input_file="inventory_output.txt"

# Print header
echo -e "Range 1 (29-40)\tRange 2 (42-55)\tRange 3 (60-80)"

# Read file line by line and extract ranges
while IFS= read -r line; do
    # Skip lines containing "show chassis", "----------", or "BUILTIN"
    if [[ "$line" == *"show chassis"* || "$line" == *"----------"* || "$line" == *"BUILTIN"* ]]; then
        continue
    fi

    # Extract the specific ranges (preserve whitespace)
    range1=$(echo "$line" | cut -c 29-40)
    range2=$(echo "$line" | cut -c 42-55)
    range3=$(echo "$line" | cut -c 60-80)

    # Check if the line is completely empty (ignoring spaces in the ranges)
    if [[ -n "${range1// /}" || -n "${range2// /}" || -n "${range3// /}" ]]; then
        # Print the line if at least one range is non-empty
        printf "%s\t%s\t%s\n" "$range1" "$range2" "$range3"
    fi
done < "$input_file"
