
SELECT ab.[Product ID], ab.before, cd.after
FROM (SELECT  b.[Product ID], (CASE WHEN a.number is null THEN '0'else a.number END) as before
FROM (select p.[Product ID],sum(o.Quantity) as [number]
from Fact_Orders_Items as o RIGHT join DIM_Products as p on o.DW_Product_ID=p.DW_Product_ID
where year(o.[Order Date])<'2020'
group by p.[Product ID]) as [a]
RIGHT join DIM_Products as b on a.[Product ID]=b.[Product ID]) as ab join
(SELECT  b.[Product ID], (CASE WHEN a.number is null THEN '0'else a.number END) as after
FROM (select p.[Product ID],sum(o.Quantity) as [number]
from Fact_Orders_Items as o RIGHT join DIM_Products as p on o.DW_Product_ID=p.DW_Product_ID
where year(o.[Order Date])>='2020'
group by p.[Product ID]) as [a]
RIGHT join DIM_Products as b on a.[Product ID]=b.[Product ID]) as cd on ab.[Product ID]=cd.[Product ID]
