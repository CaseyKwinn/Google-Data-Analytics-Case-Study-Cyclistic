--Combine data together:

DROP TABLE IF EXISTS tripdata_all;

CREATE TABLE IF NOT EXISTS tripdata_all; AS (
  SELECT * FROM tripdata_jan; 
  UNION ALL
  SELECT * FROM tripdata_feb; 
  UNION ALL
  SELECT * FROM tripdata_mar; 
  UNION ALL
  SELECT * FROM tripdata_apr;
  UNION ALL
  SELECT * FROM tripdata_may;
  UNION ALL
  SELECT * FROM tripdata_jun;
  UNION ALL
  SELECT * FROM tripdata_jul; 
  UNION ALL
  SELECT * FROM tripdata_aug; 
  UNION ALL
  SELECT * FROM tripdata_sep; 
  UNION ALL
  SELECT * FROM tripdata_oct; 
  UNION ALL
  SELECT * FROM tripdata_nov; 
  UNION ALL
  SELECT * FROM tripdata_dec; 
);