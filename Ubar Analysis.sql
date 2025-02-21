

use ubar;

select * from driver;
select * from passenger p ;
select * from ride r ;

#1.What are & how many unique pickup locations are there in the dataset?

select distinct pickup_location from ride r ;

#2.What is the total number of rides in the dataset?

select count(ride_id) from ride r ;

#3.Calculate the average ride duration.

select avg(ride_duration) from ride r ;

#4.List the top 5 drivers based on their total earnings.

select driver_id ,earnings from driver d order by earnings desc limit 5 ;

-- SELECT driver_id, SUM(earnings) AS total_earnings 
-- FROM driver d 
-- GROUP BY driver_id 
-- ORDER BY total_earnings DESC LIMIT 5;

#5.Calculate the total number of rides for each payment method.

select payment_method,count(ride_id) as ride_count from ride r
group by payment_method ;

#6.Retrieve rides with a fare amount greater than 20.

select ride_id,fare_amount from ride r where fare_amount>20;

#7.Identify the most common pickup location.

select distinct(pickup_location),count(*) as comman_ride from ride r
group by pickup_location order by comman_ride desc limit 1;

#8.Calculate the average fare amount.

select avg(fare_amount) from ride r ;

#9.List the top 10 drivers with the highest average ratings.

select driver_id,avg(rating) as avg_rating from driver d 
group by driver_id order by avg_rating desc limit 10;

#10.Calculate the total earnings for all drivers.

select driver_id,sum(earnings) from driver d 
group by driver_id ;

select sum(earnings) from driver d ;

#11.How many rides were paid using the "Cash" payment method?

select count(ride_id),payment_method from ride r 
group by payment_method  having payment_method="cash" ;

#12.Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.

select count(*) as num_ride ,avg(ride_distance) from ride r 
where pickup_location ="Dhanbad";

#13.Retrieve rides with a ride duration less than 10 minutes.

select ride_id,ride_distance from ride r where ride_distance <10 ;

#14.List the passengers who have taken the most number of rides.

select passenger_id,count(*) as number_ride from ride 
group by passenger_id order by number_ride desc Limit 1 ;

#15.Calculate the total number of rides for each driver in descending order.

select count(*) as total_num_ride , driver_id from ride r
group by driver_id order by total_num_ride desc ;

#16.Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.
 
select pickup_location,count(*) as ride_gandhinagar,payment_method from ride r group by pickup_location,payment_method
having pickup_location="Gandhinagar";

#17.Calculate the average fare amount for rides with a ride distance greater than 10.

select ride_id,ride_distance,avg(fare_amount) as avg_far from ride r 
group by ride_id,ride_distance having ride_distance>10;

SELECT AVG(fare_amount) 
FROM ride r 
WHERE ride_distance > 10;

#18.List the drivers in descending order accordinh to their total number of rides.

SELECT driver_id, total_rides
FROM driver d 
order by total_rides DESC;

#19.Calculate the percentage distribution of rides for each pickup location.

SELECT pickup_location, COUNT(*) AS ride_count,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ride r2 ), 2) AS percentage 
FROM ride r 
GROUP BY pickup_location
order by percentage desc;


#20.Retrieve rides where both pickup and dropoff locations are the same.

select pickup_location,dropoff_location from ride r where pickup_location=dropoff_location ;

#Intermediate Level:     

#1.List the passengers who have taken rides from at least 300 different pickup locations.

select passenger_id,count(distinct pickup_location) as pickup_loc from ride r 
group by passenger_id having pickup_loc>= 300;

#2.Calculate the average fare amount for rides taken on weekdays.

select * from ride r ;

