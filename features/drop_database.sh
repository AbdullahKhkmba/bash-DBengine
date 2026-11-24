read -p "Enter database name: " dbname
db_path=$dbs_path/$dbname
if [[ -d $db_path && $dbname != */* ]]    # check that DBname is not reaching inside any database
then 
		rm -r $db_path 2> /dev/null
rtrn=$(echo $?)
		if [[ rtrn -eq 1 ]]         
		then 
			echo "Was not able to delete database"
		else
			echo "Database was deleted successfully"
		fi
else 
	echo "No such database exist"
fi
