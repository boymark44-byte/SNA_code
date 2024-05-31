-- Main Query 
SELECT initiatorid, tltype, receiverid, ts
FROM timeline 
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
	AND schoolid = '128081'; 
	
SELECT initiatorid, receiverid, reactor, reaction, ts
FROM reactions
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28';

SELECT initiatorid, receiverid, commenter, ts
FROM comments
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28';

SELECT participantid, roomid, ts
FROM onlineclass
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'; 


-- Using FULL JOIN Part II: personid is present on either the initiatorid or receiverid
WITH timeline AS (
	SELECT initiatorid, receiverid, tltype, ts
	FROM timeline 
	WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
		AND schoolid = '128081'
), 

reactions AS (
	SELECT initiatorid, receiverid, reactor, reaction, ts
	FROM reactions
	WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
),

comments AS (
	SELECT initiatorid, receiverid, commenter, ts
	FROM comments
	WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
),

processmining AS (
	SELECT personid, type_, ts
	FROM processmining
	WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
)

SELECT 
	COALESCE(t.initiatorid, r.initiatorid, c.initiatorid, p.personid) AS initiatorid,
	COALESCE(t.receiverid, r.receiverid, c.receiverid) AS receiverid,
	t.tltype, 
	r.reactor, 
	r.reaction, 
	c.commenter, 
	p.type_, 
	COALESCE(t.ts, r.ts, c.ts, p.ts) AS ts
FROM timeline t
FULL JOIN reactions r ON t.initiatorid = r.initiatorid AND t.receiverid = r.receiverid AND t.ts = r.ts
FULL JOIN comments c ON COALESCE(t.initiatorid, r.initiatorid) = c.initiatorid AND COALESCE(t.receiverid, r.receiverid) = c.receiverid AND COALESCE(t.ts, r.ts) = c.ts
FULL JOIN processmining p ON COALESCE(t.initiatorid, r.initiatorid, c.initiatorid) = p.personid AND COALESCE(t.ts, r.ts, c.ts) = p.ts;



-- Explore the timeline table 
SELECT * 
FROM timeline 
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'; 

SELECT DISTINCT tltype
FROM timeline
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'; 

SELECT DISTINCT schoolid
FROM timeline
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28';

SELECT *
FROM timeline
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
AND LEFT(initiatorid, 1) = 'A';

SELECT *
FROM timeline
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
AND LEFT(receiverid, 1) = 'A';

SELECT *
FROM timeline
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
AND LEFT(initiatorid, 1) = 'F';

SELECT *
FROM timeline
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
AND LEFT(receiverid, 1) = 'F';

SELECT *
FROM timeline
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
AND LEFT(initiatorid, 1) = 'S';

SELECT *
FROM timeline
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
AND LEFT(receiverid, 1) = 'S';

SELECT *
FROM timeline
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'
AND LEFT(initiatorid, 1) = 'P';



-- Exploring the reactions table
SELECT * 
FROM reactions 
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'; 

SELECT initiatorid, receiverid, reactor, reaction, ts
FROM reactions
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28';

SELECT DISTINCT reaction
FROM reactions
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28';



-- Exploring the comments table
SELECT * 
FROM comments
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28';

SELECT initiatorid, receiverid, commenter, ts
FROM comments
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28';



-- Exploring the onlineclass table
SELECT *
FROM onlineclass
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28';

SELECT roomid, participantid, ts
FROM onlineclass
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28'; 

SELECT DISTINCT roomid
FROM onlineclass
WHERE ts BETWEEN '2020-10-05' AND '2021-02-28';


-- Exploring the person table
SELECT * 
FROM person;



