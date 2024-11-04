-- DROP DATABASE
DROP DATABASE IF EXISTS PORTFOLIO_PROJECTS;

-- CREATE DATABASE
CREATE DATABASE PORTFOLIO_PROJECTS;

-- CREATE SCHEMA
CREATE SCHEMA IF NOT EXISTS "In Mail Voting Analysis";

--SET SEARCH PATH FOR QUERIES
SET search_path = "In Mail Voting Analysis";

-- CREATE TABLE FOR ELECTION RESULTS
DROP TABLE IF EXISTS election_results;
CREATE TABLE IF NOT EXISTS election_results (
	Election_Id int,
	Precinct_Id bigint,	
	Candidate_Name varchar(100),
	Candidate_Votes	bigint,
	Ballot_Counts bigint,
	Election_Date date,
	LOCATION varchar(100)
);

-- COPY DATA INTO ELECTION_RESULTS TABLE
COPY election_results(Election_Id, Precinct_Id, Candidate_Name, Candidate_Votes, Ballot_Counts, Election_Date, location)
FROM 'C:/Users/USER/Desktop/PORTFOLIO PROJECT/AMDARI PROJECT/Data Analysis/SQL and Power bi/In-Mail Voting Analysis Leveraging Data to Address Election Post-Mortems and Enhance the Democratic Process/Datasets/election_results_data.csv'
DELIMITER ','
CSV HEADER;

-- CREATE TABLE FOR SECURITY LOGS
DROP TABLE IF EXISTS security_logs;
CREATE TABLE IF NOT EXISTS security_logs (
	Log_Id	int,
	Event_Type varchar(50),
	User_Id	bigint,
	Timestamp timestamp,
	LOCATION varchar (50)
);

-- COPY DATA INTO SECURITY LOGS TABLE
COPY security_logs(log_Id, Event_Type, User_Id, Timestamp, Location)
FROM 'C:/Users/USER/Desktop/PORTFOLIO PROJECT/AMDARI PROJECT/Data Analysis/SQL and Power bi/In-Mail Voting Analysis Leveraging Data to Address Election Post-Mortems and Enhance the Democratic Process/Datasets/security_logs_data.csv'
DELIMITER ','
CSV HEADER;

--CREATE TABLE USER INTERACTION
DROP TABLE IF EXISTS user_interaction;
CREATE TABLE IF NOT EXISTS user_interaction (
	Interaction_Id bigint,
	Voter_Id bigint,
	Election_Id	int,
	Page_Views int,
	Clicks int,
	Timestamp timestamp,
	User_Device varchar(50)
);

-- COPY DATA INTO USER INTERACTION TABLE
COPY user_interaction(Interaction_id, voter_id, election_id, page_views, clicks, timestamp, user_device)
FROM 'C:/Users/USER/Desktop/PORTFOLIO PROJECT/AMDARI PROJECT/Data Analysis/SQL and Power bi/In-Mail Voting Analysis Leveraging Data to Address Election Post-Mortems and Enhance the Democratic Process/Datasets/user_interaction_data.csv'
DELIMITER ','
CSV HEADER;

--CREATE TABLE VOTER REGISTRATION
DROP TABLE IF EXISTS voter_registration;
CREATE TABLE IF NOT EXISTS voter_registration (
	Voter_ID bigint,	
	Name varchar(100),
	Age	int,
	Gender varchar(50),
	Address	varchar(100),
	Voter_Registration_Date date,	
	Voting_History boolean
);

--SHOW datestyle;
--SET datestyle = 'ISO, DMY';
-- COPY DATA INTO VOTER REGISTRATION TABLE
COPY voter_registration(voter_id, name, age, gender, address, voter_registration_date, voting_history)
FROM 'C:/Users/USER/Desktop/PORTFOLIO PROJECT/AMDARI PROJECT/Data Analysis/SQL and Power bi/In-Mail Voting Analysis Leveraging Data to Address Election Post-Mortems and Enhance the Democratic Process/Datasets/voter_registration_data.csv'
DELIMITER ','
CSV HEADER;

--CREATE TABLE FEEDBACK COMPLAINTS
DROP TABLE IF EXISTS feedback_complaints;
CREATE TABLE IF NOT EXISTS feedback_complaints (
	Feedback_ID	bigint,
	Voter_ID bigint,
	Feedback_Text varchar,	
	Timestamp timestamp
);

-- COPY DATA INTO FEEDBACK COMPLAINTS TABLE
COPY feedback_complaints(feedback_id, voter_id, feedback_text, timestamp)
FROM 'C:/Users/USER/Desktop/PORTFOLIO PROJECT/AMDARI PROJECT/Data Analysis/SQL and Power bi/In-Mail Voting Analysis Leveraging Data to Address Election Post-Mortems and Enhance the Democratic Process/Datasets/feedback_complaints_data.csv'
DELIMITER ','
CSV HEADER;