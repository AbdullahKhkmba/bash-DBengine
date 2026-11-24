#! /usr/bin/bash
shopt -s extglob

export dbs_path="/home/abdullahayman/bash-DBengine/databases"
export base="/home/abdullahayman/bash-DBengine"

select option in "CreateDB" "SelectDB" "DropDB" "ShowDBs" "exit"
do	
	case $option in
		"CreateDB")
			$base/features/create_database.sh
			;;
			
		"DropDB")
			$base/features/drop_database.sh
			;;
			
		"SelectDB")
			$base/features/select_database.sh
			;;
		"ShowDBs")
			ls -1 $dbs_path
			;;
		"exit")
			break
			;;
		*)
			echo "Not a valid option"
			;;
	esac
done
