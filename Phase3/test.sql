/*figure 1*/
/*The GRHI login screen is shown in Figure 1. Restaurant operators 
and state health inspectors can log into the system and are required 
to enter a password for the security of the database. Others who are 
just looking for restaurant inspection reports/scores can simply login in as a guest.*/

	/*Condition 1: the successful login should return a user name*/
	SELECT username
	FROM registereduser
	WHERE username = "chuney" AND password = "1234";
	/*Condition 2: otherwise, nothing is going to be returned*/
	SELECT username
	FROM registereduser
	WHERE username = "chuney" AND password = "1345";

/* figure 2 */
/*find a restaurant(s) based on the conjunction of health inspection score and zipcode with  (0, 1 or both) of the following: restaurant name,  cuisine.
health inspection score-->inspection.totalscore
zipcode→restaurant.zipcode
restaurant name→restaurant.name
cuisine→ restaurant.cuisine & cuisines.cuisine
*/
	/*show all the cuisines to the users*/
	SELECT *
	FROM cuisines;
	/*First, create a view specifying all the last inspection date of the restaurants*/
	CREATE OR REPLACE VIEW lastI AS
	 	SELECT i.rid AS rid, i.idate AS idate
		FROM inspection i
		WHERE NOT EXISTS
			(SELECT i.rid, i.idate
			FROM inspection b
			WHERE i.rid = b.rid AND i.idate < b.idate
			);
			
	/*Constraint 1.inspection score (less than or greater than)and zipcode*/
	SELECT  R.name AS Restaurant, R.street, R.city, R.state,R.zipcode, R.cuisine AS Cuisine,
	I.totalscore AS LastInspectionScore, I.idate AS LastInspectionDate
	FROM inspection I, restaurant R, lastI
	WHERE I.rid=R.rid AND lastI.idate = I.idate
	AND (I.totalscore >25) AND (R.zipcode=30339);
	
	/*Constraint 2.inspection score(less than or greater than) and zipcode and restaurant name*/
	SELECT  R.name AS Restaurant, R.street, R.city, R.state,R.zipcode, R.cuisine AS Cuisine,
	I.totalscore AS LastInspectionScore, I.idate AS LastInspectionDate
	FROM inspection I, restaurant R, lastI
	WHERE I.rid=R.rid AND lastI.idate = I.idate
	AND (I.totalscore >25) AND (R.zipcode=30339) AND (R.name = 'Heirloom');
	
	/*another example of constraint 2*/
	SELECT  R.name AS Restaurant, R.street, R.city, R.state,R.zipcode, R.cuisine AS Cuisine,
	I.totalscore AS LastInspectionScore, I.idate AS LastInspectionDate
	FROM inspection I, restaurant R, lastI
	WHERE I.rid=R.rid AND lastI.idate = I.idate
	AND (I.totalscore >25) AND (R.zipcode=30080) AND (R.name = 'Mezza Luna');
	
	/*Constraint 3.inspection score(less than or greater than) and zipcode and cuisine*/
	SELECT R.name AS Restaurant, R.street, R.city, R.state,R.zipcode, R.cuisine AS Cuisine,
	I.totalscore AS LastInspectionScore, I.idate AS LastInspectionDate
	FROM inspection I, restaurant R, lastI
	WHERE I.rid=R.rid AND lastI.idate = I.idate
	AND (I.totalscore >25) AND (R.cuisine = "Chinese") AND (R.zipcode=30339);
	
	/*Constraint 4.inspection score(less than or greater than) and zipcode and cuisine and restaurant name*/
	SELECT  R.name AS Restaurant, R.street, R.city, R.state,R.zipcode, R.cuisine AS Cuisine,
	I.totalscore AS LastInspectionScore, I.idate AS LastInspectionDate
	FROM inspection I, restaurant R, lastI
	WHERE I.rid=R.rid AND lastI.idate = I.idate
	AND (I.totalscore >25) AND (R.cuisine = "American") AND (R.zipcode=30318) AND (R.name = "Bocado");
	
	
