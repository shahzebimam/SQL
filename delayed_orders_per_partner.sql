Q - For each delivery partner, find the total number of delayed orders.
(Delayed = Actual delivery time > Predicted delivery time)

---Schema 

CREATE TABLE swiggy_orders (
    orderid INT PRIMARY KEY,
    custid INT,
    city VARCHAR(50),
    del_partner VARCHAR(50),
    order_time DATETIME,
    deliver_time DATETIME,
    predicted_time INT -- Predicted delivery time in minutes);

---Sample Data

INSERT INTO swiggy_orders (orderid, custid, city, del_partner, order_time, deliver_time, predicted_time)
VALUES
-- Delivery Partner A
(1, 101, 'Mumbai', 'Partner A', '2024-12-18 10:00:00', '2024-12-18 11:30:00', 60),
(2, 102, 'Delhi', 'Partner A', '2024-12-18 09:00:00', '2024-12-18 10:00:00', 45),
(3, 103, 'Pune', 'Partner A', '2024-12-18 15:00:00', '2024-12-18 15:30:00', 30),
(4, 104, 'Mumbai', 'Partner A', '2024-12-18 14:00:00', '2024-12-18 14:50:00', 45),

-- Delivery Partner B
(5, 105, 'Bangalore', 'Partner B', '2024-12-18 08:00:00', '2024-12-18 08:29:00', 30),
(6, 106, 'Hyderabad', 'Partner B', '2024-12-18 13:00:00', '2024-12-18 14:00:00', 70),
(7, 107, 'Kolkata', 'Partner B', '2024-12-18 10:00:00', '2024-12-18 10:40:00', 45),
(8, 108, 'Delhi', 'Partner B', '2024-12-18 18:00:00', '2024-12-18 18:30:00', 40),

-- Delivery Partner C
(9, 109, 'Chennai', 'Partner C', '2024-12-18 07:00:00', '2024-12-18 07:40:00', 30),
(10, 110, 'Mumbai', 'Partner C', '2024-12-18 12:00:00', '2024-12-18 13:00:00', 50),
(11, 111, 'Delhi', 'Partner C', '2024-12-18 09:00:00', '2024-12-18 09:35:00', 30),
(12, 112, 'Hyderabad', 'Partner C', '2024-12-18 16:00:00', '2024-12-18 16:45:00', 30);

---Query

select * from swiggy_orders;

---First Method

select del_partner,sum( case when DATEDIFF(minute, order_time,deliver_time) > predicted_time then 1 else 0 end) as Delayed_Orders  from swiggy_orders
group by del_partner;

✔ Explanation

DATEDIFF(minute, order_time, deliver_time) → Actual delivery time

Check actual > predicted → delayed

SUM(CASE…) → counts total delays per partner

---Second Method

select a.del_partner,  isnull(Delayed_Orders,0) as Delayed_Orders  from
(select distinct del_partner from swiggy_orders)a left join 
(select del_partner, COUNT(*) as Delayed_Orders  from swiggy_orders
where DATEDIFF(minute, order_time,deliver_time) > predicted_time
group by del_partner) b on a.del_partner=b.del_partner ;

✔ Explanation

First, we created a distinct list of all partners.

Then we joined it with the delayed orders table.

If any partner has delay = 0, even then the record will not be missed because we used a LEFT JOIN.
