

SELECT * FROM kpmg.transactions;

-- number of transactions via each customer id
-- customer_id with product class
-- customer _id with online order
-- customer id with country state and postal

select customer_id,
count(transaction_id) as number_of_transactions
from transactions
where order_status = 'approved'
group by 1;

select * from transactions;










SELECT * FROM kpmg.customer_demographics;

-- customer_id and job title , age, own car or not


select DATE_FORMAT(FROM_UNIXTIME(age),'%Y-%m-%d')
from (
select customer_id, DOB,
	datediff(NOW(),DOB) AS age
    from customer_demographics) as age_final;
    
    
    
select customer_id, DOB,
	datediff(Year(NOW()),year(DOB)) AS age
    from customer_demographics;
    
SELECT NOW();

-- ---------------------------------------------------CALCULATING AGE ------------------------------------
select customer_id, TIMESTAMPDIFF(YEAR, DOB, NOW()) as age
FROM customer_demographics
ORDER BY age  ;


create view  cte_customer_demographics as
with CTE_customer_demographics as 
( Select
	customer_id, age,
	gender,
	case when age >= 18 and age <= 28 then 'young_age/18-28'
	when age >= 29 and age <= 45 then 'mature/29-45'
	when age >= 46 then 'old_people/>46'
	else 'none/NA/NULL'
	end as age_group,
	past_3_years_bike_related_purchases,
	wealth_segment,
	owns_car,
	job_title,
	job_industry_category
    
		from 
			(select *, TIMESTAMPDIFF(YEAR, DOB, NOW()) as age
			FROM customer_demographics) as age)
            
select * from cte_customer_demographics;


select *from cte_customer_demographics;













 -- ----------------------------------------------------------------------------------DEMOGRAPHICS FACTORS Analysis
-- DEMOGRAPHICS FACTORS
-- AGE
-- GENDER
-- INDUSTRY/JOBTITLE
-- WEALTH SEGMENT
-- PAST THREE YEAR BIKE TREND
-- OWNS CAR

-- ------------------------------------- AGE  BASED ANALYSIS & Gender Based ----------------------

select * from transactions;


select 
*
from cte_customer_demographics

left join transactions
	on transactions.customer_id = cte_customer_demographics.customer_id
 where order_status = 'Approved'   
 group by 1;
 
 

select 
age_group,

count(transaction_id) as number_of_transactions
from cte_customer_demographics

left join transactions
	on transactions.customer_id = cte_customer_demographics.customer_id
 where order_status = 'Approved'   
 group by 1
 order by 2 desc; -- assuming approved are the ones we are interested in 

-- RESULTS: mature/29-45 most and then older people



select 
case when gender = "F" or gender ="Femal"or gender = "F" or gender = "Female" then 'Female'
				  when gender = "M" or gender ="Male" then "Male"
                  else "U"
                  end as correct_gender,
owns_car,

count(transaction_id) as number_of_transactions
from cte_customer_demographics
left join transactions
	on transactions.customer_id = cte_customer_demographics.customer_id
 where order_status = 'Approved'   
 group by 1,2
order by 2 desc ; -- assuming approved are the ones we are interested in 

-- RESULTS: MOST OF THE FEMALES are likely to purchase the bike products











select * from cte_customer_demographics;

-- select *, case when gender = "F" or gender ="Femal"or gender = "F" or gender = "Female" then 'Female'
-- 				  when gender = "M" or gender ="Male" then "Male"
--                   else "U"
--                   end as correct_gender
-- 							from cte_customer_demographics;

select distinct gender, count(gender)  from cte_demographics group by 1;
 
-- number of transactions via each customer id
-- customer_id with product class
-- customer _id with online order
-- customer id with country state and postal

-- DEMOGRAPHICS FACTORS
-- AGE
-- GENDER
-- INDUSTRY/JOBTITLE
-- WEALTH SEGMENT
-- PAST THREE YEAR BIKE TREND
-- OWNS CAR
select * from cte_customer_demographics;

select * from transactions;
SELECT  wealth_segment,
		count(past_3_years_bike_related_purchases) total_past_3_years_bike_purchases,
		
	-- job_title  from cte_customer_demographics

count(transaction_id) as number_of_transactions
from cte_customer_demographics
left join transactions
	on transactions.customer_id = cte_customer_demographics.customer_id
 where order_status = 'Approved'  and job_title is null or job_title <> "" or length(job_title) = 0
 group by 1
 order by 3 desc