/*Figure 3*/
/*allows a user to enter food/safety complaint information about a restaurant. */
/*show user all the available restaurants frst*/
	SELECT *
	FROM restaurant;
/*Note: customer need to exist first*/
/*When inserting a customer, make sure the phone num is unique in db*/
	INSERT INTO customer
	VALUES ('1234567890', 'aaa', 'bbb');
/*When inserting a customer, make sure the phone num exist*/
	INSERT INTO complaint
	VALUES ('1', '1234567890', '2015-08-19', 'TESTING INSERT COMPLAINT');


/*Figure 4 */
/*Operator insert information about their restaurant*/
/*show users all the cuisines*/
	SELECT *
	FROM cuisines;
/*when inserting into a restaurant, make sure RID is unique and cuisine type is legal and email*/
	INSERT INTO restaurant
	VALUES (21,4041234567, "Elephant Bar", "Fulton", "245 North Ave", "Atlanta", "GA", 30332, "American", "ppatel@gmail.com");


/*Figure 5a*/ 
/*the user(operator) will select the
 search criteria from a dropdown that lists
  all the restaurant information associated with him/her.*/
	SELECT R.rid, R.name, R.street, R.city, R.state, R.zipcode
	FROM operatorowner O, restaurant R
	WHERE R.email=O.email AND O.username = "ppatel";
	

/*Figure 5b*/
/*get health inspection report results for the last two inspections */
CREATE OR REPLACE VIEW theRestaurantIns AS 
	SELECT i.idate, it.itemnum, it.description, c.score, i.totalscore, i.passfail
	FROM containing AS c, item AS it, inspection AS i
	WHERE i.rid = 19 AND c.idate = i.idate AND c.rid = i.rid AND it.itemnum = c.itemnum;
/*find the last inspection*/
CREATE OR REPLACE VIEW lastI AS
	SELECT i.idate,  i.itemnum, i.description, i.score, i.totalscore, i.passfail
	FROM theRestaurantIns i
	WHERE NOT EXISTS
			(SELECT i.idate
			FROM theRestaurantIns b
			WHERE i.idate < b.idate
			);
/*find the inspections without the last one*/
CREATE OR REPLACE VIEW nolastI AS
	SELECT DISTINCT allI.idate,  allI.itemnum, allI.description, allI.score, allI.totalscore, allI.passfail
	FROM lastI i, theRestaurantIns allI
	WHERE i.idate > allI.idate;
/*find the inspections with the second last one*/
CREATE OR REPLACE VIEW secLastI AS
	SELECT DISTINCT i.idate,  i.itemnum, i.description, i.score, i.totalscore, i.passfail
	FROM nolastI i
	WHERE NOT EXISTS
			(SELECT i.idate
			FROM nolastI b
			WHERE i.idate < b.idate
			);
/*	finally we get the last 2 idate*/
	SELECT DISTINCT i.idate AS InspectionDate, i.itemnum AS ItemNumber, i.description AS ItemDescription, i.score AS Score,
	 i.passfail AS Result, i.totalscore AS TotalScore
	FROM theRestaurantIns i, secLastI, lastI
	WHERE i.idate = lastI.idate OR i.idate = secLastI.idate;


/*Figure 6a*/
/*inserting a restaurant inspection report*/
/* first show the user all the items with discreption*/
	SELECT i.itemnum AS ItemNumber, i.description AS ItemDescription, i.critical AS Critical
	FROM item i;
/*before insert into containing make sure the inespction report exist*/
/*before creating the inspection report, make sure rid idate combination is unique and iid exists*/
	INSERT INTO inspection
	VALUES (2, 2, "2015-7-7", 100, "PASS");
