create table registerUser (
userName char(30),
pswd char(30),
primary key(userName));

create table inspector (
iUserName char(30),
iID int(20),
iPhone int(10),
iFName char(30),
iLName char(30),
primary key (iUserName),
foreign key(iUserName) references registerUser(userName),
unique (iID),
unique(iPhone));

create table operator (
oUserName char(30),
oPhone int(10),
oEmail char(30),
oFName char(30),
oLName char(30),
primary key (oUserName),
foreign key(oUserName) references registerUser(userName),
unique (oEmail),
unique (oPhone));

create table healthPermit (
hpID int(9),
dateExpires date,
primary key (hpID)
);

create table cuisineType (
cuisine char(30),
primary key (cuisine)
);

create table customer (
cPhone int(10),
cFName char(30),
cLName char(30),
primary key (cPhone)
);

create table restaurant (
rID int(20),
rPhone int(10),
zipCode int(10),
state char(2),
city char(20),
street char(50),
rName char(50),
county char(10),
rHPID int(9),
rCuisine char(30),
rOperatorUserName char(30),
primary key (rID),
unique (rPhone),
unique(zipCode, state, city, street),
foreign key (rHPID) references healthPermit(hpID),
foreign key (rCuisine) references cuisineType(cuisine),
foreign key (rOperatorUserName) references operator(oUsername)
);

create table item (
itemNumber int(2),
perfectScore int(3),
itemDescription char(200),
itemCritical char(5),
primary key (itemNumber)
);

create table inspection (
inspectionDate date,
RID int(20),
totalScore int(3),
passOrFail char(5),
inspectorUserName char(30),
primary key (inspectionDate, RID),
foreign key (RID) references restaurant(rID),
foreign key (inspectorUserName) references inspector(iUserName));

create table complaint (
complaintDate date,
customerPhone int(10),
listedRID int(20),
complaintDescription char(200),
primary key (complaintDate, customerPhone, listedRID),
foreign key (customerPhone) references customer(cPhone),
foreign key (listedRID) references restaurant(rID));

create table includes (
includedDate date,
includedRID int(20),
includedItemNumber int(2),
comment char(200),
primary key (includedDate, includedRID, includedItemNumber),
foreign key (includedDate) references inspection(inspectionDate),
foreign key (includedRID) references restaurant(rID),
foreign key (includedItemNumber) references item(itemNumber));


create table contains(
containedDate date,
containedRID int(20),
containedItemNumber int(2),
score int(1),
primary key (containedDate , containedRID , containedItemNumber ),
foreign key (containedDate)  references inspection(inspectionDate),
foreign key (containedRID ) references restaurant(rID),
foreign key (containedItemNumber ) references item(itemNumber));










