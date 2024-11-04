# 🚚 UrbanEats Delivery Route Optimization Project

Welcome to the UrbanEats Delivery Optimization Project! This project focuses on optimizing delivery routes and improving delivery efficiency for food delivery services in dense urban areas. Through SQL-based data retrieval and analysis combined with Power BI for visualization, this dashboard helps UrbanEats tackle challenges like driver attrition, traffic congestion, and delayed deliveries.

![](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Route%20Optimization%20for%20Food%20Delivery%20Analysis/Route%20Optimization.jpg)
<!-- ![Project Image]() <!-- Replace with the actual path or link to your overview image -->

## 📑 Table of Contents
- [Project Overview](#project-overview)
- [Problem Statement](#problem-statement)
- [Project Objectives](#project-objectives)
- [Key Insights & Findings](#key-insights--findings)
- [Solution Architecture](#solution-architecture)
- [Data and SQL Scripts](#data-and-sql-scripts)
- [Power BI Dashboards](#power-bi-dashboards)
  - [1. Customer Orders Overview](#1-customer-orders-overview)
  - [2. Traffic Density Analysis](#2-traffic-density-analysis)
  - [3. Driver Attrition Analysis](#3-driver-attrition-analysis)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
- [Interactive Dashboard](#interactive-dashboard)
- [Conclusion and Next Steps](#conclusion-and-next-steps)

---

## 📝 Project Overview

This project explores route optimization for UrbanEats, a food delivery service, focusing on improving delivery efficiency in a high-density urban environment. By analyzing customer orders, driver schedules, and traffic patterns, this solution aims to streamline routes, reduce delivery times, and enhance both customer satisfaction and driver retention.

Through SQL and Power BI, I conducted data analysis and created interactive dashboards, which reveal insights on delivery delays, driver attrition, and traffic bottlenecks in specific areas of the city.

## 🛠 Problem Statement

UrbanEats faces several critical challenges:
- **Prolonged delivery times** 🚗💨, leading to decreased customer satisfaction.
- **High operational costs** 💸 due to inefficient routing and traffic congestion.
- **Inaccurate delivery estimates** ⏳, creating customer frustration.
- **High driver attrition** 👨‍🔧👩‍🔧 attributed to stressful working conditions and demanding shifts.

This project tackles these issues by developing a data-driven solution that optimizes delivery routes, reduces stress on drivers, and minimizes operational costs.

## 🎯 Project Objectives

### 🎯 Goals
- **Optimize delivery routes** to achieve at least a 20% reduction in delivery lead times.
- **Reduce operational costs** by 15% through efficient routing.
- **Enhance driver satisfaction** by improving work conditions and optimizing shifts.

### 🔍 Solution Objectives

- Leverage **SQL for data manipulation** and **Power BI for visualization** to identify and address delivery challenges.
- **Provide real-time insights** into traffic density, driver performance, and delivery times.
- **Offer actionable insights** for the UrbanEats management team to improve operational efficiency.

## 📊 Key Insights & Findings

**1. Optimize Route Planning:**

- **Problem:** High delays for specific drivers due to traffic and route inefficiencies.

- **Solution:** Implement optimized routing algorithms using real-time traffic data to reduce delivery times in high-density areas.

**2. Improve Driver Scheduling:**

- **Problem:** High workload for certain drivers leads to burnout and delays.

- **Solution:** Balance shifts across all drivers, especially during peak days (Wednesdays and Thursdays).

**3. Enhance Customer Communication:**

- **Problem:** High percentage of pending orders impacts customer satisfaction.

- **Solution:** Provide real-time updates on order status and estimated delivery times to improve transparency.

**4. Focus on High-Demand Restaurants:**

- **Problem:** Restaurants like Nguyen-Lopez face high demand, leading to delays.

- **Solution:** Coordinate with high-demand restaurants for quicker order preparation to reduce wait times for drivers.


## 🏗️ Solution Architecture

The solution combines data retrieval and analysis in **SQL** with visualization in **Power BI**. It includes:
1. **Data Ingestion**: Importing data from various tables including Customer Orders, Drivers, Traffic, and Restaurants.
2. **Data Transformation**: Cleaning and transforming data in SQL to create views that support analysis.
3. **Visualization**: Creating Power BI dashboards to visualize key metrics and enable interaction with filters.

---

## 📂 Data and SQL Scripts

The project includes four main datasets:

1. **Customer Orders**: Contains details on each order, including delivery address, timestamp, and status.
2. **Traffic Data**: Provides traffic density information by location.
3. **Drivers**: Stores driver information and their shift schedules.
4. **Restaurants**: Contains restaurant identifiers and addresses.

### 📄 SQL Scripts
To demonstrate SQL proficiency, all SQL scripts used for data cleaning, transformation, and analysis are stored in the [`Sql-query-and-answer`](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Route%20Optimization%20for%20Food%20Delivery%20Analysis/SQL%20QUERY%20AND%20ANSWER.md) folder. The main queries include:
- Calculating average delivery times by day and location.
- Identifying high-density traffic zones based on timestamp.
- Deriving driver shift analysis, including maximum and minimum shift durations.

Feel free to explore these scripts to understand the SQL operations behind the insights.

---

## 📈 Power BI Dashboards

The project’s visual insights are presented through three main Power BI dashboards:

### 1. 📦 Customer Orders Overview

![Customer Orders Dashboard](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Route%20Optimization%20for%20Food%20Delivery%20Analysis/Overview%20Page.PNG) <!-- Replace with the actual path or link to your dashboard image -->

This dashboard provides an overview of customer orders and reveals patterns in delivery delays and order density by day:
- **Order Status**: Shows pending vs. delivered orders.
- **Day of Week Analysis**: Visualizes peak delivery days.
- **Top 5 Active Drivers**: Highlights the most active drivers based on order count.

<!-- [Explore the Interactive Dashboard](#interactive-dashboard) <!-- Link to the interactive version if hosted on Power BI service -->

### 2. 🛑 Traffic Density Analysis

![Traffic Density Dashboard](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Route%20Optimization%20for%20Food%20Delivery%20Analysis/Traffic%20Density%20Analysis%20Page.PNG) <!-- Replace with the actual path or link to your dashboard image -->

Key insights include:
- **Traffic Density**: Displays average traffic density across high-congestion zones, showing peak hours and locations.
- **Delivery Delays by Hour**: Visualizes delay patterns across different times of the day, with notable congestion at 7 AM.
- **Congestion Map**: A geographical view that highlights traffic bottlenecks on delivery routes.

### 3. 👷 Driver Attrition Analysis

![Driver Attrition Dashboard](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Route%20Optimization%20for%20Food%20Delivery%20Analysis/Driver%20Attrition%20Analysis%20Page.PNG) <!-- Replace with the actual path or link to your dashboard image -->

This dashboard focuses on driver workload and attrition trends:
- **Drivers with Highest Delays**: Shows the drivers most affected by delays.
- **Shift Analysis**: Highlights drivers with the longest and shortest shifts to help identify overworked drivers.
- **Active Driver Count**: Monitors the number of drivers on active shifts to optimize workforce allocation.

---

## 💻 Technologies Used

- **SQL (PostgreSQL)**: Data collection, transformation, and analysis.
- **Power BI**: Data visualization and dashboard creation.
- **Microsoft Excel** (Optional): Data export for further analysis.

---

## 🚀 Getting Started

To replicate or adapt this project:

1. **Clone this repository**:
   ```bash
   git clone https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/edit/main/Route%20Optimization%20for%20Food%20Delivery%20Analysis.git

   ```

2. **Set up a PostgreSQL Database** and load the datasets provided in the /data folder.

3. **Run SQL Scripts:**
- Use scripts from the [sql-scripts](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Route%20Optimization%20for%20Food%20Delivery%20Analysis/SQL%20SCHEMA.sql) folder to prepare and analyze the data.

4. **Power BI Dashboard:**
- Open the provided `.pbix` file in Power BI Desktop to explore the dashboards interactively.

---

## 🌐 Interactive Dashboard

> **Note**: This interactive dashboard is hosted on Power BI Service. You can view and interact with the dashboards in real-time to explore data insights dynamically.

Check the [Interactive Dashboard](https://app.powerbi.com/view?r=eyJrIjoiNTc1N2EzOGQtNDFlOC00NmRlLWJkMDgtYjg5Y2NmYjAxMWI1IiwidCI6IjYyMGJjNTRiLTE2Y2YtNDhjNy1iNWE3LTY0ZmFkNmI5OTdhZiJ9) <!-- Replace with a GIF preview and link to the interactive dashboard -->

### Dashboard Highlights
- **Customer Orders Overview**: Interact with the order density map, order status filters, and peak delivery times.
- **Traffic Density Analysis**: Dive into traffic hotspots by filtering by hour and location.
- **Driver Attrition Insights**: Filter by driver, shift length, and delivery delays to analyze driver performance trends.

---


## 🏆 Conclusion and Next Steps

Through this project, UrbanEats has a data-driven route optimization solution that reduces delivery times, minimizes operational costs, and improves driver satisfaction. This solution lays the groundwork for further development, such as integrating real-time traffic data or using machine learning for predictive delivery times.

### 🔜 Next Steps
- **Integrate real-time traffic feeds** to dynamically adjust delivery routes.
- **Implement machine learning algorithms** for predictive analysis of delivery times.
- **Expand analysis** to include seasonal order patterns to optimize driver allocation further.

Thank you for exploring this project. Feel free to reach out for any questions or collaboration opportunities!

[**Check the Sql Analysis here**](https://github.com/jimi121/SQL-AND-POWER-BI-PROJECTS/blob/main/Route%20Optimization%20for%20Food%20Delivery%20Analysis/SQL%20QUERY%20AND%20ANSWER.md)

[**Check the Interactive Dashboard here**](https://app.powerbi.com/view?r=eyJrIjoiNTc1N2EzOGQtNDFlOC00NmRlLWJkMDgtYjg5Y2NmYjAxMWI1IiwidCI6IjYyMGJjNTRiLTE2Y2YtNDhjNy1iNWE3LTY0ZmFkNmI5OTdhZiJ9)

# 📬 Contact
Feel free to reach out if you have any questions or feedback:

- **Email:** olajimiadeleke4@gmail.com

- **LinkedIn:** [LinkedIn](https://www.linkedin.com/in/olajimi-adeleke?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_view_base_contact_details%3BSD4ss04nTYSVT8liopMYTA%3D%3D)

- **Portfolio:** [Portfolio]()
