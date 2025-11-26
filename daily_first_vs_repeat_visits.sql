Q -- Customer Behavior Analysis — First Visit vs Repeat Visit Using SQL

---Schema

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

---Sample Data

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);

---Query

select * from customer_orders;

With First_Visit_date as (select Customer_id, MIN(order_date) as First_Visit_Date from customer_orders
group by Customer_id)

select co.order_date, sum(case when co.order_date=fv.First_Visit_Date then 1 else 0 end) as First_Visit_flag, 
sum(case when co.order_date!=fv.First_Visit_Date then 1 else 0 end) as Repeat_Visit_flag
from customer_orders co inner join First_Visit_date fv
on co.Customer_id= fv.Customer_id 
group by order_date;

---Explanation

---Explanation

A CTE (First_Visit_date) is used to identify the first order date for each customer by selecting the minimum order_date.

The main query joins each order to the customer’s first visit date and uses CASE expressions to categorize orders:

If the order date matches the customer’s first visit date → it is counted as a First Visit

Otherwise → it is counted as a Repeat Visit

For each order_date, the query calculates:

SUM(CASE WHEN … First_Visit THEN 1 ELSE 0) → Total first-time customers on that day

SUM(CASE WHEN … Repeat THEN 1 ELSE 0) → Total returning customers on that day

Finally, results are grouped by order date to produce daily counts of new vs. repeat customer visits.
