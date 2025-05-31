
-------------------------------------------------------------
-------------------( BikeStore Project )------------------

-- No. Serving Customer - (How many total serving customer ?)
select count(distinct customer_id) as [No. Serving Customer]
from sales.customers

-- No. Order - (How many total orders are there?)
select count(order_id) as [No. Order]
from sales.orders

-- Top 1 Store that make the highest No. Orders - (Which store has the highest number of sales ?)
select top 1 o.store_id, s.store_name, count(o.store_id) as [N. Orders] 
from sales.orders o join sales.stores s
on o.store_id=s.store_id
group by o.store_id, s.store_name
order by [N. Orders] desc 

-- Total Revenue
select cast( round( sum( quantity*list_price*(1-discount) ) , 0) as int) as [Total Revenue]
from sales.order_items

-- Expected Sales
select cast( round( sum( quantity*list_price ) , 0) as int) as [Expected Sales]
from sales.order_items



-- Top 5 Selling Product (Best Seller) (make highest number of orders)
select top 5 p.product_id, p.product_name
             ,count(i.order_id) [No. Orders] 
			 ,count(i.item_id) [No. Items] 
from production.products p join sales.order_items i 
on p.product_id=i.product_id
group by p.product_id, p.product_name 
order by [No. Orders] desc



-- Top 5 Customer by No. of Orders - (How many orders each customer has placed ?) (get top 5)
with CTE_CustomerOrders as (
    select c.customer_id, c.first_name+' '+c.last_name as [Customer Name] , count(o.order_id) as [No. Orders]
    from sales.customers c join sales.orders o 
	on c.customer_id = o.customer_id
    group by c.customer_id, c.first_name+' '+c.last_name
)
select top 5 *
from CTE_CustomerOrders
order by [No. Orders] desc;


-- Top 5 Customer by Revenue
with CTE_CustomerRevenue as (
    select c.customer_id, c.first_name+' '+c.last_name as [Customer Name] 
	, cast( round( sum( quantity*list_price*(1-discount) ) , 0) as int) as [Total Revenue]
    from sales.customers c , sales.orders o , sales.order_items i
	where c.customer_id = o.customer_id and i.order_id=o.order_id
    group by c.customer_id, c.first_name+' '+c.last_name
)
select top 5 *
from CTE_CustomerRevenue
order by [Total Revenue] desc;


-- Revenue by Category


-- Revenue by Month
-- Revenue by State

