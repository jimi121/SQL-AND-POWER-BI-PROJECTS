## 1. Identify Orders with Long Delivery Times
Purpose: This query retrieves orders where the delivery time exceeds 30 minutes. By analyzing these orders, UrbanEats can identify problematic deliveries and potentially adjust routes or address issues causing delays.
```sql
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
```
### Result:
|orderid|customerid|driverid|restaurantid|timetakentodeliver|deliveryaddress                                          |distancekm |trafficdensity|
|-------|----------|--------|------------|------------------|---------------------------------------------------------|-----------|--------------|
|992    |276       |26      |8           |00:59:33          |947 Flores Terrace Apt. 851¶New Williamhaven, WA 07792   |1.173369813|56.95         |
|91     |397       |15      |9           |00:59:31          |67874 Henry Cape¶North Randy, MO 39380                   |7.277036142|23.5          |
|185    |100       |15      |7           |00:59:15          |4871 Karen Common¶West Charlesshire, VA 91763            |0.89789984 |69            |
|897    |368       |44      |17          |00:59:13          |74380 Newman Bypass Suite 083¶New Katrinaside, AS 06690  |7.935584088|10.45         |
|424    |168       |45      |20          |00:59:00          |149 Margaret Unions Apt. 748¶Medinamouth, MA 20471       |0.925000309|31.23         |
|525    |142       |46      |2           |00:58:56          |85128 Houston Courts Suite 052¶Derekstad, PA 36224       |8.979501322|72.04         |
|850    |466       |30      |17          |00:58:50          |4116 Daniel Club Suite 750¶North Alexandramouth, RI 94563|4.18289585 |193.74        |
|693    |382       |35      |14          |00:58:36          |587 William Loop Suite 358¶Michellefort, VA 52037        |6.699949075|193.23        |
|219    |415       |1       |9           |00:58:24          |7545 William Lodge Suite 245¶Lake Jenniferstad, WY 33390 |9.062147353|193.23        |
|345    |165       |42      |9           |00:58:07          |PSC 1685, Box 7704¶APO AA 53941                          |3.327728022|188.02        |

## Insight:
The results indicate that several orders are taking longer than 58 minutes to deliver, with the longest delivery time approaching one hour. This suggests inefficiencies in routing or traffic issues, especially with high traffic density in some areas.

To improve delivery times, UrbanEats should consider implementing real-time traffic-based routing solutions. Additionally, analyzing delivery patterns could help identify and address high-traffic locations to enhance overall efficiency.

## 2. Average Delivery Time per Location
Purpose: This query calculates the average delivery time for each location based on delivered orders. Understanding delivery times by location helps pinpoint areas needing improvements, whether due to traffic congestion, route inefficiencies, or other factors.

```sql
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
```

### Results: 
|locationname        |avgdeliverytime|
|--------------------|---------------|
|Port Ashley         |00:57:20       |
|South Patrick       |00:51:14       |
|South Anthonyhaven  |00:50:51       |
|Simpsonshire        |00:50:39       |
|Pageport            |00:48:28       |
|Cookland            |00:46:50       |
|Jeanetteberg        |00:46:08       |
|Crawfordchester     |00:45:58       |
|Seanview            |00:45:54       |
|New Ericville       |00:44:29       |
|Evansland           |00:44:06       |
|Aaronchester        |00:43:54       |
|Port Mitchell       |00:43:52       |
|Fuenteshaven        |00:43:48       |
|Watsonview          |00:43:35       |
|Kingbury            |00:41:06       |
|Lake Mary           |00:40:51       |
|Mathewsborough      |00:40:20       |
|Theodoreberg        |00:40:17       |
|Underwoodshire      |00:38:29       |
|South Benjamin      |00:37:07       |
|Wileyberg           |00:37:04       |
|Adamsbury           |00:37:03       |
|Lorrainefurt        |00:36:45       |
|Gonzalesberg        |00:36:38       |
|Nguyenton           |00:35:38       |
|Martinberg          |00:35:36       |
|South Sandra        |00:35:19       |
|Jeffreyberg         |00:35:09       |
|Yangview            |00:34:59       |
|Watkinsshire        |00:34:29       |
|Ramirezstad         |00:34:28       |
|Stephanieport       |00:34:21       |
|North Marystad      |00:33:40       |
|Ashleybury          |00:33:36       |
|New Jeremy          |00:33:22       |
|West Samuel         |00:33:13       |
|Vincentfurt         |00:33:02       |
|East Georgeside     |00:32:59       |
|Comptonland         |00:32:54       |
|East Anthonyton     |00:32:42       |
|Wilsonville         |00:31:45       |
|Mistyland           |00:31:42       |
|Carrieland          |00:31:38       |
|Garciatown          |00:31:23       |
|New Emilyborough    |00:30:58       |
|North Juliemouth    |00:30:25       |
|Lake Christopherstad|00:30:13       |
|Anthonyshire        |00:30:13       |
|Michaelburgh        |00:29:29       |
|New David           |00:29:19       |
|North Janicechester |00:28:51       |
|East Lesliefurt     |00:28:43       |
|West Dillonmouth    |00:28:40       |
|Port Sheilaport     |00:28:36       |
|West Paul           |00:28:22       |
|Davisborough        |00:27:21       |
|South David         |00:27:16       |
|New Ashlee          |00:26:52       |
|Pattersonville      |00:26:25       |
|Newmanhaven         |00:26:17       |
|Kristyburgh         |00:25:42       |
|Lake Teresa         |00:25:40       |
|East Erinchester    |00:25:39       |
|Patriciashire       |00:25:12       |
|Penatown            |00:25:03       |
|Brendafort          |00:24:41       |
|Hollandshire        |00:23:28       |
|Youngville          |00:23:07       |
|Whiteshire          |00:22:08       |
|New Melissaville    |00:21:48       |
|East Anna           |00:21:40       |
|West Alexanderland  |00:21:21       |
|New Lisaland        |00:20:41       |
|Lake Chadbury       |00:20:30       |
|Josephchester       |00:20:15       |
|Deborahburgh        |00:18:18       |
|Breannamouth        |00:17:24       |
|Nancychester        |00:17:12       |
|Jenniferview        |00:16:52       |
|Lake Alisonshire    |00:16:15       |
|Travismouth         |00:16:12       |
|West Mary           |00:16:11       |
|West Jason          |00:16:02       |
|New Daniel          |00:15:52       |
|Bobbyton            |00:15:14       |
|Jeffreyburgh        |00:15:01       |
|Franciscoborough    |00:13:44       |
|East Michellehaven  |00:12:06       |
|Lake Joseph         |00:10:30       |
|Gonzalezville       |00:10:10       |
|West Katie          |00:08:11       |
|Coopershire         |00:03:37       |
|Parsonsberg         |00:01:09       |
|Wangfort            |00:00:57       |

