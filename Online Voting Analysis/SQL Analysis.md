## Viewing the first five rows of each data to understand each dataset

### Voter Registration table:
|voter_id|name           |age|gender|address                                          |voter_registration_date|voting_history|
|--------|---------------|---|------|-------------------------------------------------|-----------------------|--------------|
|1       |Hannah Pacheco |58 |Other |859 Matthew Drive Apt. 108, Douglaston, MP 21584 |2023-01-02             |false         |
|2       |Ryan Wagner DDS|28 |Female|13797 Anthony Pine, North Catherine, VA 90787    |2020-07-07             |true          |
|3       |Sierra Robinson|57 |Male  |34240 Mary Mount, Jamiefort, FL 70399            |2022-01-01             |false         |
|4       |Charles Conner |53 |Female|41673 Wolfe Plains Apt. 505, East Linda, VI 36300|2021-04-30             |true          |
|5       |Michael Harris |40 |Female|65851 Wood Spring Apt. 468, Brockberg, AZ 64958  |2023-10-26             |false         |

### Security logs table:
|log_id|event_type     |user_id|timestamp              |location       |
|------|---------------|-------|-----------------------|---------------|
|3     |Security Breach|6      |2022-03-26 06:29:16.000|Carrollview    |
|4     |Security Breach|941    |2021-02-11 05:01:28.000|Kimberlyfort   |
|5     |Access         |676    |2020-02-29 23:25:46.000|Camposport     |
|8     |Login          |723    |2020-01-21 11:53:37.000|Lake Sylviaside|
|13    |Access         |789    |2021-01-24 05:02:57.000|Lancemouth     |

### Users interaction table:
|interaction_id|voter_id|election_id|page_views|clicks|timestamp              |user_device|
|--------------|--------|-----------|----------|------|-----------------------|-----------|
|3             |486     |1          |16        |2     |2020-08-20 03:07:58.000|Desktop    |
|4             |836     |1          |17        |9     |2020-08-07 14:59:50.000|Tablet     |
|5             |372     |1          |19        |6     |2021-02-14 10:12:06.000|Mobile     |
|8             |784     |1          |11        |8     |2021-05-10 20:41:42.000|Mobile     |
|13            |975     |1          |13        |3     |2020-07-19 19:06:33.000|Desktop    |

### Feedback complaints table:
|feedback_id|voter_id|feedback_text                                                                                                                                                                             |timestamp              |
|-----------|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------|
|3          |355     |Phone want something consider me. Democratic top politics bed.¶Pick positive fly. Join force teach individual.                                                                            |2023-03-06 12:21:59.000|
|4          |282     |Prove turn new herself natural environmental ball. Process wrong trip several personal owner how.¶Age record quickly.¶Possible hair agent stuff. From land southern true industry kitchen.|2020-01-20 06:26:53.000|
|5          |909     |Impact idea natural region protect professor. Anyone thousand floor age fact sister least.¶Good include old capital. Whatever least drug turn owner.                                      |2022-04-29 11:50:21.000|
|8          |443     |Allow owner cultural oil. Say student real activity large perform.¶Last site those man project above wonder. Beautiful serve large add improve process control.                           |2020-04-19 01:48:36.000|
|13         |83      |Style key feel civil main we still.¶Region eight form quality bill. Table want check. Plant son change look. Ago least situation political.¶Admit wish food. Fund nothing weight past.    |2021-05-12 01:46:22.000|


# SQL Data Cleaning & Inspection
Before performing advanced analysis, I conducted data cleaning and inspection in SQL. The process involved:
### 1. Dealing with Duplicates:
To remove duplicates from key tables like voter_registration, security_logs, feedback_complaints, and user_interaction, SQL queries were used with CTE (Common Table Expressions) and ROW_NUMBER() functions. This ensured that only unique records were retained, maintaining data integrity.
```sql
-- Remove duplicates in voter_registration data
WITH duplicates AS (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY voter_id ORDER BY voter_id) as rn
    FROM voter_registration 
)
DELETE FROM voter_registration 
WHERE ctid IN (SELECT ctid FROM duplicates WHERE rn > 1);
```

