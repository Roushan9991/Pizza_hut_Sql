# 🍕 Pizza Hut Sales Analysis - SQL Business Intelligence Project

> Solving 13 real-world business problems for Pizza Hut by querying and analyzing order data using SQL and Python (Jupyter Notebook).

---

## 📌 Project Overview

This project performs a structured business analysis on Pizza Hut's sales and order data. Using SQL queries - from basic aggregations to advanced window functions - it answers 13 business questions across three difficulty levels: Basic, Intermediate, and Advanced. The analysis is presented in a sql file (`pizza_hut.sql`).

---

## 🗂️ Repository Structure

```
Pizza_hut_Sql/
│
├── Project.ipynb       # Jupyter Notebook with all SQL queries and outputs
├── Questions.txt       # All 13 business problems (Basic → Intermediate → Advanced)
├── pizza_hut.sql       # Raw SQL queries
└── README.md
```

---

## ⚙️ Tech Stack

| Tool | Purpose |
|------|---------|
| MySQL | Database and analytical querying |
| Python (Jupyter Notebook) | Running and presenting SQL queries |
| SQL (Joins, CTEs, Window Functions) | Answering business questions |
| Pandas 

---

## ❓ Business Questions Answered

### 🟢 Basic
| # | Question |
|---|----------|
| 1 | Retrieve the total number of orders placed |
| 2 | Calculate the total revenue generated from pizza sales |
| 3 | Identify the highest-priced pizza |
| 4 | Identify the most common pizza size ordered |
| 5 | List the top 5 most ordered pizza types along with their quantities |

### 🟡 Intermediate
| # | Question |
|---|----------|
| 6 | Find the total quantity of each pizza category ordered (via table joins) |
| 7 | Determine the distribution of orders by hour of the day |
| 8 | Find the category-wise distribution of pizzas |
| 9 | Calculate the average number of pizzas ordered per day |
| 10 | Determine the top 3 most ordered pizza types based on revenue |

### 🔴 Advanced
| # | Question |
|---|----------|
| 11 | Calculate the percentage contribution of each pizza type to total revenue |
| 12 | Analyze the cumulative revenue generated over time |
| 13 | Determine the top 3 most ordered pizza types based on revenue for each pizza category |

---

## 💡 Sample Query - Cumulative Revenue Over Time

```sql
SELECT
    order_date,
    SUM(revenue) OVER (ORDER BY order_date) AS cumulative_revenue
FROM (
    SELECT
        orders.order_date,
        SUM(order_details.quantity * pizzas.price) AS revenue
    FROM order_details
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    JOIN orders ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS daily_revenue;
```

---

## 🚀 Getting Started

### Prerequisites
- Python 3.8+
- MySQL Server
- Jupyter Notebook

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/Roushan9991/Pizza_hut_Sql.git
cd Pizza_hut_Sql

# 2. Install Python dependencies
pip install jupyter pandas sqlalchemy pymysql ipython-sql

# 3. Set up MySQL database and import pizza_hut.sql
mysql -u root -p < pizza_hut.sql

# 4. Launch Jupyter Notebook
jupyter notebook Project.ipynb
```

---

## 📊 Key Insights

- Identified best-selling pizza types and sizes to support menu optimization
- Hourly order distribution reveals peak business hours for staffing decisions
- Revenue contribution analysis highlights which pizzas drive the most profit
- Cumulative revenue trend helps track business growth over time
- Category-wise top performers support targeted promotions and inventory planning

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 👤 Author

**Roushan9991**
[GitHub Profile](https://github.com/Roushan9991)