## Insight:
The average delivery times highlight that Port Ashley has the longest average at 57 minutes and 20 seconds, indicating inefficiencies, while Wangfort boasts a swift 57 seconds.

To improve efficiency, UrbanEats should target areas like Port Ashley for better routing strategies and allocate more drivers during peak times. Additionally, clear communication with customers about delivery times in slower areas can enhance satisfaction.

## 3. Analyze Driver Workload by Shift
Purpose: This query assesses the workload of each driver by counting their total deliveries and calculating the hours worked during their shifts. It helps identify if certain drivers are overloaded, which could impact service quality and driver satisfaction.

```sql
 -- 3. Analyze Driver Workload by Shift
SELECT 
    DriverID, 
    COUNT(OrderID) AS TotalDeliveries, 
    ROUND(EXTRACT(EPOCH FROM (MAX(DeliveryTime) - MIN(OrderTimestamp)))/3600,2) AS TotalShiftHours
FROM 
    customer_orders
GROUP BY 
    DriverID
ORDER BY 
    TotalDeliveries DESC;
```

### Results:
|driverid|totaldeliveries|totalshifthours|
|--------|---------------|---------------|
|30      |36             |589.28         |
|48      |29             |599.72         |
|5       |28             |548.38         |
|15      |28             |645.58         |
|37      |26             |695.35         |
|23      |25             |563.42         |
|29      |25             |625.08         |
|28      |25             |517.42         |
|44      |25             |659.32         |
|25      |24             |413.32         |
|31      |23             |483.3          |
|14      |23             |658.12         |
|17      |23             |605.57         |
|6       |23             |539.7          |
|33      |23             |643.9          |
|39      |22             |684.87         |
|43      |22             |585.85         |
|19      |22             |542.78         |
|27      |22             |572.17         |
|42      |21             |299.1          |
|4       |21             |462.02         |
|9       |21             |696.52         |
|35      |21             |533.78         |
|11      |20             |594.27         |
|10      |20             |631.8          |
|18      |20             |655.67         |
|26      |19             |669.22         |
|1       |19             |479.32         |
|47      |19             |627.43         |
|16      |19             |594.93         |
|22      |18             |537.13         |
|13      |18             |641.9          |
|8       |18             |686.33         |
|3       |18             |648.4          |
|45      |18             |513.32         |
|36      |18             |569.77         |
|7       |17             |623.07         |
|21      |17             |567.62         |
|38      |17             |623.07         |
|24      |16             |463.15         |
|41      |16             |571.22         |
|40      |16             |666.77         |
|50      |16             |670.75         |
|49      |15             |573.87         |
|12      |15             |700.9          |
|32      |13             |631.07         |
|34      |11             |629.32         |
|2       |11             |628.42         |
|20      |10             |606.82         |
|46      |8              |410.85         |

## Insight:
Some drivers, such as Driver 30 and Driver 48, have completed a similar number of deliveries (36 and 29, respectively) but have worked nearly the same or more shift hours. For example, Driver 48 worked almost 600 hours for 29 deliveries, while Driver 30 worked slightly fewer hours for more deliveries. This indicates an inconsistency in productivity, possibly due to route inefficiencies or delays for certain drivers.

UrbanEats should investigate driver performance by analyzing the factors contributing to such disparities. Providing better route optimization tools and monitoring for potential delays caused by traffic or inefficient routes will help balance delivery loads, improving both productivity and driver satisfaction.

## 4. Identify High-Traffic Areas
Purpose: This query identifies urban locations with the highest average traffic density. Understanding traffic patterns can aid in route optimization and planning to avoid congested areas during peak delivery times.

```sql
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
```

