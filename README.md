📊 Netflix Data Analysis Dashboard
📌 Project Overview

This project analyzes Netflix content using SQL and Power BI to uncover insights about movies and TV shows available on the platform. The dataset contains information such as titles, genres, ratings, release year, countries, and content type.

The goal of this project is to perform data analysis using SQL queries and create an interactive Power BI dashboard that helps visualize Netflix content trends.

🗂 Dataset

The dataset used in this project contains information about Netflix titles including:

Show ID

Title

Type (Movie / TV Show)

Director

Cast

Country

Date Added

Release Year

Rating

Duration

Genre

Description

🛠 Tools & Technologies

SQL (MySQL) – Data analysis and querying

Power BI – Dashboard creation and visualization

Excel / CSV – Dataset source

📈 Dashboard Features

The Power BI dashboard provides several insights including:

🔹 Key Performance Indicators (KPIs)

Total Movies

Total TV Shows

Total Content

Percentage of Movies

🔹 Visualizations

Top Genres on Netflix

Movies vs TV Shows Distribution

Content Rating Distribution

Content Released by Year

Country-wise Content Availability

Top Countries with Netflix Content

🧠 SQL Analysis

Several SQL queries were used to analyze the dataset such as:

Count number of Movies vs TV Shows

Find the most common ratings

Identify top countries with Netflix content

Detect longest movies

Find content added in last 5 years

Identify top actors in Indian movies

Analyze content categories based on descriptions

Example query used in the project:

SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1;

More SQL queries are available in the project file:
📄

📊 Dashboard Preview

The dashboard includes:

Interactive charts

Genre analysis

Content trends by year

Country distribution map

Rating analysis

These visualizations help users understand Netflix content distribution and trends.

🎯 Key Insights

Movies make up around 70% of Netflix content

Drama and Documentary are among the most popular genres

Content releases increased significantly after 2016

The United States and India contribute large amounts of content

📁 Project Structure
Netflix-Data-Analysis
│
├── netflix_titles.csv
├── Netflix_data_analysis.sql
├── Netflix_Dashboard.pbix
└── README.md
🚀 How to Use

Import the dataset into MySQL.

Run the SQL queries to analyze the data.

Load the dataset into Power BI.

Create visualizations and build the dashboard.

👨‍💻 Author

Abhiram

Aspiring Data Analyst skilled in:

SQL

Power BI

Data Visualization

Data Analysis

Excel

Tableau

Python
