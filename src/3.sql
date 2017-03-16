-- Parquet

DROP TABLE IF EXISTS epita.taxis_parquet;
CREATE TABLE IF NOT EXISTS epita.taxis_parquet(
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
STORED AS PARQUET;


INSERT OVERWRITE TABLE epita.taxis_parquet
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