/*before insert into containing make sure the rid idate combination exists, make sure 1to8 < 9(perfect score), 9to15<4(perfect score)*/
	INSERT INTO containing
	VALUES (1, 2, "2015-7-7", 9);
	INSERT INTO containing
	VALUES (2, 2, "2015-7-7", 9);
	INSERT INTO containing
	VALUES (3, 2, "2015-7-7", 9);
	INSERT INTO containing
	VALUES (4, 2, "2015-7-7", 9);
	INSERT INTO containing
	VALUES (5, 2, "2015-7-7", 9);
	INSERT INTO containing
	VALUES (6, 2, "2015-7-7", 9);
	INSERT INTO containing
	VALUES (7, 2, "2015-7-7", 9);
	INSERT INTO containing
	VALUES (8, 2, "2015-7-7", 9);
	INSERT INTO containing
	VALUES (9, 2, "2015-7-7", 4);
	INSERT INTO containing
	VALUES (10, 2, "2015-7-7", 4);
	INSERT INTO containing
	VALUES (11, 2, "2015-7-7", 4);
	INSERT INTO containing
	VALUES (12, 2, "2015-7-7", 4);
	INSERT INTO containing
	VALUES (13, 2, "2015-7-7", 4);
	INSERT INTO containing
	VALUES (14, 2, "2015-7-7", 4);
	INSERT INTO containing
	VALUES (15, 2, "2015-7-7", 4);


/*Figure 6b*/
/*In figure 6b, an Inspector can enter additional comments about the observed 
condition of any item on the inspection list. 
He/she will enter Inspector ID, Restaurant ID, Date and Item number with associated Comments.*/
/*make sure the itemnum is unique. rid and iid combination is unique*/
	INSERT INTO includes
	VALUES (1, 16, "2015-3-18", "Eggs are rotten!");
