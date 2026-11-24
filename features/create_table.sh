read -p "Enter table name: " table_name

table_path=$db_path/$table_name

if [[ -f $table_path ]]       # check whether a table exist
then 
	echo "Table already exist"
else
	# Names must start with letters or underscore
	# Only underscore and hyphine are allowed in the middle
	if [[ $table_name = [a-zA-Z_]*([a-zA-Z0-9_-]) ]]
	then 
		touch $table_name 2> /dev/null     # don't show error to DB user
		rtrn=$(echo $?)
		if [[ rtrn -eq 1 ]]          # check for errors
		then 
			echo "Was not able to create table"
		else
			echo "table was created successfully"
		fi
		
	else
		echo "Invalid name"
	fi
	
	
fi
