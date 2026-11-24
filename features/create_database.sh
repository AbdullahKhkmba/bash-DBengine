read -p "Enter database name: " dbname

path=$dbs_path/$dbname

if [[ -d $path ]]             # check that database exist
then 
	echo "Database already exist"
else
	# Names must start with letters or underscore
	# Only underscore and hyphine are allowed in the middle
	if [[ $dbname = [a-zA-Z_]*([a-zA-Z0-9_-]) ]]
	then 
		mkdir $path 2> /dev/null     # don't show error to DB user
		rtrn=$(echo $?)
		if [[ rtrn -eq 1 ]]          # check for errors
		then 
			echo "Was not able to create database"
		else
			echo "Database was created successfully"
		fi
		
	else
		echo "Invalid name"
	fi
fi
