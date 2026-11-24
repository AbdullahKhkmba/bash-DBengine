# Overview
The project aims to develop a DBMS using bash script that provide the basic operations such as:
1. CRUD operations on databases
2. CRUD operations on tables
3. Define roles for users

The project should provide a GUI using Zenity for interfacing with the engine
# Development Process Steps
1. Add desired feature to be developed and basic test cases in the `README.md` document
2. Create a new branch with feature name
3. Develop feature on the branch
4. Run test cases, and cross the ones that pass from the `README.md` document
5. Open a pull request
6. Review
7. Merge branch
# Project Structure
```
bash_DBengine/
│
├── main.sh
│
├── README.md
│
├── databases/
│
├── features/
│ ├── create_database.sh
│ ├── drop_database.sh
│ ├── select_database.sh
│ └── show_databases.sh
```
# Features
## Database Level features
### Create database
- [x] create new folder with database name
- [x] check that a database with the same name doesn’t exist.
- [x] check that database name start with a letter or `_`
- [x] check that no special character in the middle exist except `-` and `_`
- [x] check that folder was created without errors (this will catch other special characters that are not allowed in folder naming)
- [ ] advanced - check that user has permission to create a database

Now a user can create a database. The engine checks that no database already exist with the same name, in addition to enforcing that name start with a letter or underscore and doesn’t contain any special characters except `_` and `-`
### Delete database
- [x] delete database folder
- [x] check that a database with the same name exist
- [x] check that database name doesn’t contain `/` because this way a user can enter for example `database/table` and be able to delete a table from the database
- [ ] advanced - check that user has permission to delete database
### Select database
- [x] change directory to database folder
- [x] check that a database with the same name exist
- [ ] advanced - check that user has permission to select a database
### Exit database engine
- [x] exit from script when “exit” is written
## Tables Level features
### Create table
- [ ] create file name with specified table name
- [ ] decide table file and meta data naming criteria
- [ ] **check** that file name is valid
- [ ] **check** that a file with the same name doesn’t already exist

- [ ] prompt user for number of columns
- [ ] **check** that number of columns is a non-negative and non-zero integer

- [ ] prompt user for name for each column
- [ ] **check** that column name is valid 
- [ ] **check** that column name is not repeated across the same table
- [ ] decide how columns are going to be stored 

- [ ] prompt user for data type of each column
- [ ] **check** that entered data types are valid
- [ ] decide how columns data types are going to be stored

- [ ] prompt user for PK column (should we prompt the user after each prompt whether he want it as the PK or should we ask him at the end which column he want to be the PK ?)
- [ ] decide how PK is going to be stored
### Insert into Table
### Delete Table
### Update Table
# Future Features
- SQL Queries
- ACID transaction using a log file
- Foreign Keys and Joins
