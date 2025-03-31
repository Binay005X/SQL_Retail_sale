# SQL_Retail_sale

- **Project Overview**: Conducted a comprehensive retail sales analysis using SQL to derive actionable insights for business optimization. The project involved database setup, data cleaning, exploratory data analysis, and addressing key business questions.
  
# Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

# Project Structure

# 1. Database Setup

**Database Creation**: The project starts by creating a database named sql_retail_p2.

**Table Creation**: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql

  CREATE TABLE retail_sales
  (
      transactions_id INT PRIMARY KEY,
      sale_date DATE,	
      sale_time TIME,
      customer_id INT,	
      gender VARCHAR(10),
      age INT,
      category VARCHAR(35),
      quantity INT,
      price_per_unit FLOAT,	
      cogs FLOAT,
      total_sale FLOAT
  );

```sql

- **Data Cleaning**: Identified and removed 13 rows with missing values to ensure data accuracy and reliability.

# Findings

- **Sales Performance**: Analyzed daily sales trends, identifying peak sales periods and contributing factors. For example, the best-selling month in 2022 was July with an average sale of approximately 541.34, and in 2023, it was February with an average sale of approximately 535.53.

- **Customer Insights**: Identified top 5 customers contributing significantly to revenue, with Customer ID 3 leading at 38,440 in total sales. This data was leveraged to enhance customer retention strategies.

- **Category Analysis**: Determined unique customer engagement across categories, with Clothing attracting 149 unique customers, Electronics 144, and Beauty 141, indicating balanced engagement.

- **Transaction Analysis**: Segmented transactions by gender and category, revealing that females had 330 transactions in Beauty compared to 281 by males, while males slightly led in Electronics with 343 transactions versus 335 by females.

- **Operational Optimization**: Analyzed order volume across different times of the day, identifying peak evening orders (1,062) compared to morning (548) and afternoon (377), guiding staffing and inventory management strategies.

- **Total Sales Contribution**: Calculated total sales by category, with Electronics contributing 311,445, Clothing 309,995, and Beauty 286,790, informing targeted marketing strategies.

- **Customer Demographics**: Determined the average age of Beauty product customers to be around 40 years, aiding in personalized marketing campaigns.

- **High-Value Transactions**: Identified transactions exceeding 1,000 in total sales, providing insights into premium customer behavior.

- **Seasonal Strategies**: Utilized monthly sales performance data to inform seasonal sales strategies, optimizing inventory and promotional activities.

This project enhanced my SQL skills and ability to translate data into strategic business decisions, demonstrating strong analytical and problem-solving capabilities.