### Results:
|locationname        |avgtrafficdensity|
|--------------------|-----------------|
|South Anthonyhaven  |194.22           |
|Seanview            |193.74           |
|South Sandra        |193.23           |
|Anthonyshire        |192.11           |
|New Emilyborough    |188.02           |
|Simpsonshire        |185.27           |
|Jenniferview        |180.17           |
|New Melissaville    |176.95           |
|Wangfort            |167.35           |
|New David           |166.08           |
|Brendafort          |164.32           |
|Port Sheilaport     |163.95           |
|Underwoodshire      |163.09           |
|Mathewsborough      |162              |
|Pageport            |159.08           |
|Lake Mary           |158.36           |
|Deborahburgh        |155.52           |
|Bobbyton            |152.3            |
|Ramirezstad         |151.2            |
|Josephchester       |150.81           |
|Jeffreyberg         |90.1             |
|Nancychester        |79.31            |
|Wileyberg           |78.63            |
|Watkinsshire        |78.55            |
|Mistyland           |78.09            |
|Moodymouth          |76.87            |
|Kingbury            |76.5             |
|Youngville          |75.98            |
|Davisborough        |75.92            |
|Comptonland         |75.16            |
|Aaronchester        |74.37            |
|Michaelburgh        |73.65            |
|Parsonsberg         |73.37            |
|Lorrainefurt        |72.04            |
|Bakermouth          |70.57            |
|South Patrick       |69               |
|Jeanetteberg        |68.6             |
|East Georgeside     |65.65            |
|Lake Christopherstad|65.59            |
|East Paultown       |65.36            |
|Ashleybury          |65.04            |
|West Paul           |64.9             |
|Lake Teresa         |61.22            |
|Breannamouth        |59.93            |
|New Jeremy          |57.38            |
|West Samuel         |56.95            |
|Vincentfurt         |54.68            |
|Cookland            |52.75            |
|North Marystad      |52.19            |
|East Erinchester    |52.06            |
|East Michellehaven  |51.37            |
|Martinberg          |49.74            |
|West Mary           |49.12            |
|Port Ashley         |48.37            |
|Yangview            |47.65            |
|Travismouth         |45               |
|Newmanhaven         |44.68            |
|South Benjamin      |43.57            |
|New Daniel          |42.33            |
|Franciscoborough    |41.08            |
|Kristyburgh         |39.23            |
|Nguyenton           |39.12            |
|West Dillonmouth    |38.48            |
|Watsonview          |38.05            |
|East Anna           |37.17            |
|Hollandshire        |37.01            |
|Theodoreberg        |36.96            |
|Patriciashire       |35.5             |
|Gonzalezville       |35.02            |
|Port Mitchell       |34.92            |
|East Anthonyton     |34.46            |
|Garciatown          |33.82            |
|West Alexanderland  |32.59            |
|Pattersonville      |31.85            |
|New Lisaland        |31.6             |
|Crawfordchester     |31.23            |
|Carrieland          |30.72            |
|Whiteshire          |30.59            |
|East Lesliefurt     |29.32            |
|Lake Alisonshire    |28.82            |
|Wilsonville         |27.79            |
|North Juliemouth    |27.03            |
|Lake Joseph         |26.79            |
|Lake Chadbury       |25.83            |
|Evansland           |23.89            |
|Fuenteshaven        |23.5             |
|Coopershire         |23.34            |
|West Katie          |20.46            |
|New Ericville       |19.88            |
|New Ashlee          |19.11            |
|Adamsbury           |18.21            |
|South David         |14.63            |
|North Janicechester |14.61            |
|Port Kellyfort      |14.48            |
|Stephanieport       |12.65            |
|Jeffreyburgh        |11.36            |
|Gonzalesberg        |10.93            |
|North Joshuatown    |10.9             |
|Penatown            |10.45            |
|West Jason          |1.94             |

## Insight:
Certain locations, such as South Anthonyhaven and Seanview, experience extremely high traffic density (over 190), while others like West Jason (1.94) or Penatown (10.45) have minimal traffic issues. These disparities suggest that traffic conditions vary significantly across delivery zones, potentially affecting delivery times and driver efficiency.

Focus on dynamic route optimization for high-traffic areas to minimize delivery delays. Consider reallocating drivers to zones with manageable traffic or using predictive traffic data to adjust delivery times in congested areas like South Anthonyhaven.

## 5. Calculate Average Distance Per Delivery
Purpose: This query determines the average distance traveled per delivery for each driver. Analyzing these distances can highlight potential inefficiencies in routing and delivery planning.
```sql
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
```
### Results:
|driverid|avgdistancekm|
|--------|-------------|
|46      |6.0516691051 |
|24      |5.7235400668 |
|2       |5.6281363145 |
|32      |5.496770568  |
|7       |5.4843737046 |
|25      |5.4134920125 |
|20      |5.2683139491 |
|10      |5.2614787662 |
|34      |5.2341519962 |
|21      |5.1985481599 |
|4       |5.1496539464 |
|31      |4.9699689797 |
|5       |4.9473939162 |
|3       |4.9233720422 |
|11      |4.8978376426 |
|12      |4.8513171256 |
|26      |4.82360594   |
|39      |4.8030461675 |
|30      |4.7895086842 |
|1       |4.7727998557 |
|16      |4.7447436246 |
|18      |4.7010147376 |
|48      |4.6420574028 |
|8       |4.6251324556 |
|40      |4.6238644644 |
|29      |4.598046038  |
|17      |4.5201284149 |
|50      |4.5047480086 |
|22      |4.4598819845 |
|38      |4.4391160734 |
|44      |4.3859596782 |
|47      |4.3690140939 |
|28      |4.3530124303 |
|49      |4.3525895673 |
|9       |4.3108799428 |
|15      |4.3105596218 |
|23      |4.3017671768 |
|13      |4.259444606  |
|36      |4.2320452747 |
|37      |4.1508103877 |
|43      |4.0983718762 |
|6       |4.0663124604 |
|35      |4.0659661243 |
|42      |3.9949437474 |
|33      |3.9699368992 |
|14      |3.9251003353 |
|19      |3.5626667693 |
|41      |3.3919867518 |
|27      |2.7250271426 |
|45      |2.5084140343 |

## Insight:
Drivers with the highest average delivery distance include Driver 46 at 6.05 km, followed closely by Driver 24 at 5.72 km. The longer average distances could indicate a need for better route management.

To improve efficiency, UrbanEats should consider implementing route optimization technology and offering training for drivers on navigating longer routes effectively. This approach could enhance delivery times and reduce operational costs.

