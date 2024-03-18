
create database assignment2

use assignment2


create table JomatoData
(
OrderId INTEGER
,RestaurantName VARCHAR(200)
,RestaurantType VARCHAR(200)
,Rating FLOAT
,No_of_Rating INTEGER
,AverageCost FLOAT
,OnlineOrder VARCHAR(200)
,TableBooking VARCHAR(200)
,CuisinesType VARCHAR(200)
,Area VARCHAR(200)
,LocalAddress VARCHAR(200)
,"Delivery time" INTEGER
)






SELECT * FROM JomatoData


bulk insert dbo.JomatoData

from "C:\Program Files\Microsoft SQL Server\MSSQL16.DEEPAKTIWARY\MSSQL\DATA\JomatoData.csv"
with 
(
  FORMAT = 'CSV',
  FIRSTROW = 2

  )
go


--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.

CREATE OR ALTER FUNCTION stuff_chicken_into_quick_bites()
RETURNS table
AS
return

SELECT *,

CASE
 WHEN RestaurantType = 'Quick Bites'
 THEN 'Quick Chicken Bites'
 ELSE RestaurantType
END AS RestaurantTypeModified
FROM JomatoData 

--2. Use the function to display the restaurant name and cuisine type which has the maximum number of rating.


select RestaurantName, CuisinesType from dbo.stuff_chicken_into_quick_bites()
where No_of_Rating in (select max(No_of_rating) from JomatoData)

--3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4 start rating, ‘Good’
-- if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3 and below 3.5 and ‘Bad’ if it is below 3 star rating.

select *, 
   case when Rating >=4 THEN 'Excellent'
        WHEN Rating between 3.5 and 4 then 'Good'
		when Rating between 3 and 3.5 then 'Average'
		when rating < 3 then 'Bad'

	End as "Rating Status"
	From JomatoData



--4. Find the Ceil, floor and absolute values of the rating column and display the current date and separately display the year, month_name and day.

select CEILING(Rating) as CeilingValue
, FLOOR(rating) as FloorValue
, ABS(rating) as AbsoluteValue
from JomatoData;

select year(CURRENT_TIMESTAMP) as YearOfCurrentDate
, month(current_timestamp) as Month_name
, day(current_timestamp) as DayOfCurrentDate

-- 5. Display the restaurant type and total average cost using rollup.select RestaurantType, sum(AverageCost) as TotalAverageCostfrom JomatoDatagroup by rollup(RestaurantType)