```sql
--dRemove duplicates in security_logs data
WITH duplicates AS (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY log_id ORDER BY log_id) as rn
    FROM security_logs sl 
)
DELETE FROM security_logs sl
WHERE ctid IN (SELECT ctid FROM duplicates WHERE rn > 1);
```

```sql
--Remove duplicates in eedback_complaints data
WITH duplicates AS (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY feedback_id ORDER BY feedback_id) as rn
    FROM feedback_complaints fc  
)
DELETE FROM feedback_complaints fc
WHERE ctid IN (SELECT ctid FROM duplicates WHERE rn > 1);
```

```sql
-- Remove duplicates in user_interaction data
WITH duplicates AS (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY interaction_id ORDER BY interaction_id) as rn
    FROM user_interaction ui 
)
DELETE FROM user_interaction ui
WHERE ctid IN (SELECT ctid FROM duplicates WHERE rn > 1);
```

### 2. Handling Missing Values:
Missing data is a significant issue in most datasets. SQL queries were run to identify fields with missing values across all tables. These checks enabled data completeness and ensured that the datasets were ready for analysis.

```sql
-- Check for missing values in voter_registration table
SELECT 
    count(*) - count(voter_id) AS missing_voter_id,
    count(*) - count(name) AS missing_name,
    count(*) - count(age) AS missing_age,
    count(*) - count(gender) AS missing_gender,
    count(*) - count(address) AS missing_address,
    count(*) - count(voter_registration_date) AS missing_voter_registration_date
FROM voter_registration;
```

```sql
-- Check for missing values in security_logs table
SELECT 
    count(*) - count(log_id) AS missing_log_id,
    count(*) - count(event_type) AS missing_event_type,
    count(*) - count(user_id) AS missing_user_id,
    count(*) - count(timestamp) AS missing_timestamp,
    count(*) - count(location) AS missing_location
FROM security_logs;
```

```sql
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
```
```sql
-- check for missing values in feedback_complaints table
SELECT 
	sum(CASE WHEN feedback_id IS NULL THEN 1 ELSE 0 END) AS missing_feedback_id,
	sum(CASE WHEN voter_id IS NULL THEN 1 ELSE 0 END) AS missing_voter_id,
	sum(CASE WHEN feedback_text IS NULL THEN 1 ELSE 0 END) AS missing_feedback_text,
	sum(CASE WHEN timestamp IS NULL THEN 1 ELSE 0 END) AS missing_timestamp
FROM feedback_complaints fc;
```

# Exploratory Data Analysis (EDA)
## 1. Voter Demographics and Participation Insights
### A. Voting History and Engagement:

Understanding how voters with experience and those without experience turnout for participating in the election.

```sql
-- Returning Voter turnout rate
SELECT 
    ROUND((SUM(CASE WHEN voting_history = TRUE THEN 1 ELSE 0 END)::Numeric / COUNT(*)) * 100, 2) AS voter_turnout_rate
FROM voter_registration;
```

### Result:
|voter_turnout_rate|
|------------------|
|50.5              |

### Insights:
50.5% of voters are returning voters, indicating a decent level of re-engagement but with room to increase long-term voter retention.

### Recommendations:
Enhance voter retention through reminders and personalized outreach. To improve first-time voter retention, offer onboarding support and incentives.

```sql
-- first_time_voter_rate
SELECT 
    ROUND((SUM(CASE WHEN voting_history = FALSE THEN 1 ELSE 0 END)::Numeric / COUNT(*)) * 100, 2) AS first_time_voter_rate
FROM voter_registration;
```

### Result:
|first_time_voter_rate|
|---------------------|
|49.5                 |

### Insights:
49.5% of voters are first-time participants, reflecting successful outreach but showing the challenge of ensuring future participation.