## 6. Compare Actual vs. Estimated Delivery Times
Purpose: This query compares the actual delivery times to estimated times for orders with significant discrepancies (greater than 30 minutes). Analyzing these differences can help identify factors leading to inaccurate estimates, enabling better forecasting.
```sql
-- 6. Compare Actual vs. Estimated Delivery Times
SELECT 
    OrderID, 
    EXTRACT(EPOCH FROM (DeliveryTime::timestamp - OrderTimestamp::timestamp))/3600 AS ActualDeliveryTimeHrs, 
    EXTRACT(EPOCH FROM Timetakentodeliver)/3600 AS EstimatedTimeHrs
FROM 
    customer_orders
WHERE 
    ABS(EXTRACT(EPOCH FROM (DeliveryTime::timestamp - OrderTimestamp::timestamp))/3600 - EXTRACT(EPOCH FROM Timetakentodeliver)/3600) > 0.5;
```
### Results:
|orderid|actualdeliverytimehrs|estimatedtimehrs|
|-------|---------------------|----------------|
|1      |0.17                 |0.74            |
|11     |0.08                 |0.6             |
|13     |0.12                 |0.9             |
|15     |0.25                 |0.93            |
|23     |0.05                 |0.76            |
|27     |0.18                 |0.84            |
|32     |0.28                 |0.83            |
|35     |0.12                 |0.72            |
|38     |0.12                 |0.88            |
|41     |0.22                 |0.72            |
|59     |0.17                 |0.9             |
|65     |0.08                 |0.79            |
|84     |0.23                 |0.89            |
|87     |0.18                 |0.94            |
|91     |0.25                 |0.99            |
|109    |0.07                 |0.67            |
|111    |0.08                 |0.82            |
|115    |0.07                 |0.76            |
|129    |0.08                 |0.75            |
|134    |0.05                 |0.96            |
|136    |0.12                 |0.91            |
|145    |0.18                 |0.77            |
|174    |0.15                 |0.77            |
|178    |0.07                 |0.84            |
|180    |0.03                 |0.63            |
|185    |0.03                 |0.99            |
|189    |0.22                 |0.87            |
|195    |0.23                 |0.94            |
|201    |0.22                 |0.88            |
|205    |0.13                 |0.83            |
|219    |0.3                  |0.97            |
|221    |0.23                 |0.77            |
|223    |0.03                 |0.63            |
|228    |0.1                  |0.71            |
|233    |0.05                 |0.68            |
|247    |0.05                 |0.61            |
|271    |0.23                 |0.83            |
|278    |0.3                  |0.83            |
|284    |0.02                 |0.66            |
|285    |0.18                 |0.96            |
|301    |0.27                 |0.81            |
|304    |0.08                 |0.63            |
|306    |0.23                 |0.76            |
|308    |0.3                  |0.83            |
|313    |0.08                 |0.77            |
|317    |0.15                 |0.83            |
|318    |0.07                 |0.8             |
|323    |0.32                 |0.87            |
|335    |0.07                 |0.67            |
|336    |0.22                 |0.97            |
|340    |0.03                 |0.77            |
|343    |0.05                 |0.61            |
|345    |0.12                 |0.97            |
|380    |0.22                 |0.93            |
|386    |0.07                 |0.97            |
|392    |0.08                 |0.74            |
|408    |0.25                 |0.94            |
|409    |0.08                 |0.72            |
|413    |0.05                 |0.77            |
|418    |0.13                 |0.88            |
|424    |0.03                 |0.98            |
|432    |0.07                 |0.58            |
|434    |0.05                 |0.82            |
|447    |0.02                 |0.63            |
|456    |0.28                 |0.92            |
|460    |0.07                 |0.64            |
|465    |0.3                  |0.96            |
|484    |0.2                  |0.77            |
|485    |0.08                 |0.71            |
|499    |0.07                 |0.66            |
|507    |0.07                 |0.97            |
|510    |0.08                 |0.95            |
|515    |0.05                 |0.84            |
|516    |0.22                 |0.79            |
|519    |0.07                 |0.68            |
|525    |0.3                  |0.98            |
|537    |0.27                 |0.89            |
|539    |0.17                 |0.79            |
|545    |0.23                 |0.86            |
|551    |0.02                 |0.58            |
|557    |0.05                 |0.63            |
|563    |0.12                 |0.97            |
|566    |0.2                  |0.82            |
|575    |0.05                 |0.82            |
|577    |0.17                 |0.89            |
|579    |0.1                  |0.7             |
|598    |0.03                 |0.81            |
|603    |0.2                  |0.85            |
|608    |0.25                 |0.81            |
|618    |0.22                 |0.8             |
|641    |0.07                 |0.66            |
|646    |0.15                 |0.85            |
|647    |0.18                 |0.71            |
|648    |0.1                  |0.89            |
|660    |0.1                  |0.94            |
|666    |0.3                  |0.83            |
|681    |0.15                 |0.83            |
|693    |0.22                 |0.98            |
|703    |0.18                 |0.75            |
|710    |0.27                 |0.83            |
|716    |0.03                 |0.85            |
|719    |0.08                 |0.87            |
|720    |0.1                  |0.7             |
|730    |0.23                 |0.76            |
|733    |0.08                 |0.84            |
|739    |0.22                 |0.83            |
|742    |0.07                 |0.92            |
|746    |0.12                 |0.64            |
|756    |0.08                 |0.6             |
|776    |0.23                 |0.75            |
|784    |0.13                 |0.72            |
|814    |0.12                 |0.88            |
|819    |0.12                 |0.96            |
|822    |0.03                 |0.71            |
|833    |0.12                 |0.72            |
|840    |0.07                 |0.96            |
|841    |0.18                 |0.87            |
|842    |0.3                  |0.87            |
|846    |0.1                  |0.6             |
|850    |0.13                 |0.98            |
|879    |0.12                 |0.75            |
|884    |0.12                 |0.67            |
|897    |0.27                 |0.99            |
|902    |0.03                 |0.77            |
|908    |0.08                 |0.81            |
|909    |0.07                 |0.59            |
|918    |0.18                 |0.93            |
|934    |0.1                  |0.72            |
|940    |0.22                 |0.77            |
|941    |0.15                 |0.71            |
|960    |0.03                 |0.76            |
|983    |0.05                 |0.83            |
|987    |0.03                 |0.66            |
|992    |0.03                 |0.99            |

## Insight:
The analysis of actual versus estimated delivery times reveals discrepancies that indicate room for improvement. Some orders, like Order 15, were delivered much faster than expected, while others, such as Order 219, took significantly longer, which could lead to customer dissatisfaction.

To enhance efficiency, UrbanEats should refine its time estimation methods based on historical data and consider training drivers on better route management. Regularly reviewing these metrics will help optimize delivery processes and improve customer satisfaction.

## 7. Analyze Total Orders per Driver
Purpose: This query counts the total number of orders delivered by each driver. Understanding individual driver performance can assist in resource allocation and identifying high-performing or underperforming drivers.
```sql
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
```

