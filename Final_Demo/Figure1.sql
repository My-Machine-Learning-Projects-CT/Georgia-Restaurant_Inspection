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
