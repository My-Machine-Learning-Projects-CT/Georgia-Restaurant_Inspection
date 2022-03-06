/*Figure 4 */
/*Operator insert information about their restaurant*/
/*show users all the cuisines*/
    SELECT *
    FROM cuisines;
/*when inserting into a restaurant, make sure RID is unique and cuisine type is legal and email*/
    INSERT INTO restaurant
    VALUES (21,4041234567, "Elephant Bar", "Fulton", "245 North Ave", "Atlanta", "GA", 30332, "American", "ppatel@gmail.com");