`

/*figure 7a*/
/*In figure 7a, an inspector can run a summary report about restaurant inspections 
for a specified month and year. The summary data is organized by County and Cuisine in sorted order.*/
	CREATE OR REPLACE VIEW numRest AS
		SELECT r.county, r.cuisine, COUNT(*) AS NumOfRestaurantInspected
		FROM restaurant r, inspection i
		WHERE (r.rid = i.rid) AND (i.idate < '2015-12-01') AND (i.idate >= '2015-01-01') 
		GROUP BY r.county,  r.cuisine;
	CREATE OR REPLACE VIEW numFail AS
		SELECT  r.county, r.cuisine, COUNT(*) AS NumFail
		FROM restaurant r, inspection i
		WHERE (r.rid = i.rid) AND (i.idate < '2015-12-01') AND (i.idate >= '2015-01-01') AND  (i.passfail = "FAIL")
		GROUP BY r.county, r.cuisine;
/*this has all the result except the grandtotal*/
/*if the county with the cuisine has no inspection fail, the NumFail column will be NULL*/
/*CREATE OR REPLACE VIEW raw7a AS*/
	SELECT numRest.county, numRest.cuisine, numRest.NumOfRestaurantInspected, numFail.NumFail
	FROM numRest
	LEFT OUTER JOIN	numFail
	ON numRest.county = numFail.county AND numRest.cuisine = numFail.cuisine;
/*count all the fails*/
	CREATE OR REPLACE VIEW totalFail AS 
		SELECT count(*) AS NumFail
		FROM restaurant r, inspection i
		WHERE (r.rid = i.rid) AND (i.idate < '2015-12-01') AND (i.idate >= '2015-01-01') AND  (i.passfail = "FAIL");
/*count all the inspections*/
	CREATE OR REPLACE VIEW totalInspected AS 
		SELECT COUNT(*) AS NumOfRestaurantInspected
		FROM restaurant r, inspection i
		WHERE (r.rid = i.rid) AND (i.idate < '2015-12-01') AND (i.idate >= '2015-01-01');
/*combine the grandtotal and display*/
/*CREATE OR REPLACE VIEW grandTotal */
	SELECT totalInspected.NumOfRestaurantInspected AS TotalNumOfRestaurantInspected,totalFail.NumFail AS TotalNumFail
	FROM totalInspected, totalFail;
/*count sub fails num*/
	CREATE OR REPLACE VIEW SubNumFail AS
		SELECT  r.county AS County, COUNT(*) AS SubNumFail
		FROM restaurant r, inspection i
		WHERE (r.rid = i.rid) AND (i.idate < '2015-12-01') AND (i.idate >= '2015-01-01') AND  (i.passfail = "FAIL")
		GROUP BY r.county;
/*count sub inspected num*/
	CREATE OR REPLACE VIEW SubNumInspected AS
		SELECT r.county AS County, COUNT(*) AS SubNumInspected
		FROM restaurant r, inspection i
		WHERE (r.rid = i.rid) AND (i.idate < '2015-12-01') AND (i.idate >= '2015-01-01')
		GROUP BY r.county;
/*this is all the subtotal results*/
	SELECT i.County, i.SubNumInspected, f.SubNumFail
	FROM SubNumInspected i, SubNumFail f
	WHERE i.County = f.County;


/*figure 7b*/
/*an inspector can run a summary report about restaurant inspections for a specified county and year.*/
	SELECT R.county AS County, MONTHNAME(S.idate) AS Month,COUNT(R.rid) AS RestaurantInspected
	FROM restaurant R, inspection S
	Where (S.rid=R.rid) AND (R.county="Fulton")
	AND (YEAR(S.idate)=2015)
	GROUP BY MONTH(S.idate),R.rid;
/*count grandtotal of restaurant has been inspected in the year*/
	SELECT R.county AS County, COUNT(R.rid) AS TotalInspected
	FROM restaurant R, inspection S
	Where (S.rid=R.rid) AND (R.county="Fulton")
	AND (YEAR(S.idate)=2015);


/*figure 7c*/
	SELECT r.cuisine AS Cuisine, r.name, r.street, r.city, r.state, r.zipcode, MAX(i.totalscore) AS InspectionScore
	FROM restaurant r, inspection i
	WHERE (r.rid = i.rid) AND (i.idate < '2015-12-01') AND (i.idate >= '2015-01-01') 
	GROUP BY  r.cuisine;


/*figure 7d*/
/*count the complaints*/
	CREATE OR REPLACE VIEW countComplaint AS
		SELECT c.rid AS rid, COUNT(*) AS numComplaints
		FROM complaint c
		GROUP BY c.rid;
/*select complaints more than some number*/
	CREATE OR REPLACE VIEW complaintsMoreThan AS
		SELECT c.rid AS rid, c.numComplaints AS numComplaints, complaint.description AS complaintDescription
		FROM countComplaint c, complaint
		WHERE c.rid = complaint.rid AND c.numComplaints > 1;
/*a less than perfect score was given on at least one critical item*/
	CREATE OR REPLACE VIEW lessThanPerfectCritical AS
		SELECT i.rid, c.score, it.perfectscore
		FROM inspection i, containing c, item it
		WHERE i.rid = c.rid AND i.idate = c.idate AND 
		c.itemnum = it.itemnum AND it.critical = 'Y' AND c.score < it.perfectscore;
/*select total score smaller than some number from the last inspection report
in a specific year
 where a less than perfect score was given on at least one critical item*/
	CREATE OR REPLACE VIEW smaller AS
	 	SELECT i.rid AS rid, MAX(i.idate) AS idate, i.totalscore AS score
		FROM inspection i, lessThanPerfectCritical l
		WHERE i.totalscore<80 AND l.rid = i.rid	AND i.idate < '2016-01-01' AND i.idate >= '2015-01-01'
		GROUP BY i.rid;
/*get final result*/
	SELECT r.name AS restaurantName, r.street AS restStreet, 
		r.city AS restCity, r.state AS restState, r.zipcode AS restZipcode, c.numComplaints, c.complaintDescription, o.email, o.firstname, o.lastname,s.score
	FROM restaurant r , smaller s, complaintsMoreThan c, operatorowner o
	WHERE r.rid = s.rid and r.rid = c.rid and r.email = o.email;



