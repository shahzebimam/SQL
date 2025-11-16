Q - Calculate total sales for each day and return the day with the 3rd highest sales value.

---Schema

CREATE TABLE sales_data (
    order_date DATE,
    customer_id INT,
    store_id INT,
    product_id INT,
    sale INT,
    order_value INT);

---Sample Data

INSERT INTO sales_data (order_date, customer_id, store_id, product_id, sale, order_value)
VALUES
('2024-12-01', 109, 1, 3, 2, 700),
('2024-12-02', 110, 2, 2, 1, 300),
('2024-12-03', 111, 1, 5, 3, 900),
('2024-12-04', 112, 3, 1, 2, 500),
('2024-12-05', 113, 3, 4, 4, 1200), 
('2024-12-05', 114, 3, 4, 2, 400),
('2024-12-05', 115, 3, 4, 1, 300),
('2024-12-01', 101, 1, 4, 2, 500),
('2024-12-01', 102, 1, 4, 1, 300),
('2024-12-02', 103, 2, 4, 3, 900),
('2024-12-02', 104, 2, 4, 1, 400),
('2024-12-03', 105, 1, 4, 2, 600),
('2024-12-03', 106, 1, 4, 3, 800),
('2024-12-04', 107, 3, 4, 1, 200),
('2024-12-04', 108, 3, 4, 2, 500);

---Query

select * from sales_data;

select order_date, SUM(ORDER_VALUE) Daily_Sales
from sales_data
group by order_date
order by Daily_Sales desc
offset 2 rows fetch next 1 rows only;

---Explanation

Each day’s total sales are computed using SUM(order_value).

Results are sorted in descending order to rank daily performance.

OFFSET 2 skips the top 2 highest sales days.

FETCH NEXT 1 ROWS ONLY returns the 3rd highest sales day.

