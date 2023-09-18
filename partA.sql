--3140269 Εμμανουήλ Κουνδουράκης
--3160093 Θανάσης Μηλιώνης

/*Creating table credits*/
CREATE TABLE credits(
	casts varchar(1000000),
	crew varchar(1000000),
	id bigint);

/*Creating an auxiliary table and passing only the distinct elements from the base table*/
CREATE TABLE Credits2 AS SELECT DISTINCT id FROM Credits ;
 
ALTER TABLE Credits2
ADD COLUMN casts varchar(1000000),
ADD COLUMN crew varchar(1000000);


UPDATE Credits2
SET 
casts = Credits.casts,
crew = Credits.crew
from Credits
WHERE
	Credits.id=Credits2.id;
	

DROP TABLE Credits;--deleting base table
	
	
ALTER TABLE Credits2 RENAME TO Credits;


ALTER TABLE Credits ADD PRIMARY KEY (id);

--------------------------------------------------------------------------------------------------------------------------------------

/*creating table keywords */
create table keywords(
	id bigint,
       keywords varchar(10000)
);

/*creating the auxiliary table and passing the distinct values from the base table */
create table keywords2 AS SELECT DISTINCT id FROM keywords ;

 ALTER TABLE keywords2
ADD COLUMN keywords varchar(10000);

UPDATE keywords2
SET 
keywords = keywords.keywords
from keywords
WHERE
	keywords.id=keywords2.id;
	

drop table keywords;--deleting base table


ALTER TABLE Copy_keywords RENAME TO keywords;

ALTER TABLE keywords ADD PRIMARY KEY (id);
------------------------------------------------------------------------------------------------------------------------------------------
/*creating table links*/
create table links(
movieId int,
imdbId int,
tmdbId int
);


/*creating the auxiliary table links2 and passing the distinct values from base table links*/
create table links2 AS SELECT DISTINCT movieId,imdbId,tmdbId FROM links ;

drop table links;--deleting base table

ALTER TABLE links2 RENAME TO links;



ALTER TABLE links ADD PRIMARY KEY (movieId);

----------------------------------------------------------------------------------------------------------------------------------------------



--creating base table movies_metadata 
create table movies_metadata(
	adult varchar(6),
	belongs_to_collection varchar(10000),
	budget bigint,
	genres varchar(10000),
	homepage varchar(10000),
	id bigint,
	imdb_id varchar(1000),
	original_language varchar(4),
	original_title varchar(1000),
	overview varchar(10000),
	popularity real,
	poster_path varchar(100),
	production_companies varchar(10000),
	production_countries varchar(10000),
	release_date date,
	revenue bigint,
	runtime float,
	spoken_languages varchar (10000),
	status varchar(1000),
	tagline varchar(10000),
	title varchar(500),
	video varchar(100),
	vote_average float,
	vote_count int
);


--creating auxiliary table movies_metadata2 and passing the distinct values of id into it
create table movies_metadata2 AS SELECT DISTINCT id FROM movies_metadata ;


 ALTER TABLE movies_metadata2
ADD COLUMN adult varchar(6),
ADD COLUMN belongs_to_collection varchar(10000),
ADD COLUMN budget bigint,
ADD COLUMN genres varchar(10000),
ADD COLUMN homepage varchar(10000),
ADD COLUMN imdb_id varchar(1000),
ADD COLUMN original_language varchar(4),
ADD COLUMN original_title varchar(1000),
ADD COLUMN overview varchar(10000),
ADD COLUMN popularity real,
ADD COLUMN poster_path varchar(100),
ADD COLUMN production_companies varchar(10000),
ADD COLUMN production_countries varchar(10000),
ADD COLUMN release_date date,
ADD COLUMN revenue bigint,
ADD COLUMN runtime float,
ADD COLUMN spoken_languages varchar (10000),
ADD COLUMN status varchar(1000),
ADD COLUMN tagline varchar(10000),
ADD COLUMN title varchar(500),
ADD COLUMN video varchar(100),
ADD COLUMN vote_average float,
ADD COLUMN vote_count int;


--passing the rest of the columns of movies_metadata into movies_metadata2
UPDATE movies_metadata2
SET 
adult=movies_metadata.adult,
belongs_to_collection=movies_metadata.belongs_to_collection,
budget=movies_metadata.budget,
genres=movies_metadata.genres,
homepage =movies_metadata.homepage,
imdb_id =movies_metadata.imdb_id,
original_language =movies_metadata.original_language,
original_title =movies_metadata.original_title,
overview =movies_metadata.overview,
popularity =movies_metadata.popularity,
poster_path =movies_metadata.poster_path,
production_companies =movies_metadata.production_companies,
production_countries=movies_metadata.production_countries,
release_date =movies_metadata.release_date,
revenue =movies_metadata.revenue,
runtime =movies_metadata.runtime,
spoken_languages =movies_metadata.spoken_languages,
status =movies_metadata.status,
tagline=movies_metadata.tagline,
title =movies_metadata.title,
video =movies_metadata.video,
vote_average =movies_metadata.vote_average,
vote_count =movies_metadata.vote_count
from movies_metadata
WHERE
	movies_metadata.id=movies_metadata2.id;
	
drop table movies_metadata;--deleting base table

ALTER TABLE movies_metadata2 RENAME TO movies_metadata;--renaming auxiliary table to the name of base table


ALTER TABLE movies_metadata ADD PRIMARY KEY (id);

---------------------------------------------------------------------------------------------------------------------------------------------


create table ratings_small(
userId int,
movieId int,
rating float,
timestamp bigint
);

create table ratings_small2 AS SELECT DISTINCT userId,movieId, rating, timestamp FROM ratings_small ;

drop table ratings_small;--deleting base table

ALTER TABLE ratings_small2 RENAME TO ratings_small;





------------------------------------------------------------------------------------------------------------------------------------------
create table ratings(
userId int,
	movieId int,
	rating float,
	timestamp bigint
);

------------------------------------------------------------------------------------------------------------------------------------------

 ALTER TABLE Credits ADD FOREIGN KEY (id) REFERENCES movies_metadata(id);

 ALTER TABLE links ADD FOREIGN KEY (tmdbId) REFERENCES movies_metadata(id);

 ALTER TABLE keywords ADD FOREIGN KEY (id) REFERENCES movies_metadata(id);

 ALTER TABLE ratings_small ADD FOREIGN KEY (movieId) REFERENCES movies_metadata(id);
--------------------------------------------------------------------------------------------------------------------------------------------


DELETE FROM Credits 
where not exists
(SELECT * FROM movies_metadata
WHERE id = Credits.id );--deleted rows:0



DELETE FROM keywords 
where not exists
(SELECT * FROM movies_metadata
WHERE id = keywords.id );
 --deleted rows:0
 
 
 DELETE FROM links 
where not exists
(SELECT * FROM movies_metadata
WHERE id = links.tmdbId ) 
 ;--deleted rows: 380
 


 DELETE FROM ratings_small 
where not exists(
SELECT * FROM links,movies_metadata
WHERE ratings_small.movieId = links.tmdbId  AND movies_metadata.id = links.tmdbId  )
 ;--deleted rows: 55015
 




 
 

