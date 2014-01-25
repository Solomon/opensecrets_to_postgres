#!/bin/bash

echo "Combining Files"

ruby combine_files.rb

echo "Fixing Spacing Issues"

sed -i '.original' -e ':a' -e 'N' -e '$!ba' -e 's/Oversight Bd\n/Oversight Bd/g' -e 's/Sciences\n/Sciences/g' combined_old_individual.txt

echo "splitting combined individual contributions file"

split -l 4000000 combined_old_individual.txt combined_old_individual_

