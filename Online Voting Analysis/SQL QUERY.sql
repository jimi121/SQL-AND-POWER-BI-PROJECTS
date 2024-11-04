--SET SEARCH PATH FOR QUERIES
SET search_path = "In Mail Voting Analysis";

-- view data
SELECT * FROM voter_registration;
SELECT * FROM security_logs;
SELECT * FROM user_interaction;
SELECT * FROM feedback_complaints;


--dealing with duplicates in voter_registrations table
WITH duplicates AS (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY voter_id ORDER BY voter_id) as rn
    FROM voter_registration vr 
)
DELETE FROM voter_registration vr
WHERE ctid IN (SELECT ctid FROM duplicates WHERE rn > 1);

--dealing with duplicates in security_logs table
WITH duplicates AS (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY log_id ORDER BY log_id) as rn
    FROM security_logs sl 
)
DELETE FROM security_logs sl
WHERE ctid IN (SELECT ctid FROM duplicates WHERE rn > 1);

--dealing with duplicates in feedback_complaints table
WITH duplicates AS (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY feedback_id ORDER BY feedback_id) as rn
    FROM feedback_complaints fc  
)
DELETE FROM feedback_complaints fc
WHERE ctid IN (SELECT ctid FROM duplicates WHERE rn > 1);

--dealing with duplicates in user_interaction table
WITH duplicates AS (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY interaction_id ORDER BY interaction_id) as rn
    FROM user_interaction ui 
)
DELETE FROM user_interaction ui
WHERE ctid IN (SELECT ctid FROM duplicates WHERE rn > 1);


-- check for missing values in voter_registration table
SELECT 
	count(*) - count(voter_id) AS missing_voter_id,
	count(*) - count(name) AS missing_name,
	count(*) - count(age) AS missing_age,
	count(*) - count(gender) AS missing_gender,
	count(*) - count(address) AS missing_address,
	count(*) - count(voter_registration_date) AS missing_voter_registration_date
FROM voter_registration vr;

-- check for missing values in security_logs table
SELECT 
	count(*) - count(log_id) AS missing_log_id,
	count(*) - count(event_type) AS missing_event_type,
	count(*) - count(user_id) AS missing_user_id,
	count(*) - count(timestamp) AS missing_timestamp,
	count(*) - count(location) AS missing_location
FROM security_logs sl;

-- check for missing values in user_interaction table
SELECT 
	count(*) - count(interaction_id) AS missing_interaction_id,
	count(*) - count(voter_id) AS missing_voter_id,
	count(*) - count(election_id) AS missing_election_id,
	count(*) - count(page_views) AS missing_page_views,
	count(*) - count(clicks) AS missing_clicks,
	count(*) - count(timestamp) AS missing_clicks,
	count(*) - count(user_device) AS missing_user_device
FROM user_interaction ui;

-- check for missing values in feedback_complaints table
SELECT 
	sum(CASE WHEN feedback_id IS NULL THEN 1 ELSE 0 END) AS missing_feedback_id,
	sum(CASE WHEN voter_id IS NULL THEN 1 ELSE 0 END) AS missing_voter_id,
	sum(CASE WHEN feedback_text IS NULL THEN 1 ELSE 0 END) AS missing_feedback_text,
	sum(CASE WHEN timestamp IS NULL THEN 1 ELSE 0 END) AS missing_timestamp
FROM feedback_complaints fc;


-- Exploratory Data Analysis (EDA)
-- 1. Voter Demographics and Participation Insights
-- A. Voting History and Engagement:
-- Voter turnout rate
SELECT 
    ROUND((SUM(CASE WHEN voting_history = TRUE THEN 1 ELSE 0 END)::Numeric / COUNT(*)) * 100, 2) AS voter_turnout_rate
FROM voter_registration;

-- first_time_voter_rate
SELECT 
    ROUND((SUM(CASE WHEN voting_history = FALSE THEN 1 ELSE 0 END)::Numeric / COUNT(*)) * 100, 2) AS first_time_voter_rate
FROM voter_registration;


-- B. Age Distribution Analysis
/* Voter participation analysis across different age groups reveals critical engagement gaps.*/
SELECT 
    CASE WHEN age < 18 THEN 'Under 18'
				 WHEN age >=18 AND age < 25 THEN '18-24'
				 WHEN age >=25 AND age < 35 THEN '25-34'
				 WHEN age >=35 AND age < 50 THEN '35-49'
				 WHEN age >=50 AND age < 65 THEN '50-64'
				 WHEN age >= 65 THEN '65 and above'
			ELSE 'unknown' END AS Age_Group,
    COUNT(*) AS total_voters
