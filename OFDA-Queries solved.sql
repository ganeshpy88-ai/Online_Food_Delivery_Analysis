create database OFDA;
use OFDA;
select * from final_cleaned_food_delivery_data;

# Customer & Order Analysis
# 1.	Identify top-spending customers
SELECT Customer_ID, ROUND(SUM(Final_Amount), 2) as Total_Spent
FROM final_cleaned_food_delivery_data
GROUP BY Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10;
#2. Analyze age group vs order value (Uses cleaned Customer_Age)
SELECT 
    CASE 
        WHEN Customer_Age < 20 THEN 'Under 20'
        WHEN Customer_Age BETWEEN 20 AND 35 THEN '20-35'
        WHEN Customer_Age BETWEEN 36 AND 50 THEN '36-50'
        ELSE 'Above 50' 
    END AS Age_Group,
    ROUND(AVG(Order_Value), 2) as Avg_Order_Value
FROM final_cleaned_food_delivery_data
GROUP BY Age_Group
ORDER BY 
    CASE 
        WHEN Age_Group = 'Under 20' THEN 1
        WHEN Age_Group = '20-35' THEN 2
        WHEN Age_Group = '36-50' THEN 3
        WHEN Age_Group = 'Above 50' THEN 4
    END ASC;
   # 3. Weekend vs weekday order patterns
 SELECT 
    Order_Day AS Day_Type,
    COUNT(Order_ID) AS Total_Orders
FROM final_cleaned_food_delivery_data
GROUP BY Order_Day
ORDER BY Total_Orders DESC;

# Revenue & Profit Analysis
# 4.	Monthly revenue trends
SELECT 
    DATE_FORMAT(STR_TO_DATE(Order_Date, '%d-%m-%Y'), '%Y-%m') AS Month, 
    ROUND(SUM(Final_Amount), 2) AS Monthly_Revenue
FROM final_cleaned_food_delivery_data
WHERE STR_TO_DATE(Order_Date, '%d-%m-%Y') IS NOT NULL
GROUP BY Month
ORDER BY Monthly_Revenue desc;
# 5.	Impact of discounts on profit
SELECT 
    CASE WHEN Discount_Applied > 0 THEN 'Discounted' ELSE 'No Discount' END AS Promotion_Status, 
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Final_Amount), 2) AS Total_Revenue,
    ROUND(AVG(Profit_Margin), 2) AS Avg_Profit
FROM final_cleaned_food_delivery_data
GROUP BY Promotion_Status;
# 6.	High-revenue cities and cuisines
SELECT City, Cuisine_Type, format(SUM(Final_Amount),0) AS Total_Revenue
FROM final_cleaned_food_delivery_data
WHERE City IS NOT NULL AND Cuisine_Type IS NOT NULL
GROUP BY City, Cuisine_Type
ORDER BY Total_Revenue DESC
LIMIT 10;

#Part-C:  Delivery Performance
#7.	Average delivery time by city
SELECT City, ROUND(AVG(Delivery_Time_Min), 2) AS Avg_Delivery_Time
FROM final_cleaned_food_delivery_data
WHERE City IS NOT NULL
GROUP BY City
ORDER BY Avg_Delivery_Time ASC;

# 8.Distance vs delivery delay analysis
SELECT Distance_km, round(AVG(Delivery_Time_Min), 2) AS Avg_Time
FROM final_cleaned_food_delivery_data
WHERE Distance_km IS NOT NULL
GROUP BY Distance_km
ORDER BY Distance_km ASC;

#9.	Delivery rating vs delivery time
SELECT Delivery_Rating, ROUND(AVG(Delivery_Time_Min), 2) AS Avg_Time
FROM final_cleaned_food_delivery_data
WHERE Delivery_Rating IS NOT NULL
GROUP BY Delivery_Rating
ORDER BY Delivery_Rating DESC;

#Part-D: Restaurant Performance
#10.	Top-rated restaurants
SELECT Restaurant_Name, ROUND(AVG(Restaurant_Rating), 2) AS Avg_Rating
FROM final_cleaned_food_delivery_data
GROUP BY Restaurant_Name
HAVING COUNT(Order_ID) > 10
ORDER BY Avg_Rating DESC
limit 10;

#11.	Cancellation rate by restaurant
SELECT Restaurant_Name, 
ROUND((SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS Cancel_Rate_Percent
FROM final_cleaned_food_delivery_data
GROUP BY Restaurant_Name
ORDER BY Cancel_Rate_Percent DESC
LIMIT 10;
      
#12.	Cuisine-wise performance
SELECT Cuisine_Type, COUNT(Order_ID) AS Order_Count, ROUND(SUM(Final_Amount), 2) AS Revenue
FROM final_cleaned_food_delivery_data
WHERE Cuisine_Type IS NOT NULL
GROUP BY Cuisine_Type
ORDER BY Revenue DESC;

#Part-E: Operational Insights
#13.	Peak hour demand analysis
SELECT Peak_Hour, COUNT(Order_ID) AS Order_Volume
FROM final_cleaned_food_delivery_data
WHERE Peak_Hour IS NOT NULL
GROUP BY Peak_Hour
ORDER BY CAST(Peak_Hour AS UNSIGNED) ASC;

#14.	Payment mode preferences
SELECT Payment_Mode, COUNT(Order_ID) AS Usage_Count
FROM final_cleaned_food_delivery_data
WHERE Payment_Mode IS NOT NULL
GROUP BY Payment_Mode
ORDER BY Usage_Count DESC;

#15.	Cancellation reason analysis
SELECT 
    Cancellation_Reason, 
    COUNT(Order_ID) AS Reason_Frequency,
    ROUND(SUM(Order_Value), 2) AS Total_Revenue_Lost
FROM final_cleaned_food_delivery_data
WHERE Cancellation_Reason IS NOT NULL AND Cancellation_Reason != 'None'
GROUP BY Cancellation_Reason
ORDER BY Total_Revenue_Lost DESC;




    