### Results:
|driverid|totalorders|
|--------|-----------|
|30      |36         |
|48      |29         |
|5       |28         |
|15      |28         |
|37      |26         |
|23      |25         |
|29      |25         |
|28      |25         |
|44      |25         |
|25      |24         |
|31      |23         |
|14      |23         |
|17      |23         |
|6       |23         |
|33      |23         |
|39      |22         |
|43      |22         |
|19      |22         |
|27      |22         |
|42      |21         |
|4       |21         |
|9       |21         |
|35      |21         |
|11      |20         |
|10      |20         |
|18      |20         |
|26      |19         |
|1       |19         |
|47      |19         |
|16      |19         |
|22      |18         |
|13      |18         |
|8       |18         |
|3       |18         |
|45      |18         |
|36      |18         |
|7       |17         |
|21      |17         |
|38      |17         |
|24      |16         |
|41      |16         |
|40      |16         |
|50      |16         |
|49      |15         |
|12      |15         |
|32      |13         |
|34      |11         |
|2       |11         |
|20      |10         |
|46      |8          |

## Insight:
The analysis of the total orders handled by drivers highlights several key insights. Driver 30 leads with 36 orders, showcasing strong performance, while Drivers 48, 5, and 15 also demonstrate commendable activity with 29 and 28 orders each.

To enhance overall performance, UrbanEats should redistribute orders among drivers, provide training for those with fewer orders, and analyze the factors contributing to the success of top performers. This approach can improve efficiency and service delivery.

## 8. Track Driver Shifts and Active Hours
Purpose: This query provides insights into driver shifts, including their start and end times, as well as the total duration of each shift. Monitoring shift patterns can assist in managing driver schedules and ensuring coverage during peak hours.
```sql
-- 8. Track Driver Shifts and Active Hours
SELECT 
    DriverID, 
    ShiftStart, 
    ShiftEnd, 
    EXTRACT(EPOCH FROM (ShiftEnd - ShiftStart))/3600 AS ShiftDuration
FROM 
    Drivers;
```
### Results:
|driverid|shiftstart             |shiftend               |shiftduration|
|--------|-----------------------|-----------------------|-------------|
|1       |2023-09-14 13:00:00.000|2023-09-14 21:00:00.000|8            |
|2       |2023-09-14 07:00:00.000|2023-09-14 13:00:00.000|6            |
|3       |2023-09-14 13:00:00.000|2023-09-14 19:00:00.000|6            |
|4       |2023-09-14 20:00:00.000|2023-09-15 04:00:00.000|8            |
|5       |2023-09-14 06:00:00.000|2023-09-14 14:00:00.000|8            |
|6       |2023-09-14 14:00:00.000|2023-09-14 22:00:00.000|8            |
|7       |2023-09-14 08:00:00.000|2023-09-14 15:00:00.000|7            |
|8       |2023-09-14 20:00:00.000|2023-09-15 03:00:00.000|7            |
|9       |2023-09-14 18:00:00.000|2023-09-15 02:00:00.000|8            |
|10      |2023-09-14 12:00:00.000|2023-09-14 18:00:00.000|6            |
|11      |2023-09-14 18:00:00.000|2023-09-15 01:00:00.000|7            |
|12      |2023-09-14 06:00:00.000|2023-09-14 14:00:00.000|8            |
|13      |2023-09-14 06:00:00.000|2023-09-14 14:00:00.000|8            |
|14      |2023-09-14 06:00:00.000|2023-09-14 13:00:00.000|7            |
|15      |2023-09-14 13:00:00.000|2023-09-14 19:00:00.000|6            |
|16      |2023-09-14 07:00:00.000|2023-09-14 14:00:00.000|7            |
|17      |2023-09-14 06:00:00.000|2023-09-14 12:00:00.000|6            |
|18      |2023-09-14 19:00:00.000|2023-09-15 02:00:00.000|7            |
|19      |2023-09-14 14:00:00.000|2023-09-14 21:00:00.000|7            |
|20      |2023-09-14 12:00:00.000|2023-09-14 19:00:00.000|7            |
|21      |2023-09-14 14:00:00.000|2023-09-14 20:00:00.000|6            |
|22      |2023-09-14 12:00:00.000|2023-09-14 20:00:00.000|8            |
|23      |2023-09-14 19:00:00.000|2023-09-15 02:00:00.000|7            |
|24      |2023-09-14 14:00:00.000|2023-09-14 22:00:00.000|8            |
|25      |2023-09-14 14:00:00.000|2023-09-14 22:00:00.000|8            |
|26      |2023-09-14 06:00:00.000|2023-09-14 12:00:00.000|6            |
|27      |2023-09-14 12:00:00.000|2023-09-14 18:00:00.000|6            |
|28      |2023-09-14 12:00:00.000|2023-09-14 19:00:00.000|7            |
|29      |2023-09-14 18:00:00.000|2023-09-15 01:00:00.000|7            |
|30      |2023-09-14 13:00:00.000|2023-09-14 21:00:00.000|8            |
|31      |2023-09-14 12:00:00.000|2023-09-14 18:00:00.000|6            |
|32      |2023-09-14 20:00:00.000|2023-09-15 03:00:00.000|7            |
|33      |2023-09-14 18:00:00.000|2023-09-15 02:00:00.000|8            |
|34      |2023-09-14 14:00:00.000|2023-09-14 20:00:00.000|6            |
|35      |2023-09-14 19:00:00.000|2023-09-15 03:00:00.000|8            |
|36      |2023-09-14 13:00:00.000|2023-09-14 19:00:00.000|6            |
|37      |2023-09-14 07:00:00.000|2023-09-14 14:00:00.000|7            |
|38      |2023-09-14 19:00:00.000|2023-09-15 02:00:00.000|7            |
|39      |2023-09-14 19:00:00.000|2023-09-15 02:00:00.000|7            |
|40      |2023-09-14 18:00:00.000|2023-09-15 02:00:00.000|8            |
|41      |2023-09-14 14:00:00.000|2023-09-14 21:00:00.000|7            |
|42      |2023-09-14 06:00:00.000|2023-09-14 14:00:00.000|8            |
|43      |2023-09-14 07:00:00.000|2023-09-14 14:00:00.000|7            |
|44      |2023-09-14 12:00:00.000|2023-09-14 20:00:00.000|8            |
|45      |2023-09-14 19:00:00.000|2023-09-15 03:00:00.000|8            |
|46      |2023-09-14 08:00:00.000|2023-09-14 14:00:00.000|6            |
|47      |2023-09-14 08:00:00.000|2023-09-14 14:00:00.000|6            |
|48      |2023-09-14 13:00:00.000|2023-09-14 21:00:00.000|8            |
|49      |2023-09-14 20:00:00.000|2023-09-15 02:00:00.000|6            |
|50      |2023-09-14 19:00:00.000|2023-09-15 01:00:00.000|6            |

