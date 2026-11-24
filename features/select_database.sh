read -p "Enter database name: " dbname
db_path=$dbs_path/$dbname
if [[ -d $db_path ]]
then 
	cd $db_path 2> /dev/null
	rtrn=$(echo $?)
	if [[ rtrn -eq 1 ]]         
	then 
		echo "Was not able to select database"
	else
		echo "Database was select successfully"
		pwd
	fi
else 
	echo "No such database exist"
fi
