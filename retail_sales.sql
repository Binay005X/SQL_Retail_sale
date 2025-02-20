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

SELECT * FROM retail_sales;

SELECT COUNT(*) FROM retail_sales;


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


SELECT COUNT(*) FROM retail_sales;



-- Data Exploration --


-- How many sales we have ?

select count(*) as total_sale from retail_sales;


-- How many customers do we have ? --

select count(distinct customer_id) as total_sale from retail_sales;


-- How many unique category we have ? --

select distinct category from retail_sales;


--  Data Analysis and Business key problem answers 


-- Q1. How can we track daily sales performance to understand revenue trends on a specific date 11 November 2022 ?


select * from retail_sales
where sale_date = '2022-11-05';


-- Q2. How can we identify high-performing product categories, specifically for clothing, to optimize inventory for the month of November 2022 ?

select * from retail_sales
where 
	category = 'Clothing'
	and 
	to_char(sale_date, 'YYYY-MM') = '2022-11'
	and 
	quantity >= 4;


-- Q3. What is the total sales contribution of each product category, and how can we use this to drive targeted marketing strategies ?

select category,
	rsum(total_sale) as net_sale
from retail_sales
group by category;


-- Q4.Can we determine the average age of customers purchasing beauty products to create more personalized marketing campaigns ?

select 
	round(avg(age),2) as avg_age 
from retail_sales
where category = 'Beauty';


-- Q5. How do we identify high-value transactions where sales exceed a specific threshold to analyze premium customer behavior?

select * from retail_sales
where total_sale > 1000;


-- Q6. What insights can we gain from the number of transactions segmented by gender and product category to enhance our customer segmentation efforts?

select 
	category,
	gender,
	count(*) as total_trans
from retail_sales
group by 
	category,
	gender
order by 1;


-- Q7. What is the average monthly sales performance, and which month stands out as the best-selling month each year? 
-- How can this data inform our seasonal sales strategies? 

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

-- order by 1,3 desc;


-- Q8. Who are our top 5 customers based on total sales, and how can we leverage this data to increase customer retention and loyalty?

select 
	customer_id,
	sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;


-- Q9. How many unique customers purchase from each category, and what does this indicate about category-specific customer engagement?

select 
	category,
	count(distinct customer_id) as count_unique_customer
from retail_sales
group by category;



-- Q10.	How can we analyze order volume across different times of the day (morning, afternoon, evening) to optimize staffing and inventory management?

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


-- select extract (hour from current_time)



-- End of project



 
