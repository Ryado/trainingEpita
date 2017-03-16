select * from epita.taxis;


#Conmpter le nombre de courses par neighborhood

SELECT neighborhood_pickup, count(*) as cnt
FROM epita.taxis
GROUP BY neighborhood_pickup 


-- # moyen de passagers

select avg (passenger_count) from epita.taxi


-- prix moyen de la course, prix max, prix min

select avg (total_amount) as avg, min (total_amount) as min, max (total_amount) as max from epita.taxis


-- # de Courses impliquant un Aéroport

SELECT neighborhood_pickup, count(*) as cnt
FROM epita.taxis
WHERE neighborhood_pickup like "%Airport%"
GROUP BY neighborhood_pickup 


-- Ou vont les gens qui arrivent à JFK ?

SELECT neighborhood_dropoff, count(*) as cnt
FROM epita.taxis
WHERE neighborhood_pickup like "John F. Kennedy International Airport"
GROUP BY neighborhood_dropoff 
ORDER BY cnt DESC

-- Quel est le plus gros aéoroport (en terme de passagers) ?

SELECT neighborhood_pickup, sum(passenger_count) as passenger_cnt
FROM epita.taxis
WHERE neighborhood_pickup like "%Airport%" 
GROUP BY neighborhood_pickup 


-- La semaine new-yorkaise: à conaitre -> cast(date_pickup as date) as dt
SELECT 
cast(date_pickup as date) as dt,
from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u') as dayOfWeek,
count(*)
FROM epita.taxis
GROUP BY cast(date_pickup as date),
from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u') 
ORDER BY dt, dayOfWeek


-- Les semaines utile -> weekofyear(date_pickup)

select weekofyear(date_pickup) as week, count(*) as cnt
from epita.taxis 
GROUP by weekofyear(date_pickup)
ORDER BY week



-- Count par jour de la semaine Jour de la semaine -> Utile la fonction from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u')

SELECT from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u') as dayOfWeek, count(*)
FROM epita.taxis
GROUP BY from_unixtime(unix_timestamp(date_pickup,'yyyyMMdd'),'u')


-- Trouver les 10 trajets les plus rentables ainsi que leur distances moyennes

SELECT concat(neighborhood_pickup," -> " , neighborhood_dropoff) as trajet, avg(distance) as dist_moyenne, sum(total_amount) as somme
FROM epita.taxis
GROUP BY neighborhood_pickup, neighborhood_dropoff
ORDER BY somme DESC
LIMIT 10


-- Trouver les 10 courses les plus longues ainsi que leur cout

SELECT concat(neighborhood_pickup," -> " , neighborhood_dropoff) as trajet, distance as dist, total_amount as cout
FROM epita.taxis
ORDER BY dist DESC
LIMIT 10


-- Trouver les 10 trajets moyens les plus longs ainsi que leur cout moyen

SELECT concat(neighborhood_pickup," -> " , neighborhood_dropoff) as trajet, avg(distance) as dist, avg(total_amount) as cout
FROM epita.taxis
GROUP BY neighborhood_pickup , neighborhood_dropoff
ORDER BY dist DESC
LIMIT 10