### Recommendations:
Focus on engaging first-time voters post-election with follow-ups and educational content to encourage them to vote again.

### B. Age Distribution Analysis

Voter participation analysis across different age groups reveals critical engagement gaps.
```sql
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
```

### Result:
|age_group   |total_voters|
|------------|------------|
|50-64       |245         |
|35-49       |244         |
|65 and above|232         |
|25-34       |173         |
|18-24       |106         |

### Insights:
The 18-24 age group has the lowest participation, while 50-64 has the highest, suggesting older voters are more engaged.

### Recommendations:
Optimize the platform for mobile to engage younger voters, and launch targeted social media campaigns to drive participation.

### C. Gender-Based Participation
The analysis shows the differs in participation between genders.
```sql
SELECT 
    gender,
    COUNT(*) AS total_voters
FROM voter_registration
GROUP BY gender
ORDER BY total_voters DESC;
```

### Results:
|gender|total_voters|
|------|------------|
|Female|373         |
|Male  |316         |
|Other |311         |

### Insights:
A slight participation gap exists between male and female voters, indicating gender-specific factors might influence engagement.
### Recommendations:
Use inclusive design and gender-sensitive campaigns to ensure broader voter participation.

### D. Voter Registration Trends Over Time
Analyzing the trend in voter registrations helps us understand the popularity of online voting over time
```sql
-- Monthly voter registration trend
SELECT 
    EXTRACT(YEAR FROM voter_registration_date) AS year,
    EXTRACT(MONTH FROM voter_registration_date) AS month,
    COUNT(*) AS registrations
FROM voter_registration
GROUP BY year, month
ORDER BY year, month;
```

### Reults:
|year|month|registrations|
|----|-----|-------------|
|2020|1|19|
|2020|2|21|
|2020|3|14|
|2020|4|8|
|2020|5|17|
|2020|6|21|
|2020|7|28|
|2020|8|21|
|2020|9|17|
|2020|10|7|
|2020|11|20|
|2020|12|23|
|2021|1|19|
|2021|2|15|
|2021|3|31|
|2021|4|13|
|2021|5|18|
|2021|6|27|
|2021|7|15|
|2021|8|28|
|2021|9|28|
|2021|10|12|
|2021|11|27|
|2021|12|22|
|2022|1|22|
|2022|2|10|
|2022|3|28|
|2022|4|11|
|2022|5|4|
|2022|6|43|
|2022|7|16|
|2022|8|9|
|2022|9|15|
|2022|10|15|
|2022|11|12|
|2022|12|22|
|2023|1|42|
|2023|2|10|
|2023|3|22|
|2023|4|37|
|2023|5|21|
|2023|6|25|
|2023|7|36|
|2023|8|36|
|2023|9|25|
|2023|10|21|
|2023|11|24|
|2023|12|23|

## 2. Security Issue Insights
### A. Security Incident Frequency By month
Tracking the frequency of security incidents over time provides insights into potential vulnerabilities.
```sql
SELECT 
    EXTRACT(YEAR FROM timestamp) AS year,
    EXTRACT(MONTH FROM timestamp) AS month,
    to_char(timestamp, 'Month') AS Month_name,
    COUNT(*) AS incidents_count 
FROM security_logs
GROUP BY year, MONTH, month_name
ORDER BY year, MONTH, incidents_count;
```

