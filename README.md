
# SQL Project: Uber Ride Analysis

## Introduction
This project involves analyzing Uber ride data using SQL queries. The dataset includes three tables: `driver`, `passenger`, and `ride`. The queries cover basic, intermediate, and advanced levels, extracting valuable insights from the dataset.

---

## Dataset Description
- **driver**: Contains driver information, including earnings and ratings.
- **passenger**: Contains details about passengers.
- **ride**: Stores ride details, including pickup/dropoff locations, fare amounts, and payment methods.

---

## Basic SQL Queries & Insights

### 1. Unique Pickup Locations
```sql
SELECT DISTINCT pickup_location FROM ride;
```
**Insight:** Identifies the number of unique pickup locations in the dataset.

### 2. Total Number of Rides
```sql
SELECT COUNT(ride_id) FROM ride;
```
**Insight:** Determines the total number of rides recorded.

### 3. Average Ride Duration
```sql
SELECT AVG(ride_duration) FROM ride;
```
**Insight:** Calculates the average duration of all rides.

### 4. Top 5 Drivers by Total Earnings
```sql
SELECT driver_id, SUM(earnings) AS total_earnings
FROM driver
GROUP BY driver_id
ORDER BY total_earnings DESC
LIMIT 5;
```
**Insight:** Identifies the highest-earning drivers.

### 5. Total Rides per Payment Method
```sql
SELECT payment_method, COUNT(ride_id) AS ride_count
FROM ride
GROUP BY payment_method;
```
**Insight:** Shows the distribution of rides by payment method.

### 6. Rides with Fare Amount Greater Than 20
```sql
SELECT ride_id, fare_amount FROM ride WHERE fare_amount > 20;
```
**Insight:** Retrieves rides that had fares greater than $20.

### 7. Most Common Pickup Location
```sql
SELECT pickup_location, COUNT(*) AS ride_count
FROM ride
GROUP BY pickup_location
ORDER BY ride_count DESC
LIMIT 1;
```
**Insight:** Identifies the most frequently used pickup location.

### 8. Average Fare Amount
```sql
SELECT AVG(fare_amount) FROM ride;
```
**Insight:** Computes the average fare for all rides.

### 9. Top 10 Drivers with Highest Average Ratings
```sql
SELECT driver_id, AVG(rating) AS avg_rating
FROM driver
GROUP BY driver_id
ORDER BY avg_rating DESC
LIMIT 10;
```
**Insight:** Lists the highest-rated drivers.

### 10. Total Earnings for All Drivers
```sql
SELECT SUM(earnings) FROM driver;
```
**Insight:** Computes the total earnings made by all drivers.

---

## Intermediate SQL Queries & Insights

### 1. Passengers Who Took Rides from 300+ Different Pickup Locations
```sql
SELECT passenger_id, COUNT(DISTINCT pickup_location) AS pickup_count
FROM ride
GROUP BY passenger_id
HAVING pickup_count >= 300;
```
**Insight:** Identifies frequent travelers who used many different pickup locations.

### 2. Average Fare Amount for Weekday Rides
```sql
SELECT AVG(fare_amount)
FROM ride
WHERE DAYOFWEEK(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i')) > 5;
```
**Insight:** Finds how ride fares vary on weekdays.

### 3. Drivers with Rides Greater Than 19 km
```sql
SELECT driver_id, ride_id, ride_distance
FROM ride
WHERE ride_distance > 19;
```
**Insight:** Identifies long-distance rides and their drivers.

### 4. Total Earnings for Drivers Who Completed More Than 100 Rides
```sql
SELECT driver_id, SUM(earnings) AS total_earnings
FROM driver
GROUP BY driver_id
HAVING COUNT(*) > 100;
```
**Insight:** Highlights earnings of experienced drivers.

### 5. Rides with Fare Amount Below the Average
```sql
SELECT ride_id, fare_amount
FROM ride
WHERE fare_amount < (SELECT AVG(fare_amount) FROM ride);
```
**Insight:** Finds rides that had lower fares compared to the overall average.

---

## Advanced SQL Queries & Insights

### 1. Drivers Who Have Driven in All Pickup Locations
```sql
SELECT driver_id
FROM driver
WHERE driver_id NOT IN (
    SELECT DISTINCT driver_id FROM ride WHERE pickup_location NOT IN (
        SELECT DISTINCT pickup_location FROM ride
    )
);
```
**Insight:** Identifies the most widely available drivers.

### 2. Average Fare Amount for Passengers Who Spent Over $300
```sql
SELECT AVG(fare_amount)
FROM ride
WHERE passenger_id IN (
    SELECT passenger_id
    FROM passenger
    WHERE total_spent >= 300
);
```
**Insight:** Determines spending patterns of high-value passengers.

### 3. Bottom 5 Drivers by Average Earnings
```sql
SELECT driver_id, AVG(earnings) AS avg_earning
FROM driver
GROUP BY driver_id
ORDER BY avg_earning ASC
LIMIT 5;
```
**Insight:** Highlights drivers with the lowest earnings.

### 4. Rides with the Highest Percentage Increase in Fare Amount
```sql
SELECT pickup_location, AVG(fare_amount) AS avg_fare,
       (AVG(fare_amount) - (SELECT AVG(fare_amount) FROM ride)) * 100.0 / (SELECT AVG(fare_amount) FROM ride) AS percentage_increase
FROM ride
GROUP BY pickup_location
ORDER BY percentage_increase DESC
LIMIT 1;
```
**Insight:** Identifies locations with significant fare increases.

### 5. Rides Where Pickup and Dropoff Locations Are the Same
```sql
SELECT pickup_location, dropoff_location
FROM ride
WHERE pickup_location = dropoff_location;
```
**Insight:** Finds rides that started and ended at the same location, possibly indicating canceled trips.

---

## Conclusion
These SQL queries help analyze Uber ride data by answering key business questions. The dataset allows insights into ride distribution, driver performance, passenger behavior, and financial metrics. This project can be expanded further with more complex queries and visualizations using tools like Tableau or Python.

