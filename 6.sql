# List the films where the yr is 1962 [Show id, title]
SELECT id, title
    FROM movie
        WHERE yr=1962;

# Give year of 'Citizen Kane'
SELECT yr FROM movie
    WHERE title='Citizen Kane';

# List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id,title,yr FROM movie
    WHERE title LIKE'%Star Trek%'
        ORDER BY title;

# What id number does the actor 'Glenn Close' have?
SELECT id FROM actor
    WHERE name='Glenn Close';   

# What is the id of the film 'Casablanca'
SELECT id FROM movie
    WHERE title='Casablanca';

# Obtain the cast list for 'Casablanca'.
SELECT name
    FROM actor JOIN casting ON (id=actorid)
        WHERE movieid=11768;

# Obtain the cast list for the film 'Alien'
SELECT name
    FROM actor JOIN casting ON (actor.id=casting.actorid)
        WHERE casting.movieid=(
            SELECT id FROM movie
                WHERE title='Alien');

# List the films in which 'Harrison Ford' has appeared
SELECT title FROM movie
    JOIN casting ON (movie.id=movieid)
        JOIN actor ON (actor.id=casting.actorid)
            WHERE name='Harrison Ford';

# Harrison Ford as a supporting actor
SELECT title FROM movie
    JOIN casting ON (id=movieid)
        JOIN actor ON (casting.actorid=actor.id)
            WHERE ord != 1 
                AND name='Harrison Ford';

# List the films together with the leading star for all 1962 films.
SELECT title, name FROM movie
    JOIN casting ON (movie.id=casting.movieid)
        JOIN actor ON (casting.actorid=actor.id)
            WHERE ord = 1
                AND yr=1962;

# Busy years for John Travolta
SELECT yr,COUNT(title) FROM movie
    JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
    WHERE name='John Travolta'
    GROUP BY yr
    HAVING COUNT(title)=(SELECT MAX(c) FROM
    (SELECT yr,COUNT(title) AS c FROM movie
        JOIN casting ON movie.id=movieid
        JOIN actor ON actorid=actor.id
    WHERE name='John Travolta'
    GROUP BY yr) AS t);

# Lead actor in Julie Andrews movies
SELECT title, name FROM movie
    JOIN casting ON (movie.id=casting.movieid)
    JOIN actor ON (casting.actorid=actor.id)
    WHERE movieid IN (
        SELECT casting.movieid  FROM  movie
        JOIN casting ON movie.id=casting.movieid
        JOIN actor  ON actorid=actor.id
        WHERE actor.name='Julie Andrews') AND ord = 1;

# Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT name FROM actor 
    JOIN casting ON (actor.id=casting.actorid)
    WHERE ord=1
    GROUP BY name HAVING COUNT(movieid)>=30
    ORDER BY name;

# List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(actorid) FROM movie
    JOIN casting ON (movie.id=casting.movieid)
    WHERE yr=1978
    GROUP BY title
    ORDER BY COUNT(actorid) DESC, title;

# List all the people who have worked with 'Art Garfunkel'.
SELECT name FROM actor 
    JOIN casting ON (id=actorid)
    WHERE movieid IN (
        SELECT movieid FROM casting
        JOIN actor ON (actorid=id)
        WHERE name='Art Garfunkel'
    ) AND actor.name!='Art Garfunkel';
