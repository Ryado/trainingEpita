select * from epita.taxis;


#Conmpter le nombre de courses par neighborhood

SELECT neighborhood_pickup, count(*) as cnt
FROM epita.taxis
GROUP BY neighborhood_pickup 


# # de Courses impliquant un Aéroport

SELECT neighborhood_pickup, count(*) as cnt
FROM epita.taxis
WHERE neighborhood_pickup like "%Airport%"
GROUP BY neighborhood_pickup 


# Ou vont les gens qui arrivent à JFK ?

SELECT neighborhood_dropoff, count(*) as cnt
FROM epita.taxis
WHERE neighborhood_pickup like "John F. Kennedy International Airport"
GROUP BY neighborhood_dropoff 
ORDER BY cnt DESC



# La semaine new-yorkaise: à conaitre -> cast(date_pickup as date) as dt
SELECT 
cast(date_pickup as date) as dt,
from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u') as dayOfWeek,
count(*)
FROM epita.taxis
GROUP BY cast(date_pickup as date),
from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u') 
ORDER BY dt, dayOfWeek


# Les semaines utile -> weekofyear(date_pickup)

select weekofyear(date_pickup) as week, count(*) as cnt
from epita.taxis 
GROUP by weekofyear(date_pickup)
ORDER BY week



# Count par jour de la semaine Jour de la semaine -> Utile la fonction from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u')

SELECT from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u') as dayOfWeek, count(*)
FROM epita.taxis
GROUP BY from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u')


