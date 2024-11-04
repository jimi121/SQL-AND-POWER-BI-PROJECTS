--SET SEARCH PATH FOR QUERIES
SET search_path = "Route Optimization for Food Delivery";

-- Check the structure of the CustomerOrders table
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'customer_orders';

-- Check the structure of the drivers table
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'drivers';

-- Check the structure of the restaurants table
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'restaurants';

-- Check the structure of the traffic_data table
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'traffic_data';

SELECT * FROM customer_orders co ;
SELECT * FROM drivers d;
SELECT * FROM restaurants r; 
SELECT * FROM traffic_data td;

-- 1. Identify Orders with Long Delivery Times
SELECT 
    OrderID, 
    CustomerID, 
    DriverID, 
    RestaurantID, 
    Timetakentodeliver, 
    DeliveryAddress, 
    DistanceKM, 
    TrafficDensity
FROM 
    customer_orders CO
JOIN 
    traffic_data TD ON CO.LocationID = TD.LocationID
WHERE 
    Timetakentodeliver > '00:30:00'
ORDER BY 
    Timetakentodeliver DESC
LIMIT 10;
    
   -- 2. Average Delivery Time per Location
SELECT 
    LocationName, 
    AVG(Timetakentodeliver)::time AS AvgDeliveryTime
FROM 
    customer_orders CO
JOIN 
    traffic_data TD ON CO.LocationID = TD.LocationID
WHERE 
	CO.orderstatus = 'Delivered'
GROUP BY 
    LocationName
ORDER BY 
    AvgDeliveryTime DESC;
    
 -- 3. Analyze Driver Workload by Shift
SELECT 
    DriverID, 
    COUNT(OrderID) AS TotalDeliveries, 
    round(EXTRACT(EPOCH FROM (MAX(DeliveryTime) - MIN(OrderTimestamp)))/3600,2) AS TotalShiftHours
FROM 
    customer_orders
GROUP BY 
    DriverID
ORDER BY 
    TotalDeliveries DESC;
    
-- 4. Identify High-Traffic Areas
SELECT 
    LocationName, 
    AVG(TrafficDensity) AS AvgTrafficDensity
FROM 
    traffic_data
GROUP BY 
    LocationName
ORDER BY 
    AvgTrafficDensity DESC;
    
-- 5. Calculate Average Distance Per Delivery
 SELECT 
    DriverID, 
    AVG(DistanceKM) AS AvgDistanceKM
FROM 
    customer_orders
GROUP BY 
    DriverID
ORDER BY 
    AvgDistanceKM DESC;
    
-- 6. Compare Actual vs. Estimated Delivery Times
SELECT 
    OrderID, 
    round(EXTRACT(EPOCH FROM (DeliveryTime::timestamp - OrderTimestamp::timestamp))/3600,2) AS ActualDeliveryTimeHrs, 
    round(EXTRACT(EPOCH FROM Timetakentodeliver)/3600,2) AS EstimatedTimeHrs
FROM 
    customer_orders
WHERE 
    ABS(EXTRACT(EPOCH FROM (DeliveryTime::timestamp - OrderTimestamp::timestamp))/3600 - EXTRACT(EPOCH FROM Timetakentodeliver)/3600) > 0.5;
    
-- 7. Analyze Total Orders per Driver
SELECT 
    DriverID, 
    COUNT(OrderID) AS TotalOrders
FROM 
    customer_orders
GROUP BY 
    DriverID
ORDER BY 
    TotalOrders DESC;
    
-- 8. Track Driver Shifts and Active Hours
SELECT 
    DriverID, 
    ShiftStart, 
    ShiftEnd, 
    EXTRACT(EPOCH FROM (ShiftEnd - ShiftStart))/3600 AS ShiftDuration
FROM 
    Drivers;
    
-- 9. Identify Delayed Orders (Delivery Time > 15 minutes)
SELECT 
    OrderID, 
    EXTRACT(EPOCH FROM (DeliveryTime - OrderTimestamp))/60 AS DeliveryMinutes
FROM 
    customer_orders
WHERE 
    EXTRACT(EPOCH FROM (DeliveryTime - OrderTimestamp))/60 > 15;
    
-- 10. Analyze Restaurant Performance (Average Delivery Time per Restaurant)
   SELECT 
    RestaurantID, 
    AVG(Timetakentodeliver)::time AS AvgDeliveryTime
FROM 
    customer_orders
GROUP BY 
    RestaurantID
ORDER BY 
    AvgDeliveryTime DESC;
    
 -- 11. Identify Orders with High Traffic at Delivery Time
SELECT 
    OrderID, 
    LocationName, 
    TrafficDensity, 
    Timetakentodeliver
FROM 
    customer_orders CO
JOIN 
    traffic_data TD ON CO.LocationID = TD.LocationID
WHERE 
    TrafficDensity > 100 -- Traffic is above threshold
AND 
	CO.orderstatus = 'Delivered'
ORDER BY 
    TrafficDensity DESC;
    
-- 12. Driver Performance by Average Delivery Time
SELECT 
    DriverID, 
    AVG(EXTRACT(EPOCH FROM (DeliveryTime::timestamp - OrderTimestamp::timestamp))/3600) AS AvgDeliveryTimeHrs,
    COUNT(OrderID) AS TotalDeliveries
FROM 
    customer_orders
GROUP BY 
    DriverID
ORDER BY 
    AvgDeliveryTimeHrs DESC;
    
 -- 13. Top 5 Restaurants with Most Orders
SELECT 
    RestaurantID, 
    COUNT(OrderID) AS TotalOrders
FROM 
    customer_orders
GROUP BY 
    RestaurantID
ORDER BY 
    TotalOrders DESC
LIMIT 5;

-- 14. Identify Orders Placed During Peak Hours (e.g., 6 PM - 9 PM)
SELECT 
    OrderID, 
    EXTRACT(HOUR FROM OrderTimestamp) AS OrderHour, 
    Timetakentodeliver
FROM 
    customer_orders
WHERE 
    EXTRACT(HOUR FROM OrderTimestamp) BETWEEN 18 AND 21
AND 
	OrderStatus = 'Delivered'
ORDER BY 
    Timetakentodeliver DESC;
    
-- 15. Calculate Average Delivery Time by Day of the Week
SELECT 
    TO_CHAR(OrderTimestamp, 'Day') AS DayOfWeek, 
    AVG(EXTRACT(EPOCH FROM (DeliveryTime::timestamp - OrderTimestamp::timestamp))/3600) AS AvgDeliveryTimeHrs
FROM 
    customer_orders
GROUP BY 
    TO_CHAR(OrderTimestamp, 'Day')
ORDER BY 
    AvgDeliveryTimeHrs DESC;