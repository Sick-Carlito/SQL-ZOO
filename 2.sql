-- 1) Winners from 1950
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- 2) 1962 Literature
SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature';

-- 3) Albert Einstein
SELECT yr, subject FROM nobel
WHERE winner IN ('Albert Einstein');

-- 4) Recent Peace Prizes
SELECT winner FROM nobel
WHERE yr >= 2000
AND subject IN ('Peace'); 

-- 5) Literature in the 1980's
SELECT yr, subject, winner FROM nobel
WHERE yr BETWEEN 1980 AND 1989
AND subject = 'Literature';

-- 6) Only presidents
SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                 'Woodrow Wilson',
                 'Jimmy Carter',
                 'Barack Obama'
                );

-- 7) John
SELECT winner FROM nobel 
WHERE winner LIKE 'John%';

-- 8) Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT yr, subject, winner FROM nobel
WHERE (subject = 'Physics' AND yr = '1980')
OR (subject = 'Chemistry' AND yr = '1984');

-- 9) Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
SELECT * FROM nobel
WHERE yr = '1980' 
AND subject NOT IN ('Chemistry', 'Medicine');

-- 10) Early Medicine, Late Literature
SELECT * FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910)
OR (subject = 'Literature' AND yr >= 2004);

-- 11) Find all details of the prize won by PETER GRÜNBERG
SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG';

-- 12) Find all details of the prize won by EUGENE O'NEILL
SELECT * FROM nobel
WHERE winner = 'EUGENE O\'NEILL'';
-- 13) List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT * FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner ASC;
-- 14) Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last. 
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject,winner