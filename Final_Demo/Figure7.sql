
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
    LEFT OUTER JOIN    numFail
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
        WHERE i.totalscore<80 AND l.rid = i.rid    AND i.idate < '2016-01-01' AND i.idate >= '2015-01-01'
        GROUP BY i.rid;
/*get final result*/
    SELECT r.name AS restaurantName, r.street AS restStreet, 
        r.city AS restCity, r.state AS restState, r.zipcode AS restZipcode, c.numComplaints, c.complaintDescription, o.email, o.firstname, o.lastname,s.score
    FROM restaurant r , smaller s, complaintsMoreThan c, operatorowner o
    WHERE r.rid = s.rid and r.rid = c.rid and r.email = o.email;





