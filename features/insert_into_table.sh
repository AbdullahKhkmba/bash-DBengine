#! /usr/bin/bash

read -p "Enter table to insert to: " table_name

# just for testing
table_path="$HOME/bash-DBengine/databases/ITI/$table_name"
db_path="$HOME/bash-DBengine/databases/ITI"

if [[ -f $table_path ]]
then 
	# find out column names
	metadata_path=$db_path/metadata
	no_cols=$(grep $table_name $metadata_path | wc -l)
	grep $table_name $metadata_path > tmp

	row_data=""
	for (( i=1; i<=no_cols; i++ ))
	do

		col_type=$(sed -n "${i}p" tmp | cut -d: -f3)
		while true
		do 
			col_name=$(sed -n "${i}p" tmp | cut -d: -f1)
			read -p "Enter ${col_name} column: " value
			if [[ ( $col_type = "int" && $value = [0-9]*([0-9]) ) || $col_type = "char" ]]
			then
				[[ $i = 1 ]] && row_data+="${value}" || row_data+=",${value}"
				break
			fi
		done	
	done
	echo $row_data >> $table_path

else 
	echo "No such table exist"
fi
