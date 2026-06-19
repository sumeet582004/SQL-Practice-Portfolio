/* ==============================================================================
   SQL Views
-------------------------------------------------------------------------------
   This script demonstrates various view use cases in SQL Server.
   It includes examples for creating, dropping, and modifying views, hiding
   query complexity, and implementing data security by controlling data access.

   Table of Contents:
     1. Create, Drop, Modify View
     2. USE CASE - HIDE COMPLEXITY
     3. USE CASE - DATA SECURITY
===============================================================================
*/

/* ==============================================================================
   CREATE, DROP, MODIFY VIEW
===============================================================================*/

/* TASK:
   Create a view that summarizes monthly sales by aggregating:
     - OrderMonth (truncated to month)
     - TotalSales, TotalOrders, and TotalQuantities.
*/

-- Create View
with cte_monthly_salry as 
(
select 
date_format(orderdate,'%y-%m-01') as ordermonth,
sum(sales) as totalsales,
count(orderid) as totalorders,
sum(quantity) as totalquantity
from orders
group by date_format(orderdate,'%y-%m-01')
)
select
ordermonth,
totalsales,
sum(totalsales) over( order by ordermonth) as runningtotal
from cte_monthly_salry ;



-- Query the View
select * from v_monthly_salry;

-- Drop View if it exists
 drop view if exists v_monthly_summury;
 
-- Re-create the view with modified logic

CREATE VIEW V_Monthly_Summary AS
SELECT 
    DATETRUNC(month, OrderDate) AS OrderMonth,
    SUM(Sales) AS TotalSales,
    COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY DATETRUNC(month, OrderDate);


/* ==============================================================================
   VIEW USE CASE | HIDE COMPLEXITY
===============================================================================*/

/* TASK:
   Create a view that combines details from Orders, Products, Customers, and Employees.
   This view abstracts the complexity of multiple table joins.
*/
create view v_order_detailes as
(
select 
o.orderid,
o.orderdate,
p.category,
coalesce(concat(coalesce (c.firstname,''), '', coalesce (c.lastname),''),'') as customername,
coalesce(concat(coalesce (e.firstname,''), '', coalesce (e.lastname),''),'') as employeename,
e.department,
o.sales,
o.quantity
from orders as o
left join products as p
on o.productid = p.productid
left join customers as c
on o.customerid = c.customerid
left join employees as e
on o.salespersonid = e.employeeid
);


/* ==============================================================================
   VIEW USE CASE | DATA SECURITY
===============================================================================*/

/* TASK:
   Create a view for the EU Sales Team that combines details from all tables,
   but excludes data related to the USA.
*/
CREATE VIEW V_Order_Details_EU AS
(
    SELECT 
        o.OrderID,
        o.OrderDate,
        p.Product,
        p.Category,
        COALESCE(c.FirstName, '') + ' ' + COALESCE(c.LastName, '') AS CustomerName,
        c.Country AS CustomerCountry,
        COALESCE(e.FirstName, '') + ' ' + COALESCE(e.LastName, '') AS SalesName,
        e.Department,
        o.Sales,
        o.Quantity
    FROM Orders AS o
    LEFT JOIN Products AS p ON p.ProductID = o.ProductID
    LEFT JOIN Customers AS c ON c.CustomerID = o.CustomerID
    LEFT JOIN Employees AS e ON e.EmployeeID = o.SalesPersonID
    WHERE c.Country != 'USA'
);
