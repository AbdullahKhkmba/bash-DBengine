export dbname

read -p "Enter database name: " dbname
export db_path=$dbs_path/$dbname

if [[ -d $db_path ]]
then 
	cd $db_path 2> /dev/null
	rtrn=$(echo $?)
	if [[ rtrn -eq 1 ]]         
	then 
		echo "Was not able to select database"
	else
		echo "Database was select successfully"
		
		PS3="DB menu> "
		select option in "Show current database" "Create table" "Drop table" "Insert into table" "exit"
		do	
			case $option in
				"Create table")
					source $base/features/create_table.sh
					create_table
					;;
					
				"Insert into table")
					$base/features/insert_into_table.sh
					;;	
				"Drop table")
					# TODO
					;;
									
				"Show current database")
					echo $dbname
					;;
				"exit")
					break
					;;
				*)
					echo "Not a valid option"
					;;
			esac
			REPLY=
		done
	fi
else 
	echo "No such database exist"
fi
