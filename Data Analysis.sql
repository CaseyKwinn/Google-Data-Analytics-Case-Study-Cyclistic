--data analysis

--bike types
SELECT member_casual, rideable_type, 
COUNT(*) AS total_trips,
COUNT(*) * 100.0 / (SELECT COUNT(*) FROM tripdata_clean) AS total_trips_percent
FROM tripdata_clean
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_trips;

--trips per hour
SELECT EXTRACT(HOUR FROM started_at) AS hour_of_day, member_casual, 
COUNT(ride_id) AS total_trips
FROM tripdata_clean
GROUP BY hour_of_day, member_casual
ORDER BY member_casual;

--trips per DoW:
SELECT day_of_week, member_casual, COUNT(ride_id) AS total_trips
FROM tripdata_clean
GROUP BY day_of_week, member_casual
ORDER BY member_casual;

--trips per month:
SELECT month, member_casual, COUNT(ride_id) AS total_trips
FROM tripdata_clean
GROUP BY month, member_casual
ORDER BY member_casual;

--avg length ride per hour
SELECT EXTRACT(HOUR FROM started_at) AS hour_of_day, member_casual, AVG(ride_duration) AS avg_ride_duration
FROM tripdata_clean
GROUP BY hour_of_day, member_casual
ORDER BY member_casual, hour_of_day;

--avg length ride per month
SELECT month, member_casual, ROUND(AVG(ride_duration), 2) AS avg_ride_duration
FROM tripdata_clean
GROUP BY month, member_casual;

--avg length ride per day of week
SELECT day_of_week, member_casual, AVG(ride_duration) AS avg_ride_duration
FROM tripdata_clean
GROUP BY day_of_week, member_casual;

--most common starting station locations
SELECT start_station_name, member_casual,
  AVG(start_lat) AS start_lat, AVG(start_lng) AS start_lng,
  COUNT(ride_id) AS total_trips
FROM tripdata_clean
GROUP BY start_station_name, member_casual
ORDER BY total_trips DESC
LIMIT 20;

--most common ending station locations
SELECT end_station_name, member_casual,
  AVG(end_lat) AS end_lat, AVG(end_lng) AS end_lng,
  COUNT(ride_id) AS total_trips
FROM tripdata_clean
GROUP BY end_station_name, member_casual
ORDER BY total_trips DESC
LIMIT 20;