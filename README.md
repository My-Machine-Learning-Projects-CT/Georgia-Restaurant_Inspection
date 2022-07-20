# Project: Georgia Restaurant Inspection
 Please refer to RestaurantInspection_v1.2.pdf for the project guidelines

## Project Progress Logs
Below are notes of all activities throughout the duration of the project.

### 5/30/2015
Finished IFD
Ask TA for verification and EER diagram help to be contd

### 5/31/2015
ER diagram on drive started by Christine

### 6/1/2015
Arnav attended TA office hours from 2:30 - 6 pm. Main focus on EER.
1.	Criteria should not be an entity. Instead, criteria is used for our SQL query statements.
2.	“Restaurant list” as an entity is not needed. 
3.	Regarding users of the database, restaurant operators and inspectors require username and password to access database as registered users while customers don’t. So we can have two superclasses: registered users whose subclasses are restaurant operators and inspectors, and guests (a.k.a customer).
4.	A customer must create a complaint in order to be logged into the database. A complaint must be made. Many customers can complain about the same thing just as many complaints can be made by a customer. Complaint is a weak entity type with description, and Date as a partial key attribute; complaint is related to customer and the restaurant. 
5.	Major changes from above added to EER. Will add necessary attributes to each entity later.

### 6/2/2015
By Christine
1.	change customers to customer
2.	change customer to weak entity type
3.	Attribute added

### 6/3/2015
TA suggested that for each GUI, we create an IFD. 
If you want to learn SQL quickly and easily, go to http://www.w3schools.com/sql/default.asp
Questions to ask TAs:
1.	“Detailed Descriptions+Scores” as one single attribute?

### 6/4/2015
Proposing the following assumptions (let’s make a list over here for now which we can add on to):
1.	Inspections occur annually for all the restaurants. 
2.	Upon creating a restaurant, restaurant won’t have an inspection until a year after being in service.
3.	Upon being hired as a restaurant inspector, the inspector won’t immediately start inspecting restaurants (only in the beginning of the job for a very small amount of time, an inspector would have 0 inspection reports filed).
4.	Enter any assumptions starting here.
Need to start creating list of constraints as well.
 
### 6/9/2015
submitted phase 1

### 6/13/2015
started mapping EER
Ask TA: how to map derived attributes

### 6/24/2015
Arnav created all SQL statements which will be checked during office hours.

### 7/17/2015
Learn PHP
GUIs needed coding
1.	guest restaurant search
2.	guest restaurant results display
3.	guest enter food/safety complaint
4.	operator enter restaurant info 
5.	operator restaurant health inspection search
6.	operator restaurant health inspection search results
7.	inspector input of inspection report, comment on specific items
8.	inspector display report of restaurant inspections for specified month and year organized by county and cuisine in sorted order.
9.	Inspector run summary report about restaurant inspections for specified county and year.

### 7/19/2015 
Completed most of queries. Christine does 7d, Will does 6b, Arnav does 6a. Must finish before attending office hours.
### 7/20/2015 
Christine and Arnav will attend TA office hours, go over GUIs and corresponding queries, ask if queries meet all cases, ask about edge cases.