FROM voter_registration
GROUP BY age_group
ORDER BY total_voters DESC;

/* Insight: The 18-24 age group had the lowest participation rate, indicating that younger voters may find the voting platform 
 challenging or unengaging. Recommendations include creating a mobile-first interface and targeted educational campaigns to drive 
 engagement.*/


-- C. Gender-Based Participation
-- The analysis shows the differs in participation between genders.
SELECT 
    gender,
    COUNT(*) AS total_voters
FROM voter_registration
GROUP BY gender
ORDER BY total_voters DESC;
/* Insight: There is a slight participation gap between male and female voters. A focus on inclusive design and 
 gender-specific messaging could help bridge the gap.*/

-- D. Registration Trends Over Time
-- Monthly voter registration trend
/*Analyzing the trend in voter registrations helps us understand the popularity of online voting over time */
SELECT 
    EXTRACT(YEAR FROM voter_registration_date) AS year,
    EXTRACT(MONTH FROM voter_registration_date) AS month,
    COUNT(*) AS registrations
FROM voter_registration
GROUP BY year, month
ORDER BY year, month;

-- 2. Security Insights
-- A. Security Incident Frequency By month
-- Tracking the frequency of security incidents over time provides insights into potential vulnerabilities.
SELECT 
    EXTRACT(YEAR FROM timestamp) AS year,
    EXTRACT(MONTH FROM timestamp) AS month,
    to_char(timestamp, 'Month') AS Month_name,
    COUNT(*) AS incidents_count 
FROM security_logs
GROUP BY year, MONTH, month_name
ORDER BY year, MONTH, incidents_count;

-- B. Security Incident Frequency By Day of the week
-- Number of security breaches by day of the week
SELECT 
    to_char(timestamp, 'Day') AS day_of_week,
    COUNT(*) AS incidents_count 
FROM security_logs
GROUP BY day_of_week
ORDER BY incidents_count DESC;
/* Security issues peak on weekend, particularly Saturday. Investigating these patterns may reveal 
vulnerabilities that can be mitigated.*/

-- C. Most Common Event Types:
-- Count of event types in security logs
/* Identifying common security events provides an overview of the types of issues the system is encountering, 
 helping prioritize fixes.*/
-- Count of event types in security logs
SELECT 
    event_type,
    COUNT(*) AS event_count
FROM security_logs
GROUP BY event_type
ORDER BY event_count DESC;

/* Insight: Security breaches are the most frequent issue, prioritizing investments in cybersecurity and user 
 education is crucial to building trust. */

-- 3. User Experience Insights
-- A. Device Usage Patterns
-- Understanding which devices voters use helps optimize the voting system.
-- Voter engagement by device type
SELECT 
    user_device AS device, 
    COUNT(*) AS total_interactions 
FROM user_interaction
GROUP BY device
ORDER BY total_interactions desc;
/* Insight: The majority of voters access the system via mobile devices, signaling a need for a mobile-first design.*/

-- B. Drop-off Rate Analysis
-- Analyzing where users drop off during the voting process reveals issues in the user journey.
SELECT
       SUM(CASE WHEN Page_Views >= 1 AND page_views <= 5 THEN 1 ELSE 0 END) AS Landing_Page,
       SUM(CASE WHEN Page_Views > 5 AND page_views <= 10 THEN 1 ELSE 0 END) AS View_Election_Info,
       SUM(CASE WHEN Page_Views > 10 AND page_views <= 15 THEN 1 ELSE 0 END) AS Start_Voting_process,
       SUM(CASE WHEN Page_Views > 15 THEN 1 ELSE 0 END) AS Complete_Vote
FROM User_Interaction;

/* Insight: A significant number of users dropped off at the "Start Voting Process" stage, suggesting that simplified
 onboarding and clearer instructions could reduce drop-offs. */

-- 4. Feedback Analysis
/* Finally, analyzing user feedback allows us to directly address voter concerns and improve the overall user experience. */
-- A. Common Feedback Themes:
--Categorizing user feedback helps identify the most common complaints or suggestions.
-- Extracting keywords from feedback text
SELECT 
    keyword, 
    COUNT(*) AS keyword_count
FROM (
    SELECT unnest(string_to_array(feedback_text, ' ')) AS keyword
    FROM feedback_complaints
) AS keywords
GROUP BY keyword
ORDER BY keyword_count DESC
LIMIT 10;