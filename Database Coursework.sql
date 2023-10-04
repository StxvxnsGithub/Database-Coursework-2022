/*
Time formats are in YYYYMMDDHHMM
Date formats are in YYYYMMDD
*/

/* SECTION 1 - CREATE TABLE STATEMENTS */

create table PoliceStation (
    stationNumber integer(2),
    stationName varchar(255),
    stationAddress varchar(255),
    noOfCells integer(2),
    primary key (stationNumber)
);

create table Detainee (
    detaineeNumber integer(5),
    name varchar(255) not null,
    startTime bigint(12),
    endTime bigint(12),
    primary key (detaineeNumber)
);

create table Cell (
    cellNumber integer(3),
    noOfWindows integer(1),
    isDryCell bit,
    detaineeNumber integer(5),
    stationNumber integer(2) not null,
    primary key (cellNumber, stationNumber),
    foreign key (detaineeNumber) references Detainee (detaineeNumber),
    foreign key (stationNumber) references PoliceStation (stationNumber)
);

create table PoliceVehicle (
    registration varchar(7),
    make varchar(255) not null,
    model varchar(255) not null,
    purchDate integer(8) not null,
    isUnmarked bit,
    officerCapacity integer(1) not null,
    detaineeCapacity integer(1),
    stationNumber integer(2) not null,
    primary key (registration),
    foreign key (stationNumber) references PoliceStation (stationNumber)
);

create table PoliceStaff (
    badgeNumber integer(3),
    firstName varchar(255) not null,
    lastName varchar(255) not null,
    dateOfBirth integer(8) not null,
    joinDate integer(8) not null,
    rank varchar(255) not null,
    sex varchar(255) not null,
    salary decimal(8,2) not null,
    stationNumber integer(2) not null,
    primary key (badgeNumber),
    foreign key (stationNumber) references PoliceStation (stationNumber)
);

create table Shift (
    startTime bigint(12),
    endTime bigint(12) not null,
    vehicleRegistration varchar(7),
    badgeNumber integer(4) not null,
    primary key (startTime, badgeNumber),
    foreign key (vehicleRegistration) references PoliceVehicle (registration),
    foreign key (badgeNumber) references PoliceStaff (badgeNumber)
);

/* SECTION 2 - INSERT STATEMENTS */

insert into PoliceStation values
    (01,'Highbury Police Station','4 Ashdown Road',null),
    (02,'Westbrook Police Office','32 Derby Road',null),
    (03,'(Not Used) Bronzefield Police Office','18 London Road',null),
    (04,'(Not Used) Duke Police Base','1 Cranberry Lane',null),
    (05,'(Not Used) Alliance House Police Station','7 Circular Avenue',null),
    (06,'(Not Used) Lexford Police Office','68 Lex Road',null),
    (07,'(Not Used) Alder Police Office','3 South Street',null),
    (08,'(Not Used) Square Hill Police Office','5 Updown Lane',null),
    (09,'(Not Used) Damsdale Police Office','12 Queens Street',null),
    (10,'(Not Used) Nork Police Base','6 Blackwater Road',null)
;
/* noOfCells receives its value via the first statement in Section 3 */
/* Data in other tables will only use stations 1 and 2. Filling stations 3 to 10 with cells, staff and vehices would result in far too many rows. */
    
insert into Detainee values 
    (00001,'1st Sample Detainee',202212181000,202212181800),
    (00002,'2nd Sample Detainee',202212181100,202212191100),
    (00003,'3rd Sample Detainee',202212181210,202212182010),
    (00004,'4th Sample Detainee',202212181227,202212182027),
    (00005,'5th Sample Detainee',202212181248,202212181848),
    (00006,'6th Sample Detainee',202212181309,202212181909),
    (00007,'7th Sample Detainee',202212181310,202212181910),
    (00008,'8th Sample Detainee',202212181328,202212191328),
    (00009,'9th Sample Detainee',202212181328,202212191328),
    (00010,'10th Sample Detainee',202212181329,202212191329),
    (00011,'11th Sample Detainee',202212181451,202212182351),
    (00012,'12th Sample Detainee',202212181503,202212182103)
;

insert into Cell values 
    (001,2,0,00002,01),
    (002,1,0,00004,01),
    (003,1,0,00005,01),
    (004,0,0,00012,01),
    (005,1,0,null,01),
    (006,0,0,null,01),
    (007,1,0,null,01),
    (008,0,0,null,01),
    (009,1,1,00003,01),
    (010,1,1,00007,01),
    (011,1,1,00008,01),
    (012,1,1,00009,01),
    (013,0,1,null,01),
    (014,0,1,null,01),
    (015,1,0,00001,02),
    (016,1,0,00010,02),
    (017,0,0,00011,02),
    (018,0,0,null,02),
    (019,1,1,00006,02),
    (020,1,1,null,02),
    (021,0,1,null,02),
    (022,0,1,null,02)
;

