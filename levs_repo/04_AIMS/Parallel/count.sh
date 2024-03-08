#!/bin/bash
 nums=$(cat numbers.txt) # Read count_file.txt
 for num in $nums           # For each line in the file, start a loop
 do
     sleep $num             # Read the line and wait that many seconds
     echo $num              # Print the line
 done
