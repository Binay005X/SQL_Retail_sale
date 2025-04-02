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

```

- **Data Cleaning**: Identified and removed 13 rows with missing values to ensure data accuracy and reliability

```sql

  -- Handling missing values --
  
  -- checking null values --
  
    select * from retail_sales 
    where transactions_id is null;
    
    select * from retail_sales 
    where 
    	transactions_id is null
    	or
    	sale_date is null
    	or 
    	sale_time is null
    	or
    	customer_id is null
    	or 
    	gender is null
    	or 
    	age is null
    	or 
    	category is null
    	or 
    	quantity is null
    	or 
    	price_per_unit is null
    	or 
    	cogs is null
    	or 
    	total_sale is null;

```

```sql

-- Deleting null values --

  delete from retail_sales 
  where 
  	transactions_id is null
  	or
  	sale_date is null
  	or 
  	sale_time is null
  	or
  	customer_id is null
  	or 
  	gender is null
  	or 
  	age is null
  	or 
  	category is null
  	or 
  	quantity is null
  	or 
  	price_per_unit is null
  	or 
  	cogs is null
  	or 
  	total_sale is null;

```

# Data Analysis and Findings

## Data Exploration

## Q1. How many sales we have ?

```sql

select count(*) as total_sale from retail_sales;

```

## Q2. How many customers do we have ?

```sql

select count(distinct customer_id) as total_sale from retail_sales;

```

## Q3. How many unique category we have ?

```sql

select distinct category from retail_sales;

```

## Data Analysis and Business key problem answers 

## Q1. How can we track daily sales performance to understand revenue trends on a specific date 11 November 2022 ?

```sql

select * from retail_sales
where sale_date = '2022-11-05';

```

## Q2. How can we identify high-performing product categories, specifically for clothing, to optimize inventory for the month of November 2022 ?

```sql

select * from retail_sales
where 
	category = 'Clothing'
	and 
	to_char(sale_date, 'YYYY-MM') = '2022-11'
	and 
	quantity >= 4;

```

## Q3. What is the total sales contribution of each product category, and how can we use this to drive targeted marketing strategies ?

```sql

select category,
	rsum(total_sale) as net_sale
from retail_sales
group by category;

```

## Q4. Can we determine the average age of customers purchasing beauty products to create more personalized marketing campaigns ?

```sql

select 
	round(avg(age),2) as avg_age 
from retail_sales
where category = 'Beauty';

```

## Q5.  How do we identify high-value transactions where sales exceed a specific threshold to analyze premium customer behavior?

```sql

select * from retail_sales
where total_sale > 1000;

```

## Q6.  What insights can we gain from the number of transactions segmented by gender and product category to enhance our customer segmentation efforts ?

```sql

select 
	category,
	gender,
	count(*) as total_trans
from retail_sales
group by 
	category,
	gender
order by 1;

```

## Q7.  What is the average monthly sales performance, and which month stands out as the best-selling month each year ? How can this data inform our seasonal sales strategies ? 

```sql

  select 
  	year,
  	month,
  	avg_sale
  from 
  (
  	select 
  		extract(year from sale_date) as year,
  		extract(month from sale_date) as month,
  		avg(total_sale) as avg_sale,
  		rank() over(partition by extract (year from sale_date) order by avg(total_sale)desc) as rank
  	from retail_sales
  	group by 1,2
  	
  ) as t1
  where rank = 1

```

## Q8.  Who are our top 5 customers based on total sales, and how can we leverage this data to increase customer retention and loyalty ? 

```sql

  select 
	customer_id,
	sum(total_sale) as total_sales
  from retail_sales
  group by 1
  order by 2 desc
  limit 5;

```

## Q9.  How many unique customers purchase from each category, and what does this indicate about category-specific customer engagement ?

```sql

  select 
	category,
	count(distinct customer_id) as count_unique_customer
  from retail_sales
  group by category;

```

## Q10.  How can we analyze order volume across different times of the day (morning, afternoon, evening) to optimize staffing and inventory management ?

```sql

  with hourly_sale
    as (
    	select *, 
    		case 
    			when extract(hour from sale_time) < 12 then 'Morning'
    			when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
    			else 'Evening'
    		end as shift
    	from retail_sales
    	)
    select
    	shift,
    	count(*) as total_orders
    from hourly_sale
    group by shift

```


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
