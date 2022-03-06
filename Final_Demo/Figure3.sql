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