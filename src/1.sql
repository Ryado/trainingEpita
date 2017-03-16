create database EPITA;

use EPITA;

DROP TABLE IF EXISTS epita.taxis_raw;
CREATE EXTERNAL TABLE epita.taxis_raw
(

	date_pickup string,
	date_dropoff string,
	passenger_count int,
	distance double,
	pickup_longitude double,
	pickup_latitude double,
	dropoff_longitude double,
	dropoff_latitude double,  
	total_amount double,
	neighborhood_pickup string,
	neighborhood_dropoff string


)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
LOCATION 'hdfs:///user/hdfs/taxis';


DROP TABLE IF EXISTS epita.taxis;
CREATE TABLE IF NOT EXISTS epita.taxis(
	date_pickup TIMESTAMP,
	date_dropoff TIMESTAMP,
	passenger_count int,
	distance double,
	pickup_longitude double,
	pickup_latitude double,
	dropoff_longitude double,
	dropoff_latitude double,  
	total_amount double,
	neighborhood_pickup string,
	neighborhood_dropoff string
  )
STORED AS ORC tblproperties ("orc.compress"="NONE");


INSERT OVERWRITE TABLE epita.taxis
SELECT

	from_unixtime(unix_timestamp(t.date_pickup,'yyyy-MM-dd HH:mm:ss')),
	from_unixtime(unix_timestamp(t.date_dropoff,'yyyy-MM-dd HH:mm:ss')),
	t.passenger_count,
	t.distance,
	t.pickup_longitude,
	t.pickup_latitude,
	t.dropoff_longitude,
	t.dropoff_latitude,  
	t.total_amount,
	t.neighborhood_pickup,
	t.neighborhood_dropoff

   
FROM  epita.taxis_raw as t;






	