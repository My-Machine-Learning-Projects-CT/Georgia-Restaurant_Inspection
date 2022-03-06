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