; -- 
 
 
 -- ----------- RESULTS: mass customer and then about the same with affluent and high net worth, least with affluent customer
 
 
 
 -- Job Industry 
 
 
 SELECT  
		job_industry_category,
        count(past_3_years_bike_related_purchases) total_past_3_years_bike_purchases,
		
	
	-- job_title  from cte_customer_demographics

count(transaction_id) as number_of_transactions
from cte_customer_demographics
left join transactions
	on transactions.customer_id = cte_customer_demographics.customer_id
 where order_status = 'Approved'  and job_title is null or job_title <> "" or length(job_title) = 0
 group by 1
 order by 3 desc; 
 
 -- Customers working for manufacuring, financial and health, retail and property are buying more
 
 
 select past_3_years_bike_related_purchases from cte_customer_demographics;
 
 
 
 -- -------------------------- OWNS A CAR OR NOT -------
 
 select * from cte_customer_demographics;
 
 
 SELECT  
		owns_car,
	
	
	-- job_title  from cte_customer_demographics

count(transaction_id) as number_of_transactions
from cte_customer_demographics
left join transactions
	on transactions.customer_id = cte_customer_demographics.customer_id
 where order_status = 'Approved'  and job_title is null or job_title <> "" or length(job_title) = 0
 group by 1
 order by 2 desc;  
 
 -- most of the people own car
 
  -- ------------------------------------------------CUSTOMER ADDRESS ANALYTICS
  
  select * from customer_address;
  
  
  select country,
			state,
            
count(transaction_id) as number_of_transactions
from customer_address
left join transactions
	on transactions.customer_id = customer_address.customer_id
 where order_status = 'Approved' 
 group by 1,2
 order by 3 desc
 
 ;
 
 select * from transactions;
 
 select 
 
 country, 
 state,
 postcode,
count(postcode) as number_of_same_destination,
count(transaction_id) as number_of_transactions
from customer_address
left join transactions
	on transactions.customer_id = customer_address.customer_id 
    where order_status = 'Approved' 

 group by 1,2,3
 order by 4 desc;
 
 select 
-- customer_address.customer_id
country,
state,
postcode as number_of_same_destination,
count(transaction_id) as number_of_transactions

from customer_address
left join transactions
	on transactions.customer_id = customer_address.customer_id 
    where order_status = 'Approved' 
 group by 1,2,3
 order by 4 desc ;
 
 -- -----------------
  select 
-- customer_address.customer_id
country,
case when state = "New South Wales" then 'NSW' else state end as ajusted_state,
postcode as number_of_same_destination,
count(transaction_id) as number_of_transactions
from customer_address
left join transactions
	on transactions.customer_id = customer_address.customer_id 
    where order_status = 'Approved' 
 group by 1,2,3
 order by 4 desc;







select distinct state from customer_address;
 
 
 -- to prove that count of transaction_id and count of postal code is same
 select number_of_same_destination, sum(number_of_transactions) from(
  select 
customer_address.customer_id,
postcode as number_of_same_destination,
count(transaction_id) as number_of_transactions
from customer_address
left join transactions
	on transactions.customer_id = customer_address.customer_id 
    where order_status = 'Approved' 

 group by 1,2) as f
 group by 1;
 -- order by 4 desc;
 
 select * 
 
 from customer_address
left join transactions
	on transactions.customer_id = customer_address.customer_id
where order_status = 'Approved' 
;



-- ------------------------------------- TRANSACTIONS D

select * from transactions;

select 
-- brand, 
product_size,
	count(transaction_id) as total_transaction

from transactions
where order_status = 'Approved'
group by 1
order by 2 desc; 

			-- RESULT: MEDIUS PRODUCT SIZE IS PREFERED
	select 
brand, 

	count(transaction_id) as total_transaction
from transactions
where order_status = 'Approved'
group by 1
order by 2 desc;  -- solex, giant bicycles wear2b are the most common one

select distinct product_line, product_class, product_size
from transactions;

select 
 *,
	(road_demand + mountain_demand +touring_demand+standard_demand) as total_count

from (
select 
	online_order,
    count(case when product_line = 'Road' then transaction_id else null end) as road_demand,
    count(case when product_line = 'Mountain' then transaction_id else null end) as mountain_demand,
    count(case when product_line = 'Touring' then transaction_id else null end)as touring_demand,
    count(case when product_line = 'Standard' then transaction_id else null end)as standard_demand
from transactions
where order_status = 'Approved' and online_order <> ""
group by 1) as final group by 1;
-- maind demad for road bike
-- main demand via online platform 

select product_id,
	list_price,
    standard_cost,
    (list_price- standard_cost ) as revenue
from transactions
group by 1
order by 4 desc;

    
