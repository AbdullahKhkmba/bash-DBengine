export dbname

read -p "Enter database name: " dbname
db_path=$dbs_path/$dbname

if [[ -d $db_path ]]             # check that database exist
then 
	echo "Database already exist"
else
	# Names must start with letters or underscore
	# Only underscore and hyphine are allowed in the middle
	if [[ $dbname = [a-zA-Z_]*([a-zA-Z0-9_-]) ]]
	then 
		mkdir $db_path 2> /dev/null     # don't show error to DB user
		rtrn=$(echo $?)
		if [[ rtrn -eq 1 ]]          # check for errors
		then 
			echo "Was not able to create database"
		else
			echo "Database was created successfully"
			touch "$db_path/${dbname}_metadata"
		fi
		
	else
		echo "Invalid name"
	fi
fi
