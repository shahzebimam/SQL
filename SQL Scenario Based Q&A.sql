select * from sales_data;

select order_date, SUM(ORDER_VALUE) Daily_Sales
from sales_data
group by order_date
order by Daily_Sales desc
offset 2 rows fetch next 1 rows only