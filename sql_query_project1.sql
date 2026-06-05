-- Reading All values..
select *
from retail_sales;

-- Checking Null Values in Transaction_id...
select *
from retail_sales 
where transactions_id is null;


--Checking Null Values in Sales_date...
select *
from retail_sales 
where sale_date is null;


-- checking null values in database table .....
select *
from retail_sales 
where sale_time is null OR
      customer_id is null OR
	  gender is null OR
	  age is null OR
	  category is null OR
	  quantiy is null or
	  price_per_unit is null OR 
	  cogs is null OR
	  total_sale is null ;


--- deleting the null values from the tables.....

delete from retail_sales
where sale_time is null 
      OR
      customer_id is null 
	  OR
	  gender is null 
	  OR
	  age is null
	  OR
	  category is null 
	  OR
	  quantiy is null 
	  OR
	  price_per_unit is null 
	  OR 
	  cogs is null 
	  OR
	  total_sale is null ;



--- Data expolaration

-- How many sales we have ??
select 
count(*) as total_sales
from retail_sales ;

-- how many distinct customer we have ??
select 
count(distinct customer_id)
from retail_sales ;


-- DATA Analyst && BUssinesss problem ....

--Q.1 write a sql query to retrive all columns for sales made on 2022-11-05

  select *
  from retail_sales 
  where date(sale_date)='2022-11-05';



--Q.2 write a sql query to retrive all transactions where the category is 'cloathing' and the quantity sold is more than 2 in the

  select *
  from retail_sales 
  where category ='Clothing' AND
  quantiy > 2 and 
		TO_CHAR(sale_date,'YYYY-MM') = '2022-11' ;


--Q,3 Write a Sql query to calculate the total sales (total_sales) for each category..

  select 
  category,
    sum(total_sale) as total_sales,
  from retail_sales
  group by category ;


--Q.4 Write a Sql query to find the average age of customers who purchased items from the "beauty" category .

select 
round(avg(age),2) as average_age
from retail_sales
where category ='Beauty' ;


--Q.5 Write a SQl Query to find all Transactions where the total_sale is greater than 1000..

select *
from retail_sales
where total_sale >1000;


--Q.6 Write a Sql Query to Find the total number of Transactions (transaction_id) Made by each Gender in each Category..
 Select
 category,
 gender,
 count(transactions_id) as total_number_transactions
 from retail_sales
 group by category ,gender
 order by category asc ;


--Q.7  Write a Sql Query to Calculate the Average Sale for Each Month. Find Out The Best Selling Month in Each Year..
 
 
 SELECT *
 from (
  SELECT 
  extract(year from sale_date) as Year ,
  Extract(Month From sale_date) as Month,
 avg(total_sale) as average_sale,
 rank() over(partition by   extract(year from sale_date) order by avg(total_sale) desc)
  from retail_sales 
  group by Year,Month ) as t1

  where rank =1;



--Q.8 Write a Sql Query to Find the Top 5 Customers Based on the Highest Total Sales....

  SELECT 
  customer_id,
  sum(total_sale)
  from retail_sales
  group by customer_id
  order by 2 desc 
  limit 5;


--Q.9 Write a Sql Query to Find the Number Of unique Customers Who Purchased items From Each Category...

  Select 
  count(distinct(customer_id)) as Unique_customer,
  category
  from retail_sales 
  group by category
  order by category asc ;



--Q.10 Write a Sql Query To Create each Shift aqnd Number of Orders (Example Morning <=12 , Afternoon Between 12 & 17 , Evening >17 )...


  with hourly_sale as
(
  SELECT * ,
  CASE
    When Extract(hour from sale_time) <12 then  'Morning'
        When Extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		Else 'Evening'
    End as shift

FROM retail_sales 
)

select 
shift,
count(*) as total_orders
from hourly_sale
group by shift ;


------------------------END OF PROJECT ABOUT REATAIL_SALES .......................