## Insight:
The analysis of driver shifts reveals varied shift durations and start times, indicating potential optimization opportunities. Several drivers have overlapping shifts, particularly during peak hours in the evening, which could lead to improved efficiency if strategically managed.

To enhance productivity, UrbanEats should consider implementing a dynamic scheduling system that adjusts shift timings based on order volume trends. Additionally, aligning driver shifts to match peak demand periods will likely improve service levels and reduce wait times for customers.

## 9. Identify Delayed Orders (Delivery Time > 15 minutes)
Purpose: This query identifies orders that took longer than 15 minutes to deliver. This data can be valuable for analyzing service level agreements and customer satisfaction.
```sql
-- 9. Identify Delayed Orders (Delivery Time > 15 minutes)
SELECT 
    OrderID, 
    EXTRACT(EPOCH FROM (DeliveryTime - OrderTimestamp))/60 AS DeliveryMinutes
FROM 
    customer_orders
WHERE 
    EXTRACT(EPOCH FROM (DeliveryTime - OrderTimestamp))/60 > 15;
```
### Results:
|orderid|deliveryminutes|
|-------|---------------|
|31     |19             |
|32     |17             |
|42     |17             |
|78     |17             |
|100    |16             |
|120    |16             |
|125    |17             |
|153    |16             |
|173    |18             |
|208    |16             |
|219    |18             |
|229    |18             |
|239    |17             |
|260    |16             |
|265    |19             |
|273    |19             |
|278    |18             |
|281    |17             |
|301    |16             |
|308    |18             |
|312    |17             |
|323    |19             |
|346    |17             |
|352    |18             |
|362    |18             |
|407    |18             |
|416    |18             |
|425    |18             |
|439    |18             |
|440    |19             |
|456    |17             |
|458    |18             |
|465    |18             |
|471    |16             |
|492    |18             |
|496    |18             |
|501    |19             |
|513    |18             |
|525    |18             |
|534    |18             |
|537    |16             |
|564    |17             |
|615    |18             |
|624    |17             |
|628    |17             |
|666    |18             |
|675    |18             |
|686    |16             |
|698    |17             |
|701    |17             |
|710    |16             |
|737    |18             |
|786    |16             |
|795    |16             |
|809    |18             |
|830    |17             |
|842    |18             |
|897    |16             |
|942    |17             |
|977    |18             |
|999    |18             |

## Insight:
The analysis of delivery times indicates that the majority of orders are being completed within 16 to 19 minutes, with the most frequent delivery time being 18 minutes. This consistency in delivery times suggests that UrbanEats has a stable operational process in place for fulfilling orders efficiently.

To further enhance customer satisfaction and potentially increase order volumes, UrbanEats could explore strategies to reduce average delivery times. This might involve optimizing delivery routes, increasing the number of drivers during peak hours, or using technology to monitor traffic patterns in real-time. Additionally, offering incentives for faster deliveries could motivate drivers to prioritize efficiency, ultimately leading to improved service levels.

## 10. Analyze Restaurant Performance (Average Delivery Time per Restaurant)
Purpose: This query calculates the average delivery time for orders from each restaurant. Identifying restaurants with longer delivery times can help UrbanEats address performance issues or optimize restaurant partnerships.
```sql
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
```
### Results:
|restaurantid|avgdeliverytime|
|------------|---------------|
|17          |00:37:49       |
|14          |00:36:37       |
|8           |00:34:55       |
|9           |00:34:20       |
|19          |00:32:38       |
|4           |00:32:03       |
|3           |00:32:02       |
|5           |00:31:47       |
|2           |00:31:24       |
|20          |00:31:19       |
|7           |00:30:27       |
|18          |00:30:00       |
|11          |00:29:02       |
|12          |00:28:14       |
|6           |00:28:03       |
|10          |00:26:56       |
|1           |00:26:49       |
|13          |00:24:07       |
|16          |00:23:01       |
|15          |00:21:53       |

## Insight:

The analysis of average delivery times by restaurant reveals that Restaurant 15 has the shortest average delivery time at approximately 21 minutes and 53 seconds, while Restaurant 17 has the longest at about 37 minutes and 49 seconds. This variance suggests a significant opportunity for improvement in delivery efficiency among certain restaurants.

To enhance overall customer satisfaction, UrbanEats should consider collaborating with restaurants that have longer delivery times to identify potential bottlenecks in their processes. Implementing best practices from higher-performing restaurants could streamline operations and reduce average delivery times. Furthermore, offering incentives for quicker order fulfillment could motivate restaurant staff to prioritize efficiency, ultimately benefiting the customer experience.

## 11. Identify Orders with High Traffic at Delivery Time
Purpose: This query identifies orders that were delivered during high traffic periods (where traffic density exceeds 100 vehicles per minute). Understanding the impact of traffic on delivery can inform better routing decisions.
```sql
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
```

