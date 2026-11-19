# bash-DBengine
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
# Features
## Database Level features
### Create database
- [ ] create new folder with database name
- [ ] check that a database with the same name doesn’t exist.
- [ ] check that database name is valid (doesn’t contain / or . at the beginning for example)
- [ ] advanced - check that user has permission to create a database
### Select database
- [ ] change directory to database folder
- [ ] check that a database with the same name exist
- [ ] advanced - check that user has permission to select a database
### Delete database
- [ ] delete database folder
- [ ] check that a database with the same name exist
- [ ] advanced - check that user has permission to delete database
### Exit database engine
- [ ] exit from script when “exit” is written
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
