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

            
/*    finally we get the last 2 idate*/
    SELECT DISTINCT i.idate AS InspectionDate, i.itemnum AS ItemNumber, i.description AS ItemDescription, i.score AS Score,
     i.passfail AS Result, i.totalscore AS TotalScore
    FROM theRestaurantIns i, secLastI, lastI
    WHERE i.idate = lastI.idate OR i.idate = secLastI.idate;