### Results:
|orderid|locationname      |trafficdensity|timetakentodeliver|
|-------|------------------|--------------|------------------|
|195    |South Anthonyhaven|194.22        |00:56:14          |
|492    |South Anthonyhaven|194.22        |00:47:22          |
|434    |South Anthonyhaven|194.22        |00:48:58          |
|840    |Seanview          |193.74        |00:57:40          |
|857    |Seanview          |193.74        |00:17:15          |
|983    |Seanview          |193.74        |00:49:50          |
|850    |Seanview          |193.74        |00:58:50          |
|842    |South Sandra      |193.23        |00:52:06          |
|69     |South Sandra      |193.23        |00:03:49          |
|219    |South Sandra      |193.23        |00:58:24          |
|693    |South Sandra      |193.23        |00:58:36          |
|125    |South Sandra      |193.23        |00:30:23          |
|226    |South Sandra      |193.23        |00:08:37          |
|760    |Anthonyshire      |192.11        |00:06:27          |
|84     |Anthonyshire      |192.11        |00:53:17          |
|502    |Anthonyshire      |192.11        |00:15:02          |
|313    |Anthonyshire      |192.11        |00:46:06          |
|359    |New Emilyborough  |188.02        |00:09:10          |
|746    |New Emilyborough  |188.02        |00:38:11          |
|766    |New Emilyborough  |188.02        |00:18:38          |
|345    |New Emilyborough  |188.02        |00:58:07          |
|869    |New Emilyborough  |188.02        |00:30:47          |
|809    |Simpsonshire      |185.27        |00:40:56          |
|134    |Simpsonshire      |185.27        |00:57:26          |
|660    |Simpsonshire      |185.27        |00:56:20          |
|577    |Simpsonshire      |185.27        |00:53:19          |
|776    |Simpsonshire      |185.27        |00:45:13          |
|47     |Jenniferview      |180.17        |00:05:12          |
|121    |Jenniferview      |180.17        |00:24:44          |
|727    |Jenniferview      |180.17        |00:20:41          |
|335    |New Melissaville  |176.95        |00:40:18          |
|452    |New Melissaville  |176.95        |00:08:13          |
|824    |New Melissaville  |176.95        |00:00:12          |
|237    |New Melissaville  |176.95        |00:10:55          |
|143    |New Melissaville  |176.95        |00:12:05          |
|460    |New Melissaville  |176.95        |00:38:24          |
|540    |New Melissaville  |176.95        |00:21:53          |
|115    |New Melissaville  |176.95        |00:45:25          |
|433    |New Melissaville  |176.95        |00:01:09          |
|499    |New Melissaville  |176.95        |00:39:25          |
|260    |Wangfort          |167.35        |00:00:57          |
|14     |New David         |166.08        |00:09:18          |
|208    |New David         |166.08        |00:36:41          |
|416    |New David         |166.08        |00:03:51          |
|537    |New David         |166.08        |00:53:32          |
|784    |New David         |166.08        |00:43:14          |
|426    |Brendafort        |164.32        |00:02:30          |
|589    |Brendafort        |164.32        |00:04:59          |
|648    |Brendafort        |164.32        |00:53:31          |
|649    |Brendafort        |164.32        |00:21:48          |
|392    |Brendafort        |164.32        |00:44:24          |
|387    |Brendafort        |164.32        |00:24:01          |
|382    |Brendafort        |164.32        |00:26:15          |
|283    |Brendafort        |164.32        |00:10:02          |
|870    |Brendafort        |164.32        |00:28:49          |
|887    |Brendafort        |164.32        |00:30:29          |
|671    |Port Sheilaport   |163.95        |00:35:52          |
|646    |Port Sheilaport   |163.95        |00:51:17          |
|369    |Port Sheilaport   |163.95        |00:25:24          |
|998    |Port Sheilaport   |163.95        |00:20:44          |
|415    |Port Sheilaport   |163.95        |00:09:46          |
|386    |Underwoodshire    |163.09        |00:58:04          |
|695    |Underwoodshire    |163.09        |00:02:49          |
|681    |Underwoodshire    |163.09        |00:49:53          |
|708    |Underwoodshire    |163.09        |00:29:00          |
|418    |Underwoodshire    |163.09        |00:52:39          |
|703    |Mathewsborough    |162           |00:44:43          |
|756    |Mathewsborough    |162           |00:35:56          |
|189    |Pageport          |159.08        |00:52:28          |
|686    |Pageport          |159.08        |00:44:28          |
|221    |Lake Mary         |158.36        |00:46:03          |
|154    |Lake Mary         |158.36        |00:24:35          |
|271    |Lake Mary         |158.36        |00:49:57          |
|822    |Lake Mary         |158.36        |00:42:49          |
|294    |Deborahburgh      |155.52        |00:18:18          |
|223    |Bobbyton          |152.3         |00:37:41          |
|31     |Bobbyton          |152.3         |00:01:58          |
|574    |Bobbyton          |152.3         |00:15:37          |
|748    |Bobbyton          |152.3         |00:10:45          |
|878    |Bobbyton          |152.3         |00:09:03          |
|471    |Bobbyton          |152.3         |00:16:19          |
|464    |Ramirezstad       |151.2         |00:20:41          |
|618    |Ramirezstad       |151.2         |00:48:15          |
|267    |Josephchester     |150.81        |00:11:15          |
|188    |Josephchester     |150.81        |00:29:15          |

## Insight:
Delivery times vary significantly by location, with areas like South Anthonyhaven and Seanview facing longer averages, often exceeding 50 minutes. In contrast, locations such as Bobbyton and Brendafort experience much shorter delivery times.

To enhance efficiency, UrbanEats should optimize routing algorithms using real-time traffic data and consider incentives for faster deliveries in congested areas to boost customer satisfaction.

## 12. Driver Performance by Average Delivery Time
Purpose: This query assesses each driver’s average delivery time alongside the number of deliveries they completed. It provides insight into driver efficiency and can help identify those who consistently perform well or poorly.
```sql
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
```

