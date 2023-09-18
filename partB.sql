--3140269 Εμμανουήλ Κουνδουράκης
--3160093 Θανάσης Μηλιώνης

/*movies per year*/
Select  extract (year from release_date),count (*) from movies_metadata
group by  extract (year from release_date)
order by  extract (year from release_date);

-------------------------------------------------------------------------------------------------------------------------------------------

UPDATE movies_metadata
SET genres = REPLACE(genres,E'\'', E'\"') ;

alter table movies_metadata --altering column genres datatype to json
alter column genres type json
USING genres::json ;



/*movies per genre*/
SELECT y.x->'name' "name", COUNT(id)
FROM movies_metadata
CROSS JOIN LATERAL (SELECT jsonb_array_elements(movies_metadata.genres::jsonb) x) y
GROUP BY y.x;


-------------------------------------------------------------------------------------------------------------------------------------------


/*movies per year and genre*/
Select distinct extract (year from release_date),y.x->'name' "name",COUNT(id)
from movies_metadata
CROSS JOIN LATERAL (SELECT jsonb_array_elements(movies_metadata.genres::jsonb) x) y
group by  extract (year from release_date),y.x
order by  extract (year from release_date) ;



-------------------------------------------------------------------------------------------------------------------------------------------


/*average rating per genre*/
SELECT y.x->'name' "name", avg(vote_average)
FROM movies_metadata
CROSS JOIN LATERAL (SELECT jsonb_array_elements(movies_metadata.genres::jsonb) x) y
GROUP BY y.x;



-------------------------------------------------------------------------------------------------------------------------------------------
/*number of ratings per user*/
Select distinct (userId),count (rating) from ratings_small
group by  userId
order by  userId;



-------------------------------------------------------------------------------------------------------------------------------------------
/*average rating per user*/
Select distinct (userId),avg (rating) from ratings_small
group by  userId
order by  userId;



-------------------------------------------------------------------------------------------------------------------------------------------


/*creating the view*/
create view Statistics as
Select distinct (userId),count (rating), avg (rating) from ratings_small
group by userId
order by userId;


