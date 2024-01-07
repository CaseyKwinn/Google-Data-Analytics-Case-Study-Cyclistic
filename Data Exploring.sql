--Show data types of columns:
SELECT * FROM tripdata_all
LIMIT 0

--Check duplicate rows
SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM tripdata_all
--result: 0

--check for number of null values in each column:
SELECT COUNT(*) - COUNT(ride_id) ride_id,
 COUNT(*) - COUNT(rideable_type) rideable_type,
 COUNT(*) - COUNT(started_at) started_at,
 COUNT(*) - COUNT(ended_at) ended_at,
 COUNT(*) - COUNT(start_station_name) start_station_name,
 COUNT(*) - COUNT(start_station_id) start_station_id,
 COUNT(*) - COUNT(end_station_name) end_station_name,
 COUNT(*) - COUNT(end_station_id) end_station_id,
 COUNT(*) - COUNT(start_lat) start_lat,
 COUNT(*) - COUNT(start_lng) start_lng,
 COUNT(*) - COUNT(end_lat) end_lat,
 COUNT(*) - COUNT(end_lng) end_lng,
 COUNT(*) - COUNT(member_casual) member_casual
FROM tripdata_all;

--check for null value consistencies between start/end station name/id/lat/lng
SELECT
 SUM(case when start_station_name is null and start_station_id is null
	 then 1 else 0 end) AS ss_name_and_id,
 SUM(case when end_station_name is null and end_station_id is null
	 then 1 else 0 end) AS es_name_and_id,
 SUM(case when end_lat is null and end_lng is null
	 then 1 else 0 end) AS end_lat_and_lng,
 SUM(case when start_station_name is null and end_station_name is null
	 then 1 else 0 end) AS start_and_end_sn,
 SUM(case when end_station_name is null and end_lat is null
	 then 1 else 0 end) AS end_sn_and_lat 
FROM tripdata_all;

--check for errors member_casual
SELECT DISTINCT member_casual, COUNT(member_casual) AS no_of_trips
FROM tripdata_all
GROUP BY member_casual;

-- ride_id: make sure all are length 16
SELECT LENGTH(ride_id) AS length_ride_id, COUNT(ride_id) AS no_of_rows
FROM tripdata_all
GROUP BY length_ride_id;

