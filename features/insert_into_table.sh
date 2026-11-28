#! /usr/bin/bash

read -p "Enter table to insert to: " table_name

data_file="$db_path/$table_name"
metadata_file="$db_path/${table_name}_metadata"
file_separator=":"

if [[ ! -e $metadata_file ]]
then 
	echo "No such table exist"
else
	
	while true
	do 
		row_data=""
		declare -i i=1
		
		# For each row insertion loop over each column
		while IFS=: read -r col_name col_PK col_datatype col_nullability _ _
		do
			# ==========================================
			# 1. Validate inserted values
			# ==========================================
			while true
			do 
				read -p "Insert column '$col_name' ($col_datatype): " value < /dev/tty
				
				if [[ -z $value ]] 
				then
					if [[ $col_nullability = 'NULL' ]]
					then
						break
					else
						echo "'$col_name' column can't be NULL"
						continue
					fi
				else
					# Validate data type
					if [[ $col_datatype = 'INT' && ! $value =~ ^(0|[1-9][0-9]*)$ ]]
					then 
						echo "'$col_name' must be an integer with no leading zeros"
						continue
					elif [[ $col_datatype = 'CHAR' && $value = *:* ]]
						then
						echo "Input can't contain ':' "
						continue
					fi
					
					# Validate PK uniqeness
					if [[ $col_PK = "PRIMARY_KEY" ]]
					then 
						if cut -d: -f"$i" "$data_file" | grep -qxF -- "$value" 
						then
							echo "Primary key must be unique"
							continue
						else
							break
						fi
					else
						break
					fi
				fi
			done
			
			
			[[ $i = 1 ]] && row_data+="${value}" || row_data+="${file_separator}${value}"
			i+=1
		done < $metadata_file
		
		# Insert row_data into table
		echo "$row_data" >> "$data_file"
		
		read -p "Want to enter a new row (yes/no)?: " choice
		choice=${choice,,}
		case $choice in
			yes|y)
				continue
				;;
			no|n)
				break
				;;
			*)
				;;
		esac
	done
fi
