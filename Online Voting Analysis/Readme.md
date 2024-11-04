# 🗳️ Data Analytics for Improving Online Voting Systems: Increasing Voter Engagement and Boosting Security
![](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Online%20Voting%20Analysis/Vote.jpg)
## 📝 Executive Summary

This project leverages **SQL** for data cleaning and exploratory analysis and **Power BI** for interactive dashboards. We focus on addressing three critical challenges in online voting systems: **low voter turnout**, **security vulnerabilities**, and **user experience issues**. By analyzing voter participation trends, identifying security risks, and examining user feedback, this project provides actionable recommendations to enhance system performance. Through a data-driven approach, we aim to make online voting more secure, accessible, and user-friendly, ultimately increasing democratic engagement.

---

## 🌐 Business Overview

The online voting system has immense potential for modernizing elections, offering greater accessibility and convenience. However, challenges such as **low voter turnout**, **security vulnerabilities**, and **poor user experience** impact the system's effectiveness and public trust. Stakeholders—including government agencies, election committees, and voters—depend on these platforms to uphold a fair, secure election process.

### 📌 Key Objectives:
1. **Boost voter participation** by analyzing demographic trends and engagement metrics.
2. **Enhance system security** by identifying patterns in breaches and login issues.
3. **Improve user experience** by addressing user feedback and identifying usability improvements.

Meeting these objectives will provide a roadmap to make online voting more viable, fostering democratic engagement and public trust.

---

## 🚧 Key Challenges

1. **Low Voter Turnout**: Specific demographics, particularly younger voters, exhibit low participation.
2. **Security Concerns**: Frequent access issues and breaches raise concerns about reliability.
3. **User Experience Issues**: High drop-off rates due to poor navigation or unclear instructions affect the experience.

A data-driven approach to these challenges will help enhance system design, improve security protocols, and boost user engagement.

---

## 🎯 Project Objectives

1. **Improve voter turnout** by analyzing demographics and engagement behaviors.
2. **Strengthen security** by examining patterns in breaches and login issues.
3. **Enhance user experience** by tracking drop-off points and analyzing feedback insights.

Setting measurable targets, such as increasing voter turnout by 20% and reducing security incidents by 30%, will track the success of this project over time.

---

## 📊 Data Description

Our analysis relies on four primary datasets:

1. **Voter Registration Data**:
   - `Voter ID`: Unique identifier for each voter.
   - `Age`, `Gender`, `Voting History`: Age, gender, and history of voting.
   - `Registration Date`: Date of registration.

2. **Feedback and Complaints Data**:
   - `Feedback ID`: Unique identifier for feedback entries.
   - `Voter ID`, `Feedback Text`, `Timestamp`: Voter reference, feedback content, and timestamp.

3. **Security Incident Data**:
   - `Log ID`, `Event Type`, `User ID`, `Location`, `Timestamp`: Security event details.

4. **User Interaction Data**:
   - `Interaction ID`, `Voter ID`, `Page Views`, `Clicks`, `Device Used`, `Timestamp`: Data on user interactions.

---

##  🛠 Technology Stack

- **SQL (PostgreSQL):** Used for data cleaning, transformation, and exploratory analysis.

- **Power BI:** Created interactive dashboards and data visualizations to facilitate actionable insights.

- **DAX:** Developed KPIs and calculated fields for custom metrics, further refining insights.

## 🧹 SQL Data Cleaning & Inspection

### 1. Removing Duplicates
Duplicates were removed from each dataset to maintain data integrity. Below are sample SQL queries used:

```sql
-- Remove duplicates in voter_registration data
WITH duplicates AS (
    SELECT ctid, ROW_NUMBER() OVER (PARTITION BY voter_id ORDER BY voter_id) as rn
    FROM voter_registration 
)
DELETE FROM voter_registration 
WHERE ctid IN (SELECT ctid FROM duplicates WHERE rn > 1);
```
---

### 2. Handling Missing Values
Next, missing values were identified across tables to avoid incomplete analysis. For example:

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
---

## 🔍 SQL-Based Exploratory Data Analysis (EDA)
Once cleaned, exploratory data analysis (EDA) in SQL uncovered insights related to voter demographics, security issues, and user engagement patterns.

### 1. Voter Demographics and Participation Insights
**A. Voting History and Engagement:** Analyzed voter turnout among first-time and returning voters.

```sql
-- Returning Voter turnout rate
SELECT 
    ROUND((SUM(CASE WHEN voting_history = TRUE THEN 1 ELSE 0 END)::Numeric / COUNT(*)) * 100, 2) AS voter_turnout_rate
FROM voter_registration;

```

**B. Age Distribution Analysis:** Revealed voter participation across age groups.

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
---
### 2. Security Incident Insights
**A. Security Incident Frequency by Month:** Analyzed monthly incident counts to identify trends.

