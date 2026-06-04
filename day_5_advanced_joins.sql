/*
  ==============================================================================
  DAY 5: ADVANCED JOINS & MULTI-TABLE DATA ANALYTICS
  Portfolio: SQL-Practice-Portfolio
  ==============================================================================
*/

-- ==============================================================================
-- 1. ADVANCED JOINS (Anti Joins & Cross Joins)
-- ==============================================================================

-- LEFT ANTI JOIN
-- Task: Get all customers who haven't placed any order
SELECT 
    c.id, 
    c.first_name, 
    c.last_name
FROM customers AS c
LEFT JOIN orders AS o 
    ON c.id = o.customer_id
WHERE o.customer_id IS NULL;


-- RIGHT ANTI JOIN
-- Task: Get all orders without matching customers
SELECT 
    o.order_id, 
    o.sales
FROM customers AS c
RIGHT JOIN orders AS o 
    ON c.id = o.customer_id
WHERE c.id IS NULL;


-- ALTERNATIVE TO RIGHT ANTI JOIN (Using LEFT JOIN)
SELECT 
    o.order_id, 
    o.sales
FROM orders AS o
LEFT JOIN customers AS c 
    ON c.id = o.customer_id
WHERE c.id IS NULL;


-- ALTERNATIVE TO INNER JOIN (Using LEFT JOIN)
SELECT 
    c.id, 
    c.first_name, 
    o.order_id, 
    o.sales
FROM customers AS c
LEFT JOIN orders AS o 
    ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;


-- FULL ANTI JOIN
SELECT 
    c.id, 
    c.first_name, 
    o.order_id, 
    o.customer_id, 
    o.sales
FROM customers AS c
FULL JOIN orders AS o 
    ON c.id = o.customer_id
WHERE o.customer_id IS NULL 
   OR c.id IS NULL;


-- CROSS JOIN
SELECT 
    c.id, 
    c.first_name, 
    o.order_id, 
    o.sales
FROM customers AS c
CROSS JOIN orders AS o;


-- ==============================================================================
-- 2. MULTIPLE TABLE JOINS (4 Tables Complex Analysis)
-- ==============================================================================

USE SalesDB;

SELECT 
    o.OrderID, 
    o.Sales, 
    c.FirstName AS CustomerFirstName, 
    c.LastName AS CustomerLastName, 
    p.Product AS ProductName, 
    p.Price, 
    e.FirstName AS EmployeeFirstName, 
    e.LastName AS EmployeeLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c 
    ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p 
    ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e 
    ON o.SalesPersonID = e.EmployeeID;
