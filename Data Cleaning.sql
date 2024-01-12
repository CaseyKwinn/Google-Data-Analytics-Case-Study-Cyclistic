-- Data Cleaning

-- DROP TABLE IF EXISTS tripdata_clean;

CREATE TABLE IF NOT EXISTS tripdata_clean AS (
  SELECT 
    a.ride_id, rideable_type, started_at, ended_at, 
    ride_duration,
    CASE EXTRACT(DOW FROM started_at) 
      WHEN 0 THEN 'SUN'
      WHEN 1 THEN 'MON'
      WHEN 2 THEN 'TUES'
      WHEN 3 THEN 'WED'
      WHEN 4 THEN 'THURS'
      WHEN 5 THEN 'FRI'
      WHEN 6 THEN 'SAT'    
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name, end_station_name, 
    start_lat, start_lng, end_lat, end_lng, member_casual
  FROM tripdata_all a
  JOIN (
    SELECT ride_id, (
      EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
      EXTRACT(MINUTE FROM (ended_at - started_at)) +
      EXTRACT(SECOND FROM (ended_at - started_at)) / 60) AS ride_duration
    FROM tripdata_all
  ) b 
  ON a.ride_id = b.ride_id
  WHERE 
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    ride_duration > 1 AND ride_duration < 1440
);

-- Count num rows
SELECT COUNT(*)       -- returned 4,291,960 rows so 1,375,757 rows removed
FROM tripdata_clean;

--recheck for duplicate values
SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM tripdata_clean; --return 0, so no duplicates

--recheck for null values
SELECT COUNT(*) - COUNT(ride_id) ride_id,
 COUNT(*) - COUNT(rideable_type) rideable_type,
 COUNT(*) - COUNT(started_at) started_at,
 COUNT(*) - COUNT(ended_at) ended_at,
 COUNT(*) - COUNT(start_lat) start_lat,
 COUNT(*) - COUNT(start_lng) start_lng,
 COUNT(*) - COUNT(end_lat) end_lat,
 COUNT(*) - COUNT(end_lng) end_lng,
 COUNT(*) - COUNT(member_casual) member_casual
FROM tripdata_all; --return 0 for all columns, so no null values