insert into PoliceVehicle values
    ('MO19MLP','BMW','5 Series G30',20190204,0,4,0,01),
    ('MO19JFK','BMW','5 Series G30',20190204,0,4,0,01),
    ('JA20KLB','Ford','Mondeo',20200425,0,2,2,01),
    ('JA20MHK','Ford','Mondeo',20200425,0,2,2,01),
    ('JA20MNK','Ford','Mondeo',20200425,0,2,2,01),
    ('JA20JJA','Ford','Mondeo',20200425,0,2,2,01),
    ('JA20KLC','Ford','Mondeo',20200425,0,2,2,02),
    ('JA20ADH','Ford','Mondeo',20200425,0,2,2,02),
    ('JA20HUG','Ford','Mondeo',20200425,0,2,2,02),
    ('FP20GLL','Ford','Transit Custom',20200425,0,4,1,01),
    ('FP20OPS','Ford','Transit Custom',20200425,0,4,1,01),
    ('FP20ANK','Ford','Transit Custom',20200425,0,4,1,02),
    ('KL70XCK','BMW','X5',20200810,0,4,0,01),
    ('KL70XGU','BMW','X5',20200810,0,4,0,01),
    ('KL70TFU','BMW','X5',20200810,0,4,0,01),
    ('LC21REG','BMW','5 Series G30',20210522,1,2,2,01),
    ('LC21UMK','BMW','5 Series G30',20210522,1,2,2,01),
    ('LC21HIK','BMW','5 Series G31',20210522,0,2,2,01),
    ('LC21FFG','BMW','5 Series G31',20210522,0,2,2,02),
    ('LC21FED','BMW','5 Series G31',20210522,0,2,2,02)
;

/* Badge Numbers are intentionally made to be non-contiguous to represent officers that have left the job between those times. */
insert into PoliceStaff values
    (11,'RedactedFirstName1','RedactedLastName1',19680508,19860920,'Commissioner','Male',285790.00,01),
    (12,'RedactedFirstName2','RedactedLastName2',19710928,19900130,'Deputy Commissioner','Female',235944.00,01),
    (21,'RedactedFirstName3','RedactedLastName3',19890816,20010316,'Chief Superintendent','Female',89511.00,01),
    (23,'RedactedFirstName4','RedactedLastName4',19900816,20010709,'Superintendent','Male',76932.00,02),
    (30,'RedactedFirstName5','RedactedLastName5',19920628,20031223,'Chief Inspector','Male',60175.00,01),
    (31,'RedactedFirstName6','RedactedLastName6',19880628,20040512,'Chief Inspector','Female',61509.00,02),
    (42,'RedactedFirstName7','RedactedLastName7',19830820,20050621,'Inspector','Male',56580.00,01),
    (45,'RedactedFirstName8','RedactedLastName8',19870317,20100419,'Inspector','Male',58038.00,02),
    (47,'RedactedFirstName9','RedactedLastName9',19881106,20061211,'Inspector','Female',56580.00,01),
    (70,'RedactedFirstName10','RedactedLastName10',19900426,20110725,'Sergeant','Male',45099.00,01),
    (71,'RedactedFirstName11','RedactedLastName11',19930204,20111103,'Sergeant','Female',43806.00,01),
    (73,'RedactedFirstName12','RedactedLastName12',19960906,20120316,'Sergeant','Female',43806.00,02),
    (77,'RedactedFirstName13','RedactedLastName13',19940502,20120728,'Sergeant','Male',42894.00,02),
    (121,'RedactedFirstName14','RedactedLastName14',19970608,20161215,'Constable','Male',34098.00,01),
    (146,'RedactedFirstName15','RedactedLastName15',19961012,20170121,'Constable','Female',33036.00,01),
    (149,'RedactedFirstName16','RedactedLastName16',19980925,20170815,'Constable','Female',33036.00,01),
    (157,'RedactedFirstName17','RedactedLastName17',19980125,20180423,'Constable','Male',32025.00,01),
    (182,'RedactedFirstName18','RedactedLastName18',20000307,20200622,'Constable','Male',30180.00,02),
    (201,'RedactedFirstName19','RedactedLastName19',19991111,20210805,'Constable','Male',28527.00,02),
    (214,'RedactedFirstName20','RedactedLastName20',20030605,20211130,'Constable','Female',28527.00,02),
    (218,'RedactedFirstName21','RedactedLastName21',20021225,20211203,'Constable','Female',28527.00,02),
    (223,'RedactedFirstName22','RedactedLastName22',20040328,20220415,'Constable','Male',28527.00,01),
    (230,'RedactedFirstName23','RedactedLastName23',20030419,20220729,'Constable','Female',28527.00,01)
;

insert into Shift values 
    (202212180200,202212181000,'KL70TFU',70),
    (202212180200,202212181000,'FP20GLL',157),
    (202212180200,202212181000,'JA20ADH',77),
    (202212180200,202212181000,'LC21FFG',201),
    
    (202212180800,202212181600,'KL70XGU',42),
    (202212180800,202212181600,'JA20KLB',71),
    (202212180800,202212181600,'MO19MLP',149),
    (202212180800,202212181600,'FP20ANK',45),
    (202212180800,202212181600,'JA20KLC',214),
    
    (202212181400,202212182200,'LC21REG',47),
    (202212181400,202212182200,'FP20OPS',121),
    (202212181400,202212182200,'KL70XGU',230),
    (202212181400,202212182200,'JA20ADH',31),
    (202212181400,202212182200,'JA20HUG',182),
    
    (202212182000,202212190400,'LC21UMK',30),
    (202212182000,202212190400,'JA20MHK',223),
    (202212182000,202212190400,'KL70XGU',146),
    (202212182000,202212190400,'FP20ANK',73),
    (202212182000,202212190400,'LC21FED',218) 
