
#!/bin/bash

create_table() {

    # ==========================================
    # 1. Validate selected database
    # ==========================================

    if [[ -z "$db_path" || ! -d "$db_path" ]]; then
        echo "Error: No database is selected or database does not exist."
        return 1
    fi

    echo "Selected database: $dbname"

    # ==========================================
    # 2. Get and validate table name
    # ==========================================

    local table_name

    while true; do

        read -r -p "Enter table name: " table_name

        if [[ -z "$table_name" ]]; then
            echo "Error: Table name cannot be empty."

        elif [[ ! "$table_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
            echo "Error: Invalid table name."

        elif [[ -e "$db_path/$table_name" ]]; then
            echo "Error: Table already exists. Enter another name."

        else
            break
        fi

    done

    # ==========================================
    # 3. Initialize column arrays
    # ==========================================

    local -a col_names=()
    local -a col_types=()
    local -a col_constraints=()
    local -a col_nullability=()

    local col_name
    local data_type
    local nullability
    local choice
    local exit_choice
    local exit_table=false
    local duplicate
    local i

    # ==========================================
    # 4. Collect columns
    # ==========================================

    while true; do

        exit_table=false

        # Get column name
        while true; do

            read -r -p "Enter column name: " col_name

            # Handle the special name "exit"
            if [[ "$col_name" == "0" ]]; then

                while true; do

                    read -r -p "Are you sure you want to exit? (yes/no): " exit_choice
		
		    exit_choice=${exit_choice,,}
                    case "$exit_choice" in
                        yes|y)
                            if [[ ${#col_names[@]} -eq 0 ]]; then
                                echo "Error: A table must have at least one column."
                                break
                            fi

                            exit_table=true
                            break
                            ;;

                        no|n)
                            break
                            ;;

                        *)
                            echo "Invalid choice. Enter 0 or 1."
                            ;;
                    esac

                done

                if [[ "$exit_table" == true ]]; then
                    break
                fi

                # If the user chose 1, continue validation
            fi

            # Validate column name
            if [[ -z "$col_name" ]]; then
                echo "Error: Column name cannot be empty."
                continue
            fi

            if [[ ! "$col_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
                echo "Error: Invalid column name."
                continue
            fi

            # Check duplicate columns
            duplicate=false

            for existing_col in "${col_names[@]}"; do
                if [[ "$existing_col" == "$col_name" ]]; then
                    duplicate=true
                    break
                fi
            done

            if [[ "$duplicate" == true ]]; then
                echo "Error: Column already exists."
                continue
            fi

            break

        done

        # Exit column collection
        if [[ "$exit_table" == true ]]; then
            break
        fi

        # ======================================
        # 5. Get column datatype
        # ======================================

        while true; do

            read -r -p "Enter datatype for '$col_name' (INT, CHAR): " data_type
            
            
	    # convert data_type to uppercase
	    data_type=${data_type^^}
            if [[ $data_type != "CHAR" && $data_type != "INT" ]]; then
                echo "Error: Invalid datatype."
            else
                break
            fi

        done

        # ======================================
        # 6. Get column nullability
        # ======================================

        while true; do

            read -r -p "Allow NULL? (yes/no): " nullability

            case "${nullability,,}" in
                yes|y)
                    nullability="NULL"
                    break
                    ;;

                no|n)
                    nullability="NOT_NULL"
                    break
                    ;;

                *)
                    echo "Please enter yes or no."
                    ;;
            esac

        done

        # ======================================
        # 7. Store column information
        # ======================================

        col_names+=("$col_name")
        col_types+=("$data_type")
        col_constraints+=("")
        col_nullability+=("$nullability")

        echo "Column '$col_name' added successfully."

        # ======================================
        # 8. Ask whether to add another column
        # ======================================

        #while true; do

        #    echo
        #    echo "Press 1 to add another column."
        #    echo "Press 0 to exit the table."

        #   read -r -p "Your choice: " choice

        #   if [[ "$choice" == "1" || "$choice" == "0" ]]; then
        #       break
        #   else
        #       echo "Invalid choice. Enter 1 or 0."
        #   fi

        #done

        #if [[ "$choice" == "0" ]]; then
        #   break
        #fi

    done  # Closes the outer column-collection loop

    # ==========================================
    # 9. Primary Key configuration
    # ==========================================

    local pk_choice
    local pk_column
    local pk_found

    while true; do

        read -r -p "Do you want to add a Primary Key? (yes/no): " pk_choice

        case "${pk_choice,,}" in

            yes|y)

                while true; do

                    read -r -p "Enter Primary Key column name: " pk_column

                    pk_found=false

                    for i in "${!col_names[@]}"; do

                        if [[ "${col_names[$i]}" == "$pk_column" ]]; then

                            pk_found=true

                            col_constraints[$i]="PRIMARY_KEY"
                            col_nullability[$i]="NOT_NULL"

                            break
                        fi

                    done

                    if [[ "$pk_found" == true ]]; then
                        echo "Primary Key assigned successfully."
                        break
                    else
                        echo "Error: Column '$pk_column' does not exist."
                    fi

                done

                break
                ;;

            no|n)
                echo "Table will be created without a Primary Key."
                break
                ;;

            *)
                echo "Please enter yes or no."
                ;;

        esac

    done

    # ==========================================
    # 10. Write table information to file
    # ==========================================

    local metadata_file="$db_path/${table_name}_metadata"
    local temp_file
    
    # create table's data file
    touch "$db_path/${table_name}"

    # Prevent overwriting an existing table
    if [[ -e "$metadata_file" ]]; then
        echo "Error: Table already exists."
        return 1
    fi

    temp_file=$(mktemp "$db_path/.table_tmp.XXXXXX") || {
        echo "Error: Could not create temporary table file."
        return 1
    }

    for i in "${!col_names[@]}"; do

        printf '%s:%s:%s:%s::\n' \
            "${col_names[$i]}" \
            "${col_constraints[$i]}" \
            "${col_types[$i]}" \
            "${col_nullability[$i]}" >> "$temp_file"

    done

    if ! mv -- "$temp_file" "$metadata_file" 2> /dev/zero; then
        rm -f -- "$temp_file"
        echo "Error: Could not save table."
        return 1
    fi

    # ==========================================
    # 11. Success message
    # ==========================================

    echo
    echo "===================================="
    echo "Table created successfully!"
    echo "Database : $dbname"
    echo "Table    : $table_name"
    echo "Columns  : ${#col_names[@]}"
    echo "===================================="

    return 0

}