SELECT AVG(fare_amount)
FROM ride r 
WHERE dayofweek(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i'))>5;

#3.Identify the drivers who have taken rides with distances greater than 19.

select driver_id, ride_id,ride_distance from ride r
where  ride_distance >19;

#4.Calculate the total earnings for drivers who have completed more than 100 rides.

select driver_id,total_rides,sum(earnings)AS total_earnings from driver d group by driver_id ,total_rides 
having total_rides >100;

#5.Retrieve rides where the fare amount is less than the average fare amount.

select avg(fare_amount) from ride r ;

select fare_amount from ride r where fare_amount < (select avg(fare_amount) from ride r)
order by fare_amount desc ;

#6.Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.

select distinct driver_name,avg(rating) avg_rating  from driver d right join ride r on d.driver_id=r.driver_id
where payment_method in ("Cash    ","Credit Card")
group by driver_name order by avg_rating desc ; 

SELECT driver_id, AVG(rating) AS avg_rating
FROM driver d 
WHERE driver_id IN (SELECT driver_id FROM ride r WHERE payment_method IN ('Credit Card', 'Cash') GROUP BY driver_id HAVING COUNT(DISTINCT payment_method) = 2)
GROUP BY driver_id order by avg_rating desc ;

#7.List the top 3 passengers with the highest total spending.

select passenger_id,sum(fare_amount) from ride r group by passenger_id 
order by sum(fare_amount) desc limit 3 ;

select * from passenger p ;

select * from ride r 

#8.Calculate the average fare amount for rides taken during different months of the year.

select MONTH(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i')) as months_of_year,
avg(fare_amount) from ride r group by months_of_year;

#9.Identify the most common pair of pickup and dropoff locations.

select pickup_location,dropoff_location,count(*) ride_number from ride r 
group by pickup_location ,dropoff_location order by ride_number desc limit 1 ;

#10.Calculate the total earnings for each driver and order them by earnings in descending order.

select driver_id,sum(earnings) from driver d 
group by driver_id order by sum(earnings) desc ;

#11.List the passengers who have taken rides on their signup date.

select signup_date from passenger p ;

select p.passenger_id,r.ride_id from passenger p join ride r on p.passenger_id = r.passenger_id 
where (p.signup_date)=(r.ride_timestamp);

SELECT p.passenger_id, p.passenger_name
FROM passenger p 
JOIN ride r ON p.passenger_id = r.passenger_id
WHERE (p.signup_date) = (r.ride_timestamp);

#12.Calculate the average earnings for each driver and order them by earnings in descending order.
select avg(earnings) as avg_earning,driver_id from driver d 
group by driver_id order by avg_earning desc ;


#13.Retrieve rides with distances less than the average ride distance.

select ride_id ,ride_distance from ride r where ride_distance < (select avg(ride_distance) from ride r2 );

#14.List the drivers who have completed the least number of rides.

select driver_id,driver_name ,count(*) as ride_count from driver d 
group by driver_id,driver_name ;

#15.Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.


select avg(fare_amount) as avg_far_amount from ride r join passenger p on r.passenger_id = p.passenger_id 
where total_rides>=20;

select * from passenger p where total_rides=20 ;

#16.Identify the pickup location with the highest average fare amount.

select max(fare_amount) as highest_amount,pickup_location from ride r
group by pickup_location order by highest_amount desc limit 1 ;

#17.Calculate the average rating of drivers who completed at least 100 rides.

select avg(rating) as avg_rating from driver d
where total_rides>=100;

SELECT AVG(rating) FROM driver d WHERE driver_id IN 
(SELECT driver_id FROM ride r GROUP BY driver_id  HAVING COUNT(*) >= 100);

#18.List the passengers who have taken rides from at least 5 different pickup locations.

select passenger_id,pickup_location,count(distinct pickup_location) as distance from ride r 
group by passenger_id,pickup_location ;


#19.Calculate the average fare amount for rides taken by passengers with ratings above 4.

select avg(fare_amount) as avg_far from ride r join passenger p on r.passenger_id=p.passenger_id
where rating >=4;

#20.Retrieve rides with the shortest ride duration in each pickup location.

select distinct pickup_location,ride_id , min(ride_duration) as sort_duration from ride r 
group by pickup_location,ride_id order by sort_duration asc ;

select ride_id, ride_duration, pickup_location from ride r where ride_duration=
(select min(ride_duration) from ride r2 order by min(ride_duration) asc) ;

#Advanced Level:

#1.List the drivers who have driven rides in all pickup locations.

SELECT driver_id
FROM driver d 
WHERE driver_id NOT IN (SELECT DISTINCT driver_id FROM ride r WHERE pickup_location NOT IN (SELECT DISTINCT pickup_location
FROM ride r2 ));


select driver_id from driver d where driver_id not in (
select distinct driver_id from ride r where pickup_location not in 
(select distinct pickup_location from ride r2));

select driver_id from driver d where driver_id not in
(select distinct driver_id from ride r where pickup_location not in (select distinct pickup_location from ride r));

select distinct driver_id,pickup_location from ride r where pickup_location in (select distinct pickup_location from ride r2);


select distinct pickup_location from ride r ;

#2.Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.

select avg(fare_amount) from ride r ;

select  avg(fare_amount) as avg_fare from passenger p join ride r on p.passenger_id = r.passenger_id 
where total_spent >=300;

#3.List the bottom 5 drivers based on their average earnings.

select avg(earnings)avg_earning , driver_id from driver d 
group by driver_id order by avg_earning asc limit 5 ;

#4.Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.
SELECT  DISTINCT payment_method,SUM(fare_amount)
FROM ride r group by payment_method ;


SELECT SUM(fare_amount)
FROM ride r 
WHERE passenger_id IN (SELECT passenger_id FROM ride r2 GROUP BY passenger_id
HAVING COUNT(DISTINCT payment_method) > 1
);

#5.Retrieve rides where the fare amount is significantly above the average fare amount.

select ride_id,fare_amount from ride r where fare_amount > (select avg(fare_amount) from ride r2);


#6.List the drivers who have completed rides on the same day they joined.

select * from driver d;

select r.ride_id  from ride r join driver d on r.driver_id = d.driver_id 
where r.ride_timestamp = d.join_date ;

#7.Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.

select avg(fare_amount) from ride r where passenger_id in (select passenger_id from ride r2 group by passenger_id having count(distinct payment_method))

#8.Identify the pickup location with the highest percentage increase 
#in average fare amount compared to the overall average fare.

SELECT pickup_location, AVG(fare_amount) AS avg_fare,
       (AVG(fare_amount) - (SELECT AVG(fare_amount) from ride r)) * 100.0 / (SELECT AVG(fare_amount) FROM ride r2) AS percentage_increase
FROM ride r3 
GROUP BY pickup_location
ORDER BY percentage_increase desc
LIMIT 1;

#9.Retrieve rides where the dropoff location is the same as the pickup location.


select dropoff_location,pickup_location from ride r where dropoff_location = pickup_location ;


#10.Calculate the average rating of drivers who have driven rides with varying pickup locations.


SELECT AVG(rating) FROM driver d WHERE driver_id IN (SELECT DISTINCT driver_id FROM ride r 
    GROUP BY driver_id
    HAVING COUNT(DISTINCT pickup_location) > 1
);

