/* ==============================================================================
   SQL Date & Time Functions (MySQL Version)
   -------------------------------------------------------------------------------
   This script demonstrates various date and time functions in MySQL.
   It covers replacements for T-SQL functions like GETDATE, DATETRUNC, 
   DATENAME, DATEPART, YEAR, MONTH, DAY, EOMONTH, FORMAT, CAST, DATEADD, and DATEDIFF.

   Table of Contents:
   1. Current Date & Time (Replacement for GETDATE)
   2. Date Part Extractions (Replacement for DATETRUNC, DATENAME, DATEPART, YEAR, MONTH, DAY)
   3. DATE_FORMAT / STR_TO_DATE (Replacement for FORMAT / CONVERT)
   4. CAST
   5. DATE_ADD / DATEDIFF
   =============================================================================== */

/* ==============================================================================
   1. CURRENT DATE & TIME | DATE VALUES
   ===============================================================================*/
/* TASK 1: Display OrderID, CreationTime, a hard-coded date, and the current system date. */
SELECT 
    OrderID, 
    CreationTime, 
    '2025-08-20' AS HardCoded, 
    NOW() AS Today -- MySQL alternative for GETDATE()
FROM Sales.Orders;

/* ==============================================================================
   2. DATE PART EXTRACTIONS 
   ===============================================================================*/
/* TASK 2: Extract various parts of CreationTime using MySQL equivalent functions. */
SELECT 
    OrderID, 
    CreationTime,
    
    -- 2.1 DATETRUNC Alternatives (Truncating to specific parts)
    DATE_FORMAT(CreationTime, '%Y-01-01 00:00:00') AS Year_dt,    -- Truncate to Year
    DATE(CreationTime) AS Day_dt,                                 -- Truncate to Day
    DATE_FORMAT(CreationTime, '%Y-%m-%d %H:%i:00') AS Minute_dt,  -- Truncate to Minute
    
    -- 2.2 DATENAME Alternatives (Returns string names)
    DATE_FORMAT(CreationTime, '%M') AS Month_dn,       -- Full Month Name (e.g., January)
    DATE_FORMAT(CreationTime, '%W') AS Weekday_dn,     -- Full Weekday Name (e.g., Sunday)
    DATE_FORMAT(CreationTime, '%e') AS Day_dn,         -- Day of month as string
    DATE_FORMAT(CreationTime, '%Y') AS Year_dn,        -- Year as string
    
    -- 2.3 DATEPART Alternatives (Returns numeric values)
    EXTRACT(YEAR FROM CreationTime) AS Year_dp,
    EXTRACT(MONTH FROM CreationTime) AS Month_dp,
    EXTRACT(DAY FROM CreationTime) AS Day_dp,
    EXTRACT(HOUR FROM CreationTime) AS Hour_dp,
    QUARTER(CreationTime) AS Quarter_dp,
    WEEK(CreationTime) AS Week_dp,
    
    -- 2.4 Standard Numeric Functions (Same as SQL Server)
    YEAR(CreationTime) AS Year,
    MONTH(CreationTime) AS Month,
    DAY(CreationTime) AS Day
FROM Sales.Orders;

/* ==============================================================================
   3. LAST DAY OF THE MONTH (EOMONTH Alternative)
   ===============================================================================*/
/* MySQL uses LAST_DAY() instead of EOMONTH() */
SELECT 
    OrderID, 
    CreationTime,
    LAST_DAY(CreationTime) AS EndOfMonth
FROM Sales.Orders;

/* ==============================================================================
   4. BONUS: DATE_ADD & DATEDIFF Quick Reference
   ===============================================================================*/
/* - SQL Server: DATEADD(day, 5, CreationTime) 
   - MySQL:      DATE_ADD(CreationTime, INTERVAL 5 DAY)
   
   - SQL Server: DATEDIFF(day, StartDate, EndDate)
   - MySQL:      DATEDIFF(EndDate, StartDate) -- Note: MySQL only returns difference in DAYS
*/
