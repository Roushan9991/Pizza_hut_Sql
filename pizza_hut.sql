use pizza_hut;
-- Show the table contents 
select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;

-- Q1. Total number of orders placed
select
count(*) as 'Total Orders'
from orders;

-- Q2. Total Revenue generated from pizza sales
select
round(sum(revenue),2) as Total_revenue
from(
select
round(quantity*price,2) as revenue
from (
select
A.order_id,
A.pizza_id,
A.quantity,
B.price
from order_details A
join pizza_types B
on A.pizza_id=B.pizza_id
) C
) D;

-- Q3. Identify Highest Priced Pizza
select
pizzas.name
from pizzas
join pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
order by pizza_types.price desc
limit 1;

-- Q4. Identify the most common pizza size ordered.
select
size,
count(*) as 'Frequency of order'
from(
select
order_details.order_id,
pizza_types.size
from order_details
join pizza_types
on order_details.pizza_id=pizza_types.pizza_id
) A
group by size
order by count(*) desc;

-- Q5. Top 5 most ordered pizza types along with their quantities
with pizza_order as
(
select
order_details.order_id,
pizzas.name,
order_details.quantity
from order_details
join pizza_types
on order_details.pizza_id=pizza_types.pizza_id
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
)
select
name,
sum(quantity) 'Total Quantity Ordered'
from pizza_order
group by name
order by sum(quantity) desc
limit 5;

-- Q6. Total quantity of each pizza category ordered
select
category,
sum(quantity) as 'Total Quantity Ordered'
from (
select
pizzas.category,
order_details.quantity
from order_details
join pizza_types
on order_details.pizza_id=pizza_types.pizza_id
join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
) A
group by category
order by sum(quantity) desc;

-- Q7. Distribution of order by hour of the day
select
order_hour,
count(*) as 'Number of Orders Received'
from (
select
hour(time) as order_hour
from orders
) A
group by order_hour
order by count(*) desc;

-- Q8. Average number of pizzas ordered per day
select
orders.date,
avg(order_details.quantity) avg_quantity_ordered
from order_details
join orders
on order_details.order_id=orders.order_id
group by orders.date
order by avg_quantity_ordered desc;

-- Q9. Top 3 most ordered pizza types based on revenue
select
pizzas.name,
sum(pizza_types.price*order_details.quantity) as revenue
from order_details
join pizza_types
on order_details.pizza_id=pizza_types.pizza_id
join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
group by name
order by revenue desc
limit 3;

-- Q10. Percentage contribution of each pizza type to total revenue
with revenue as
(
select
pizzas.name,
sum(pizza_types.price*order_details.quantity) as revenue
from order_details
join pizza_types
on order_details.pizza_id=pizza_types.pizza_id
join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
group by name
order by revenue desc
) 
select 
name,
revenue,
sum(round(revenue,2)) over() as Total_revenue,
concat(round((revenue/sum(revenue) over()) *100,2),'%') as Percentage_contribution
from revenue;

-- Q11. Analyse Cumulative Revenue generated over time
with order_quantity as
(
select 
orders.date,
order_details.quantity,
pizza_types.price,
order_details.quantity*pizza_types.price as revenue
from order_details
join orders
on order_details.order_id=orders.order_id
join pizza_types
on pizza_types.pizza_id=order_details.pizza_id
order by date
), curr_revenue as
(
select
date,
round(sum(revenue),2) as current_revenue
from order_quantity
group by date
order by date
)
select
date,
current_revenue,
sum(round(current_revenue,2)) over(order by date) as cummulative_revenue
from curr_revenue;

-- Q12. Top 3 most ordered pizza types based on revenue for each category.
with pizza_details as
(
select
order_details.order_id,
pizzas.category,
pizzas.name,
order_details.quantity,
pizza_types.price,
order_details.quantity*pizza_types.price as revenue
from order_details
join pizza_types
on order_details.pizza_id=pizza_types.pizza_id
join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
), category_pizza as
(
select
category,
name,
sum(revenue) as Total_revenue,
rank() over(partition by category order by sum(revenue)) 
from pizza_details
group by category,name
), ranking as
( 
select
category,
name,
Total_revenue,
rank() over(partition by category order by Total_revenue desc) as Ranking
from category_pizza
)
select 
category,
name
from ranking
where Ranking<=3;