;

/* SECTION 3 - UPDATE STATEMENTS */

/* Now that all cells have been inserted, the following executes to update the noOfCells for each row in the table 'PoliceStation' */
update PoliceStation set noOfCells = (select count(*) from Cell where stationNumber = PoliceStation.StationNumber);
/* The above needs to be executed in order for noOfCells to no longer be null */

update PoliceStaff set rank = 'Chief Inspector',salary = 59175.00 where badgeNumber = 45 and lastName = 'Dechart';

update Detainee set endTime = 202212181648 where detaineeNumber = 00005;

/* SECTION 4 - SINGLE TABLE SELECT STATEMENTS */

/* 1) Return officers with a last name starting with H */
select * 
from PoliceStaff 
where lastName like 'H%'
order by stationNumber;

/* 2) List all Constables from joined earliest to joined latest */
select badgeNumber, firstName, lastName
from PoliceStaff
where rank = "Constable"
order by joinDate;

/* 3) List all empty cells */
select cellNumber, stationNumber
from Cell
where detaineeNumber is null
order by stationNumber, cellNumber;

/* 4) How many police vehicles are at each station? */
select stationNumber, count(*) as '# of Vehicles'
from PoliceVehicle
group by stationNumber;

/* 5) Return the name of the latest person detained */
select distinct name
from Detainee 
where startTime in (select max(startTime) from Detainee);

/* 6) Return the length of each detainee's stay at the station holding cells. Order by length in descending order */
select name, endTime-startTime as 'Duration (DHHMM)'
from Detainee
order by endTime-startTime desc;

/* SECTION 5 - MULTIPLE TABLE SELECT STATEMENTS */

/* 1) List the names of all detainees at Station 1 'Highbury Police Station' */
select cellNumber, name 
from Detainee d
inner join Cell c
on c.detaineeNumber = d.detaineeNumber
where c.stationNumber = 01
order by cellNumber;

/* 2) List the address each BMW 5 Series G30 is staioned at that was purchased in 2021 */
select stationAddress 
from PoliceStation ps
inner join PoliceVehicle pv
on ps.stationNumber = pv.stationNumber
where make = 'BMW'
and model like '5 Series%' 
and purchDate between 20210000 and 20220000;

/* 3) For each shift on the 18th of December 2022, list the officer's badge number, name, shift start time, end time and vehicle driver */
select pst.badgeNumber, firstName, lastName, startTime % 10000 as 'Start Time', endTime % 10000 as 'End Time', make, model
from PoliceStaff pst
inner join Shift s
on pst.badgeNumber = s.badgeNumber
inner join PoliceVehicle
on vehicleRegistration = registration
where startTime between 202212180000 and 202212182359
order by startTime, pst.stationNumber, badgeNumber;

/* 4) List officers who did not patrol sometime between midnight and afternoon on the 18th of December 2022 
badgeNumber not in (select badgeNumber from Shift)*/
select pst.badgeNumber, firstName, lastName, startTime % 10000 as 'Start Time', endTime % 10000 as 'End Time'
from PoliceStaff pst
left join Shift s
on pst.badgeNumber = s.badgeNumber
where not ((startTime < 202212181200 and  startTime >= 202212180000)
or (endTime >= 202212180000 and endTime < 202212181200))
or startTime is null
order by startTime, stationNumber, badgeNumber;

/* 5) Are there at least 4 vacant cells? If so, where are they? */
select ps.stationNumber, stationName, stationAddress, (select count(*) from Cell c where c.stationNumber = ps.stationNumber and c.detaineeNumber is null) as '# of Vacant Cells'
from PoliceStation ps
inner join Cell c
on ps.stationNumber = c.stationNumber
where c.detaineeNumber is null
group by stationNumber
having count(*) >= 4;

/* 6) How many times is each vehicle used on the 18th of December 2022? Order by uses in descending order */
select registration, make, model, (select count(*) from Shift where vehicleRegistration = registration and startTime between 202212180000 and 202212182359) as usageCount
from PoliceVehicle
left join Shift
on registration = vehicleRegistration
group by registration
order by usageCount desc, registration, make;

/* SECTION 6 - DELETE ROWS (make sure the SQL is commented out in this section) */

-- delete from PoliceStaff where badgeNumber = 23 and lastName = 'Ruarc';

-- delete from PoliceVehicle where registration = 'JA20JJA' and model = 'Mondeo';

/* SECTION 7 - DROP TABLES (make sure the SQL is commented out in this section) */

-- drop table Shift;
-- drop table PoliceStaff;
-- drop table PoliceVehicle;
-- drop table Cell;
-- drop table Detainee;
-- drop table PoliceStation;