### Results:
|year|month|month_name|incidents_count|
|----|-----|----------|---------------|
|2020|1|January  |19|
|2020|2|February |24|
|2020|3|March    |23|
|2020|4|April    |19|
|2020|5|May      |19|
|2020|6|June     |21|
|2020|7|July     |23|
|2020|8|August   |18|
|2020|9|September|28|
|2020|10|October  |20|
|2020|11|November |21|
|2020|12|December |28|
|2021|1|January  |21|
|2021|2|February |16|
|2021|3|March    |18|
|2021|4|April    |30|
|2021|5|May      |21|
|2021|6|June     |22|
|2021|7|July     |26|
|2021|8|August   |20|
|2021|9|September|25|
|2021|10|October  |15|
|2021|11|November |21|
|2021|12|December |24|
|2022|1|January  |22|
|2022|2|February |27|
|2022|3|March    |24|
|2022|4|April    |17|
|2022|5|May      |26|
|2022|6|June     |31|
|2022|7|July     |26|
|2022|8|August   |27|
|2022|9|September|27|
|2022|10|October  |28|
|2022|11|November |26|
|2022|12|December |24|
|2023|1|January  |19|
|2023|2|February |23|
|2023|3|March    |16|
|2023|4|April    |24|
|2023|5|May      |19|
|2023|6|June     |28|
|2023|7|July     |25|
|2023|8|August   |9|
|2023|9|September|10|

### B. Security Incident Frequency By Day of the week
```sql 
-- Number of security breaches by day of the week
SELECT 
    to_char(timestamp, 'Day') AS day_of_week,
    COUNT(*) AS incidents_count 
FROM security_logs
GROUP BY day_of_week
ORDER BY incidents_count DESC;
```

### Results:
|day_of_week|incidents_count|
|-----------|---------------|
|Saturday   |159            |
|Tuesday    |154            |
|Wednesday  |150            |
|Sunday     |140            |
|Thursday   |136            |
|Monday     |132            |
|Friday     |129            |

### Insights:
Security incidents are most common on weekends, especially Saturdays, suggesting gaps in weekend security coverage.
### Recommendations:
Increase weekend security monitoring and implement automated security systems for continuous protection.


### C. Most Common Event Types:
Identifying common security events provides an overview of the types of issues the system is encountering, 
 helping prioritize fixes.
 ```sql
-- Count of event types in security logs
SELECT 
    event_type,
    COUNT(*) AS event_count
FROM security_logs
GROUP BY event_type
ORDER BY event_count DESC;
```

### Results:
|event_type     |event_count|
|---------------|-----------|
|Security Breach|340        |
|Access         |330        |
|Login          |330        |

### Insights:
Security breach and Unauthorized access attempts are the most frequent security issues.
### Recommendations:
Invest in stronger cybersecurity measures, focusing on phishing protection and user authentication, while educating users on best practices.

## 3. User Experience Insights
### A. Device Usage Patterns
Understanding which devices voters use helps optimize the voting system.
```sql
-- Voter engagement by device type
SELECT 
    user_device AS device, 
    COUNT(*) AS total_interactions 
FROM user_interaction
GROUP BY device
ORDER BY total_interactions desc;
```
### Results:
|device |total_interactions|
|-------|------------------|
|Mobile |363               |
|Desktop|326               |
|Tablet |311               |

### Insights:
Most users access the platform via mobile devices, indicating the need for mobile optimization.
### Recommendations:
Prioritize mobile-first design with a focus on responsiveness and ease of navigation for mobile users.

### B. Drop-off Rate Analysis
Analyzing where users drop off during the voting process reveals issues in the user journey.
```sql
SELECT
       SUM(CASE WHEN Page_Views >= 1 AND page_views <= 5 THEN 1 ELSE 0 END) AS Landing_Page,
       SUM(CASE WHEN Page_Views > 5 AND page_views <= 10 THEN 1 ELSE 0 END) AS View_Election_Info,
       SUM(CASE WHEN Page_Views > 10 AND page_views <= 15 THEN 1 ELSE 0 END) AS Start_Voting_process,
       SUM(CASE WHEN Page_Views > 15 THEN 1 ELSE 0 END) AS Complete_Vote
FROM User_Interaction;
```

### Results:
|landing_page|view_election_info|start_voting_process|complete_vote|
|------------|------------------|--------------------|-------------|
|250         |264               |278                 |208          |


### Insights:
Many users drop off after after starting the voting process, indicating unclear onboarding steps.
### Recommendations:
Simplify the voting initiation process with clearer instructions and guidance to reduce drop-off rates.