-- CREATE SCHEMA
CREATE SCHEMA IF NOT EXISTS "Route Optimization for Food Delivery";

--SET SEARCH PATH FOR QUERIES
SET search_path = "Route Optimization for Food Delivery";

-- RESET DATE FORMAT
--SHOW datestyle;
--SET datestyle = 'ISO, DMY';

-- CREATE TABLE FOR TRAFFIC_DATA
DROP TABLE IF EXISTS traffic_data;
CREATE TABLE IF NOT EXISTS traffic_data (
    LocationID BIGSERIAL PRIMARY KEY, -- Unique identifier for the urban location
    LocationName VARCHAR, -- Descriptive name of the location
    TrafficDensity NUMERIC -- Traffic congestion or density (Vehicles per Minute)
);

--COPY DATA INTO TRAFFIC_DATA TABLE
COPY traffic_data(LocationID, LocationName, TrafficDensity)
FROM 'C:/Users/USER/Desktop/PORTFOLIO PROJECT/Power bi and SQL/Route Optimization for Food Delivery/Datasets/traffic_data.csv'
DELIMITER ','
CSV HEADER;

-- CREATE TABLE FOR DRIVERS
DROP TABLE IF EXISTS drivers;
CREATE TABLE IF NOT EXISTS drivers (
    DriverID BIGSERIAL PRIMARY KEY, -- Unique identifier for the driver
    DriverName VARCHAR, -- Name of the driver
    ShiftID INTEGER, -- Identifier for the driver's shift
    ShiftStart TIMESTAMP, -- Shift start time
    ShiftEnd TIMESTAMP -- Shift end time
);

-- COPY DATA INTO DRIVERS TABLE
COPY drivers(DriverID, DriverName, ShiftID, ShiftStart, ShiftEnd)
FROM 'C:/Users/USER/Desktop/PORTFOLIO PROJECT/Power bi and SQL/Route Optimization for Food Delivery/Datasets/drivers.csv'
DELIMITERS ','
CSV HEADER;

-- CREATE TABLE FOR RESTAURANTS
DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants (
    RestaurantID BIGSERIAL PRIMARY KEY, -- Unique identifier for the restaurant
    RestaurantName VARCHAR NOT NULL, -- Name of the restaurant
    Address VARCHAR NOT NULL -- Restaurant's address
);

-- COPY DATA INTO RESTAURANTS TABLE
COPY restaurants (RestaurantID, RestaurantName, Address)
FROM 'C:/Users/USER/Desktop/PORTFOLIO PROJECT/Power bi and SQL/Route Optimization for Food Delivery/Datasets/restaurants.csv'
DELIMITERS ','
CSV HEADER;

-- CREATE TABLE FOR CUSTOMER_ORDERS RESULTS
DROP TABLE IF EXISTS customer_orders;
CREATE TABLE IF NOT EXISTS customer_orders (
    OrderID SERIAL PRIMARY KEY, -- Unique identifier for each customer order
    CustomerID INTEGER, -- Foreign key to Customers table (assuming you have a Customers table)
    DeliveryAddress VARCHAR, -- Address where the food will be delivered
    Latitude NUMERIC, -- Latitude of the delivery address
    Longitude NUMERIC, -- Longitude of the delivery address
    OrderTimestamp TIMESTAMP, -- Timestamp when the order was placed
    OrderStatus VARCHAR, -- Status of the order (e.g., Pending, Delivered)
    DriverID INTEGER, -- Foreign key to Drivers table
    RestaurantID INTEGER, -- Foreign key to Restaurants TABLE
    LocationID INTEGER,
    DistanceKM NUMERIC,
    DeliveryHours NUMERIC,
    Timetakentodeliver TIME,
    DeliveryTime TIMESTAMP,
    --CONSTRAINT fk_customer FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), -- Assuming a Customers table exists
    CONSTRAINT fk_driver FOREIGN KEY (DriverID) REFERENCES drivers(DriverID),
    CONSTRAINT fk_restaurant FOREIGN KEY (RestaurantID) REFERENCES restaurants(RestaurantID)
);

-- COPY DATA INTO CUSTOMER_ORDERS TABLE
COPY customer_orders(OrderID, CustomerID, DeliveryAddress, Latitude, Longitude, OrderTimestamp, OrderStatus, DriverID, RestaurantID, LocationID, DistanceKM, DeliveryHours, Timetakentodeliver, DeliveryTime)
FROM 'C:/Users/USER/Desktop/PORTFOLIO PROJECT/Power bi and SQL/Route Optimization for Food Delivery/Datasets/customer_orders.csv'
DELIMITERS ','
CSV HEADER;

-- CHECK THE RESULTS 
SELECT * FROM customer_orders co ;
SELECT * FROM drivers d;
SELECT * FROM restaurants r; 
SELECT * FROM traffic_data td; 





