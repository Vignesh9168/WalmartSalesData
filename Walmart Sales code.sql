select * from [WalmartSalesData.csv]

create database Salesofwalmart

create table salesdata (
 invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
 Branch VARCHAR(30) NOT NULL,
 City VARCHAR(30) NOT NULL,
 Unit_Price decimal(10,2) NOT NULL)

select * from salesdataofwal

------time of day -----

ALTER TABLE salesdataofwal
ADD COLUMN time_of_day VARCHAR(10);

SELECT Date ,Time, (
       CASE
	        WHEN Time BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
			WHEN Time BETWEEN '12:01:00' AND '16:00:00' THEN 'AFTERNOON'
           ELSE  'EVENING'
      END) AS time_of_date
From salesdataofwal 



ALTER TABLE [dbo].[WalmartSalesData.csv]
ADD COLUMN time_of_day VARCHAR(10);



UPDATE [dbo].[WalmartSalesData.csv]
SET time_of_day = 
    CASE 
        WHEN Time BETWEEN '00:00:00' AND '12:00:00' THEN 'MORNING'
        WHEN Time BETWEEN '12:01:00' AND '16:00:00' THEN 'AFTERNOON'
        ELSE 'EVENING'
    END;
----------daytime -------------

select DATE,DATENAME(w,DATE) from salesdataofwal

select DATE,DATENAME(m,DATE) from salesdataofwal

select * from salesdataofwal
---1---
select Distinct(City) from salesdataofwal
---2---
select  Distinct(branch) from salesdataofwal
select Distinct(City), Branch from salesdataofwal
-------product--- 
--1.How many unique product lines does the data have?
select count(Distinct(Product_line)) from salesdataofwal
---2.What is the most common payment method?
     select Distinct(payment) from  salesdataofwal
---3.What is the most selling product line?
      select product_line ,count(product_line) as countof from Salesdataofwal group by Product_line order by  countof desc
---4. what is total revenue per month?
        select datename(m,Date) as monthn, sum(cogs) as total_revenue from Salesdataofwal group by datename(m,Date) order by total_revenue desc
---5.  What month had the largest COGS?
         select datename(m,Date), sum(cogs) as high from Salesdataofwal group by datename(m,Date) order by high desc
---6.What product line had the largest revenue?
           select Product_line, sum(cogs) as revenue from Salesdataofwal group by Product_line order by revenue desc
---7. What is the city with the largest revenue?
         select City,sum(cogs) as revenue from Salesdataofwal group by city order by revenue desc
---8. What product line had the largest VAT?
        select Product_line, avg(Tax_5) avg_tax from Salesdataofwal group by Product_line order by avg_tax desc
---9.Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
       select b.invoice_ID,b.Product_line,
	         (case when cogs > avg_sales Then 'good'
	               else 'Bad'
               end) as Review_column 
	   from(
	      select Product_line, avg(cogs) avg_sales from Salesdataofwal group by Product_line) as new_table 
	       inner join Salesdataofwal b on new_table.Product_line = b.Product_line

---10. Which branch sold more products than average product sold?
           select branch, sum(Quantity) as qty from Salesdataofwal group by Branch
		   having sum(Quantity) > (select avg(Quantity) from Salesdataofwal)

---11.What is the most common product line by gender?
       select gender ,product_line, count(gender) from Salesdataofwal group by Gender, Product_line

----12. What is the average rating of each product line?

     select product_line ,round(avg(Rating),2) from Salesdataofwal group by Product_line