### Results:
|driverid|avgdeliverytimehrs|totaldeliveries|
|--------|------------------|---------------|
|3       |0.2611111111      |18             |
|39      |0.2466666667      |22             |
|2       |0.2333333333      |11             |
|48      |0.21875           |29             |
|25      |0.2041666667      |24             |
|32      |0.2033333333      |13             |
|24      |0.2               |16             |
|46      |0.2               |8              |
|12      |0.1979166667      |15             |
|10      |0.1976190476      |20             |
|22      |0.1952380952      |18             |
|44      |0.1833333333      |25             |
|31      |0.1703703704      |23             |
|6       |0.1696969697      |23             |
|4       |0.1666666667      |21             |
|7       |0.1666666667      |17             |
|11      |0.1642857143      |20             |
|17      |0.1641025641      |23             |
|28      |0.1638888889      |25             |
|30      |0.1633333333      |36             |
|21      |0.16              |17             |
|23      |0.1592592593      |25             |
|40      |0.1583333333      |16             |
|50      |0.1555555556      |16             |
|13      |0.1516666667      |18             |
|42      |0.15              |21             |
|9       |0.15              |21             |
|38      |0.15              |17             |
|15      |0.15              |28             |
|16      |0.1466666667      |19             |
|43      |0.145             |22             |
|19      |0.1444444444      |22             |
|26      |0.1444444444      |19             |
|8       |0.14              |18             |
|37      |0.1378787879      |26             |
|49      |0.1357142857      |15             |
|41      |0.1333333333      |16             |
|20      |0.1333333333      |10             |
|5       |0.1291666667      |28             |
|1       |0.1285714286      |19             |
|29      |0.1216666667      |25             |
|34      |0.1166666667      |11             |
|33      |0.115             |23             |
|14      |0.1119047619      |23             |
|18      |0.11              |20             |
|35      |0.1066666667      |21             |
|47      |0.1066666667      |19             |
|27      |0.1037037037      |22             |
|36      |0.0880952381      |18             |
|45      |0.0866666667      |18             |

## Insight:
The data reveals notable variations in average delivery times among drivers, with the most efficient averaging around 0.2 hours (approximately 12 minutes), while others take over 0.26 hours (about 16 minutes). Drivers with a higher number of deliveries, such as Driver 48, show relatively lower average delivery times, suggesting that experience may enhance efficiency.

To improve overall performance, UrbanEats should consider implementing training programs for drivers with longer delivery times, sharing best practices from top performers. Additionally, incentivizing faster deliveries could motivate drivers to enhance their performance further, leading to increased customer satisfaction and operational efficiency.

## 13. Top 5 Restaurants with Most Orders
Purpose: This query identifies the five restaurants with the highest order volume. Understanding which restaurants are most popular can assist UrbanEats in marketing strategies and resource allocation.
```sql
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
```

### Results:
|restaurantid|totalorders|
|------------|-----------|
|6           |68         |
|14          |67         |
|9           |65         |
|3           |61         |
|12          |61         |

## Insight:
Restaurants 6, 14, and 9 lead in total orders, reflecting strong customer demand. In contrast, Restaurants 3 and 12 may need strategies to increase visibility and attract more customers.

To leverage this success, UrbanEats should promote top-selling items from the leading restaurants and investigate customer feedback for the others to identify improvement areas, enhancing overall order volumes.

## 14. Identify Orders Placed During Peak Hours (e.g., 6 PM - 9 PM)
Purpose: This query tracks orders placed during peak dinner hours and assesses their delivery times. Analyzing these peak periods can help UrbanEats prepare for high demand and optimize staffing and routing.
```sql
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
```

### Results:
|orderid|orderhour|timetakentodeliver|
|-------|---------|------------------|
|525    |20       |00:58:56          |
|134    |18       |00:57:26          |
|15     |20       |00:55:49          |
|201    |18       |00:52:45          |
|814    |21       |00:52:44          |
|719    |20       |00:52:19          |
|716    |18       |00:50:51          |
|308    |20       |00:50:02          |
|739    |18       |00:49:57          |
|598    |19       |00:48:18          |
|318    |21       |00:48:09          |
|484    |20       |00:46:25          |
|409    |19       |00:43:09          |
|822    |20       |00:42:49          |
|579    |19       |00:42:11          |
|809    |20       |00:40:56          |
|349    |20       |00:39:10          |
|557    |19       |00:38:00          |
|304    |19       |00:37:35          |
|173    |20       |00:37:28          |
|756    |21       |00:35:56          |
|432    |18       |00:34:33          |
|130    |21       |00:30:17          |
|183    |20       |00:29:43          |
|690    |19       |00:28:33          |
|626    |19       |00:26:42          |
|886    |18       |00:23:25          |
|560    |21       |00:23:24          |
|362    |18       |00:22:10          |
|668    |20       |00:20:44          |
|405    |20       |00:20:30          |
|743    |20       |00:20:07          |
|463    |19       |00:18:40          |
|471    |21       |00:16:19          |
|292    |20       |00:14:32          |
|338    |20       |00:12:20          |
|267    |19       |00:11:15          |
|977    |20       |00:10:17          |
|283    |21       |00:10:02          |
|452    |20       |00:08:13          |
|107    |20       |00:06:18          |
|80     |21       |00:04:31          |
|69     |18       |00:03:49          |
|331    |20       |00:03:29          |
|281    |20       |00:03:12          |
|855    |20       |00:02:59          |
|695    |19       |00:02:49          |
|234    |19       |00:02:24          |
|929    |19       |00:02:16          |
|795    |19       |00:01:54          |
|45     |21       |00:01:08          |
|102    |21       |00:00:42          |

## Insight:
The data indicates that delivery times improve after 19:00, with the quickest service occurring around 21:00, where several orders are completed in under 10 minutes. In contrast, orders around 18:00 and 20:00 tend to take longer, often exceeding 50 minutes.

To leverage this trend, UrbanEats could promote late-night deliveries with incentives, while also examining the reasons for slower service during peak hours to enhance efficiency throughout the day.

## 15. Calculate Average Delivery Time by Day of the Week
Purpose: This query calculates the average delivery time for orders based on the day of the week. Understanding how delivery times fluctuate throughout the week can help UrbanEats manage operations and improve customer service.
```sql
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
```
### Results:
|dayofweek|avgdeliverytimehrs|
|---------|------------------|
|Friday   |0.1608843537      |
|Thursday |0.1594339623      |
|Monday   |0.1592592593      |
|Saturday |0.1569444444      |
|Sunday   |0.1555555556      |
|Wednesday|0.1510928962      |
|Tuesday  |0.1429166667      |

## Insight:
The data shows that Tuesday has the shortest average delivery time at approximately 0.143 hours (about 8.6 minutes), while Friday has the longest at around 0.161 hours (approximately 9.7 minutes).

This pattern suggests that demand may be lower on Tuesdays, leading to faster service. UrbanEats should consider offering promotions or discounts on Tuesdays to boost order volume, while analyzing Friday's longer delivery times to identify areas for efficiency improvements, potentially reallocating resources or optimizing routes during peak periods.