```sql
SELECT 
    EXTRACT(YEAR FROM timestamp) AS year,
    EXTRACT(MONTH FROM timestamp) AS month,
    COUNT(*) AS incidents_count 
FROM security_logs
GROUP BY year, month
ORDER BY year, month;
```
**B. Most Common Event Types:** Identified common security issues to prioritize fixes.

```sql
-- Count of event types in security logs
SELECT 
   event_type,
   COUNT(*) AS event_count
FROM security_logs
GROUP BY event_type
ORDER BY event_count DESC;
```
---

### 3. User Experience Insights
**A. Device Usage Patterns:** Insights into which devices users preferred.

```sql
-- Voter engagement by device type
SELECT 
    user_device AS device, 
    COUNT(*) AS total_interactions 
FROM user_interaction
GROUP BY device
ORDER BY total_interactions DESC;
```

**B. Drop-off Rate Analysis:** Tracked where users exited during the voting process.

```sql
SELECT
       SUM(CASE WHEN Page_Views >= 1 AND page_views <= 5 THEN 1 ELSE 0 END) AS Landing_Page,
       SUM(CASE WHEN Page_Views > 5 AND page_views <= 10 THEN 1 ELSE 0 END) AS View_Election_Info,
       SUM(CASE WHEN Page_Views > 10 AND page_views <= 15 THEN 1 ELSE 0 END) AS Start_Voting_Process,
       SUM(CASE WHEN Page_Views > 15 THEN 1 ELSE 0 END) AS Complete_Vote
FROM User_Interaction;
```
[View the Full SQL Scripts Here 📝](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Online%20Voting%20Analysis/SQL%20Analysis.md)

---

## 📊 Power BI Dashboards and Insights

[Dashboard Walkthrough GIF](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Online%20Voting%20Analysis/Video%20presentation.gif)

Using **Power BI**, we transformed **SQL** insights into interactive dashboards focused on three primary areas:

### 1. Voter Participation Dashboard

- **Goal:** Visualize trends in voter demographics and engagement.

- **Key Visualizations:** Age and gender distribution, voter history, registration trends.

- **Insights:** Ages 25-34 have the highest engagement; 18-24 group shows room for improvement.

- **Recommendations:** Target younger voters through social media and improve returning voter campaigns.

### 2. Security & Integrity Monitoring Dashboard

- **Goal:** Identify security threats and vulnerability patterns.

- **Key Visualizations:** Incident types and trends by time.

- **Insights:** Highest incidents occur during weekends and late-night hours.

- **Recommendations:** Strengthen monitoring and implement two-factor authentication for high-risk periods.

### 3. User Experience Dashboard

- **Goal:** Assess user interaction and improve usability.

- **Key Visualizations:** Drop-off analysis, device usage, sentiment analysis on feedback.

- **Insights:** High drop-off rate at the start; mobile is the primary device.

- **Recommendations:** Improve mobile navigation, add progress indicators, and gather user feedback.

[View the Power BI Dashboards Here 📊](https://app.powerbi.com/view?r=eyJrIjoiYzJhNDE5MjMtNTA4OC00NmU1LTg5YzMtMmYwODFiOWIyZmY4IiwidCI6IjYyMGJjNTRiLTE2Y2YtNDhjNy1iNWE3LTY0ZmFkNmI5OTdhZiJ9)

## 📈 Key Performance Indicators (KPIs)
Using DAX, KPIs were created to monitor platform performance, such as Returning Voter Rate, First-Time Voter Rate, Security Breach Rate, and User Drop-Off Rate.

**Example KPIs:**

Returning Voter Turnout Rate
```dax
ReturningVoters = CALCULATE(COUNTROWS(Voter_Registration), Voter_Registration[Voting_History] = TRUE)
Security Breach Rate
```

```dax
SecurityBreachRate = DIVIDE(
    CALCULATE(COUNTROWS('security_logs'), 'security_logs'[event_type] = "Security Breach"),
    COUNTROWS('security_logs')
)
```

# 🏁 Conclusion
Through SQL-based data cleaning and Power BI dashboards, this project provided actionable insights into voter engagement, security, and user experience in an online voting system. The recommendations aim to improve voter turnout, reduce security threats, and enhance user experience. With these improvements, stakeholders can make data-driven decisions that support a secure, accessible, and user-friendly online voting platform.

[View the Full SQL Scripts Here 📝](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Online%20Voting%20Analysis/SQL%20Analysis.md)
\
[View the Power BI Dashboards Here 📊](https://app.powerbi.com/view?r=eyJrIjoiYzJhNDE5MjMtNTA4OC00NmU1LTg5YzMtMmYwODFiOWIyZmY4IiwidCI6IjYyMGJjNTRiLTE2Y2YtNDhjNy1iNWE3LTY0ZmFkNmI5OTdhZiJ9)
