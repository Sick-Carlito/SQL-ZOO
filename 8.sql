# How many stops are in the database.
SELECT COUNT(id) FROM stops;

# Find the id value for the stop 'Craiglockhart'
SELECT id FROM stops
    WHERE name='Craiglockhart'; 

# Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id,name FROM stops
    JOIN route ON (stop=id)
    WHERE num='4' AND company='LRT';

# Routes and stops
SELECT company, num, COUNT(*) FROM route 
    WHERE stop=149 OR stop=53
    GROUP BY company,num
    HAVING COUNT(*)=2;

# Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop FROM route a
    JOIN route b ON (a.company=b.company AND a.num=b.num)
    WHERE a.stop=53 AND b.stop=149;

# Change the query so that the services between 'Craiglockhart' and 'London Road' are shown
SELECT a.company, a.num, stopa.name, stopb.name FROM route a
    JOIN route b ON (a.company=b.company AND a.num=b.num)
    JOIN stops stopa ON (a.stop=stopa.id)
    JOIN stops stopb ON (b.stop=stopb.id)
    WHERE stopa.name='Craiglockhart' AND stopb.name='London Road';

# Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company,a.num FROM route a
    JOIN route b ON(a.company=b.company AND a.num=b.num)
    WHERE a.stop=115 AND b.stop=137;

# Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT a.company, b.num FROM route a
    JOIN route b ON (a.company=b.company AND a.num=b.num)
    JOIN stops stopa ON(a.stop=stopa.id)
    JOIN stops stopb ON(b.stop=stopb.id)
    WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross'

# Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company
SELECT distinct stopb.name, b.company, b.num FROM route a 
    JOIN route b ON (a.company=b.company AND a.num=b.num)
    JOIN stops stopa ON (a.stop=stopa.id)
    JOIN stops stopb ON (b.stop=stopb.id)
    WHERE stopa.name='Craiglockhart' AND b.company='LRT'   

# Find the routes involving two buses that can go from Craiglockhart to Lochend. Show the bus no
SELECT DISTINCT(a.num), a.company, transita.name, c.num, c.company
    FROM route a
    JOIN route b ON a.num = b.num AND a.company = b.company
    JOIN (route c JOIN route d ON c.num = d.num AND c.company = d.company)
    JOIN stops start ON a.stop = start.id
    JOIN stops transita ON b.stop = transita.id
    JOIN stops transitb ON c.stop = transitb.id
    JOIN stops stop ON d.stop = stop.id
    WHERE start.name = 'Craiglockhart'
    AND stop.name = 'Lochend'
    AND transita.name = transitb.name
    ORDER BY LENGTH(a.num), b.num, transita.id, LENGTH(c.num), d.num;
