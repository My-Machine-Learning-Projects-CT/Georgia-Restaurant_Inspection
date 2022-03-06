/* figure 2 */
/*find a restaurant(s) based on the conjunction of health inspection score and zipcode with  (0, 1 or both) of the following: restaurant name,  cuisine.
health inspection score-->inspection.totalscore
zipcode→restaurant.zipcode
restaurant name→restaurant.name
cuisine→ restaurant.cuisine & cuisines.cuisine
*/
    /*figure 2a*/
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



