#! /usr/bin/bash
shopt -s extglob

export dbs_path="$HOME/bash-DBengine/databases"
export base="$HOME/bash-DBengine"

PS3="Main menu> "
select option in "Create database" "Select database" "Drop database" "Show databases" "exit"
do	
	case $option in
		
		"Create database")
			$base/features/create_database.sh
			;;
			
		"Drop database")
			$base/features/drop_database.sh
			;;
			
		"Select database")
			$base/features/select_database.sh
			REPLY=
			;;
		"Show databases")
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
