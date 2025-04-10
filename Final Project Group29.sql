--drop database Final_Final_Project_EDITED15;
--CREATE DATABASE Final_Final_Project_EDITED15;

-- 1. Person
CREATE TABLE Person (
    National_id BIGINT NOT NULL, --d
    DateOfBirth DATE NOT NULL, --d
    Gender VARCHAR(50) NOT NULL,--d
    Fname VARCHAR(50) NOT NULL,--d
    Minit VARCHAR(50) NOT NULL,--d
    Lname VARCHAR(50) NOT NULL,--d
	Marital_Status VARCHAR (20) NOT NULL, --d
	CONSTRAINT National_id_pk PRIMARY KEY (National_id)
  );

-- Address Composite key
CREATE TABLE Address( 
	NID BIGINT NOT NULL, --d
	State VARCHAR(50) NOT NULL, --d
    City VARCHAR(50),--d
    Street VARCHAR(100),--d
    Zipcode VARCHAR(20),--d
	CONSTRAINT Address_PK PRIMARY KEY (NID,Zipcode), --d
	--FOREIGN KEY (NID) REFERENCES Person(National_id)
);

-- 2. Legal Worker (sub-table from person)
CREATE TABLE LegalWorker (
    National_id BIGINT NOT NULL, -- d
    Service_Location VARCHAR(50), -- d
	CONSTRAINT National_id_pk_2 PRIMARY KEY (National_id),
	FOREIGN KEY (National_id) REFERENCES Person(National_id),
);   

-- 3. Legal Officer (sub table from legal worker)
CREATE TABLE LegalOfficer (
    National_id BIGINT NOT NULL,-- d
    Rank VARCHAR(50),-- d
    Badge_number INT NOT NULL,-- d
	CONSTRAINT National_id_pk_3 PRIMARY KEY (National_id,Badge_number),
    FOREIGN KEY (National_id) REFERENCES LegalWorker(National_id)
);

-- 4. Judge (sub table from legal worker)
CREATE TABLE Judge (
    National_id BIGINT NOT NULL, -- d
    Specialization VARCHAR(50), -- d 
    FOREIGN KEY (National_id) REFERENCES LegalWorker(National_id),
	CONSTRAINT National_id_pk_4 PRIMARY KEY (National_id)
);


-- 5. Criminal (sub table from legal worker)
CREATE TABLE Criminal (
    National_id BIGINT NOT NULL, -- -- d
    Paid_prison_labor_balance DECIMAL(10, 2), -- -- d
    FOREIGN KEY (National_id) REFERENCES Person(National_id),
	CONSTRAINT National_id_pk_5 PRIMARY KEY (National_id)
);

-- 6. Crime
CREATE TABLE Crime (
    Crime_id INT NOT NULL, -- d
    Category VARCHAR(50), -- d
    Dateofcommitment DATE, -- d
    Crime_description VARCHAR(1000), -- d
	--National_id BIGINT NOT NULL, -- d

	CONSTRAINT Crime_id_pk PRIMARY KEY (Crime_id),
	--FOREIGN KEY (National_id) REFERENCES Person(National_id)
);

-- 7.Paticipate
CREATE TABLE Participate(
	crime_id INT NOT NULL, -- 
	criminal_id BIGINT NOT NULL, -- 
	crime_location VARCHAR(50), --  

	CONSTRAINT Crime_pk PRIMARY KEY (crime_id,criminal_id),
	FOREIGN KEY (criminal_id) REFERENCES Criminal(National_id),
	FOREIGN KEY (crime_id) REFERENCES Crime(Crime_id)
);

-- 8. Investigation
CREATE TABLE Investigation (
    Investigation_id INT NOT NULL,
    Status VARCHAR(50),
    Start_date DATE,
    End_date DATE,
    Scenario VARCHAR(255),
	officer_id BIGINT,
	badge_number int,

    FOREIGN KEY (officer_id,badge_number) REFERENCES LegalOfficer(National_ID,Badge_number),
    CONSTRAINT Investigation_id_pk PRIMARY KEY (Investigation_id)
);

-- 9.Solve junction table 

CREATE TABLE Solve (
	Crime_id				INT NOT NULL,
	Investigation_id		INT NOT NULL, 
	Case_Notes				VARCHAR(500),
	Priority_Level_			VARCHAR(10),


	CONSTRAINT Solve_pk		PRIMARY KEY (Crime_id,Investigation_id),
	FOREIGN KEY (Crime_id)	REFERENCES Crime(Crime_id),
	FOREIGN KEY (Investigation_id) REFERENCES Investigation(Investigation_id)
);







-- 10. Prosecution -- added
CREATE TABLE Prosecution (
    Prosecution_id			INT NOT NULL,
	National_id				BIGINT NOT NULL,
    Verdict					VARCHAR(50),
    Prosecution_date		DATE,
    Jury_majority_approval	VARCHAR(1),


	CONSTRAINT Prosecution_id_pk primary key (Prosecution_id),
	FOREIGN KEY (National_id) REFERENCES Judge(National_id), 
);



-- 11. Trial
CREATE TABLE Trial (
    Trial_id INT NOT NULL,
    Transcript VarCHAR(50), 
    Case_status VARCHAR(50),
    NumberOfWitness INT,
    Trial_date DATE,
    Crime_id INT,
	Judge_id BIGINT,
	Prosecution_ID INT,

    FOREIGN KEY (Crime_id) REFERENCES Crime(Crime_id),
	FOREIGN KEY (Judge_id) REFERENCES Judge(National_ID),
	FOREIGN KEY (Prosecution_ID) REFERENCES Prosecution(Prosecution_id),

	CONSTRAINT Trial_id_pk PRIMARY KEY (Trial_id)
);

-- 12. Penalty add --
CREATE TABLE Penalty (
    Penalty_id			INT NOT NULL,
    Penalty_type		VARCHAR(50),
    Due_date			DATE,
    End_date			DATE,
    Parole_eligibility_date DATE,
	Trial_id				INT,


	FOREIGN KEY (Trial_id) REFERENCES Trial(Trial_id),
    CONSTRAINT Penalty_id_pk PRIMARY KEY (Penalty_id)
);

alter table Penalty
alter column Penalty_type varchar(60);

-- 13. Facility
CREATE TABLE Facility (
    Facility_id INT NOT NULL,
    Facility_type VARCHAR(50),
    Facility_name VARCHAR(100),
    addres VARCHAR(255),
    Contact_number VARCHAR(20),
	PenaltyID INT,

	FOREIGN KEY (PenaltyID) REFERENCES Penalty(Penalty_id),
    CONSTRAINT Facility_id_pk PRIMARY KEY (Facility_id)
);



-- 14. Evidence
CREATE TABLE Evidence (
    Evidence_id INT NOT NULL,
    Type VARCHAR(50),
    Condition VARCHAR(255),
    Details TEXT,
    Description VARCHAR(255),
    Investigation_id INT,
    FOREIGN KEY (Investigation_id) REFERENCES Investigation(Investigation_id),
    CONSTRAINT Evidence_id_pk PRIMARY KEY (Evidence_id)
);

-- 15. Victim (sub table from legal worker)
CREATE TABLE Victim (
	National_id BIGINT NOT NULL,
	is_fetality BIT,
	Relation_to_offender VARCHAR(50),

	CONSTRAINT Victim_PK PRIMARY KEY (National_id),
	FOREIGN KEY (National_id) REFERENCES Person(National_id)
);

-- 16. Involve
CREATE TABLE Involve (
	VictimID BIGINT,
	crimeID INT,
	Damage VARCHAR(20),

	CONSTRAINT involve_PK PRIMARY KEY (VictimID,crimeID),
	FOREIGN KEY (VictimID) REFERENCES Person(National_id),
	FOREIGN KEY (crimeID) REFERENCES Crime(Crime_id)
);


-- hossam235174 alters --
alter table Judge
alter column Specialization varchar(60);

alter table Solve
alter column Case_Notes varchar(450);

alter table Solve
alter column Priority_Level_ varchar(15);

alter table Prosecution
alter column Verdict varchar(45);

----------------------------------------
--Ahmed El Galaly231051
--Alters
--ALTER TABLE Person
--ADD  Email VARCHAR(255);

ALTER TABLE Penalty
alter COLUMN Due_date DATETIME;

--following are the inseration per table
-- person insertions -- done
-- used for judge & legal officer
INSERT INTO Person VALUES (30202134567889, '1995-08-25', 'Male', 'Ahmed', 'Mohamed', 'Ali','Married');
INSERT INTO Person VALUES (30202134567890, '1988-04-17', 'Male', 'Tarek', 'Ibrahim', 'Khalil','Divorced');
INSERT INTO Person VALUES (30303145678901, '1993-11-03', 'Male', 'Mohamed', 'Mahmoud', 'Abdelaziz','Married');
INSERT INTO Person VALUES (30404156789012, '1985-06-10', 'Male', 'Khaled', 'Hassan', 'Sayed','Married');
INSERT INTO Person VALUES (30505167890123, '1998-02-15', 'Male', 'Ahmed', 'Hassan', 'Youssef','Divorced');
INSERT INTO Person VALUES (30606178901234, '1990-09-28', 'Female', 'Nadia', 'Youssef', 'Awad', 'Widow');
INSERT INTO Person VALUES (30707189012345, '1979-12-20', 'Female', 'Amina', 'Nabil', 'Samir','Single');
INSERT INTO Person VALUES (30808190123456, '1982-03-07', 'Female', 'Marina', 'Rafik', 'Antony', 'Divorced');
INSERT INTO Person VALUES (30909101234567, '1997-05-12', 'Female', 'Sara', 'Tamer', 'Mohsen', 'Widow');
INSERT INTO Person VALUES (31001012345678, '1987-10-18', 'Female', 'Hana', 'Ashraf', 'Fathy','Married');
--used for criminal
INSERT INTO Person VALUES (31102123456789, '1994-01-30', 'Male', 'Yasser', 'Magdy', 'Ibrahim', 'Single');
INSERT INTO Person VALUES (31203134567890, '1986-07-07', 'Female', 'Amal', 'Maged', 'Attia','Single');
INSERT INTO Person VALUES (31304145678901, '1999-04-22', 'Male', 'Ahmed', 'Adel', 'Sayed', 'Divorced');
INSERT INTO Person VALUES (31405156789012, '1980-11-15', 'Female', 'Nadia', 'Salah', 'Youssef', 'Widow');
INSERT INTO Person VALUES (31506167890123, '1996-08-03', 'Male', 'Maged', 'Maher', 'Ismail','Single');
-- used for victim
INSERT INTO Person VALUES (31607178901234, '1975-04-22', 'Male', 'Ahmed', 'Ali', 'Hassan', 'Married');
INSERT INTO Person VALUES (31708189012345, '1988-12-10', 'Female', 'Fatima', 'Khalid', 'Mohamed', 'Single');
INSERT INTO Person VALUES (31809190123456, '2000-06-27', 'Male', 'Karim', 'Sami', 'Abdel-Rahman', 'Divorced');
INSERT INTO Person VALUES (31910101234567, '1992-02-18', 'Female', 'Hana', 'Mahmoud', 'Ahmed', 'Married');
INSERT INTO Person VALUES (32011112345678, '1985-09-08', 'Male', 'Tarek', 'Amr', 'Fawzy', 'Single');

INSERT INTO Person VALUES (31102123456334, '1994-01-30', 'Female', 'Yousra', 'Magdy', 'Ibrahim', 'Single');

-- Insertions for Address -- done

INSERT INTO Address VALUES(30202134567889,'Cairo','Giza','26thofJulyStreet','11741');
INSERT INTO Address VALUES(30202134567890,'Alexandria','Alexandria','CornicheStreet','21901');
INSERT INTO Address VALUES(30303145678901,'ElSharqia','Zagazig','CairoStreet','41522');
INSERT INTO Address VALUES(30404156789012,'Giza','6thofOctoberCity','OmarIbnAlKhattabStreet','12614');
INSERT INTO Address VALUES(31401012345680,'Alexandria','AlRamlStation','SafiaZaghloulStreet','21901');
INSERT INTO Address VALUES(30505167890123,'ElBeheira','Damanhour','ElMidanStreet','22511');
INSERT INTO Address VALUES(30606178901234,'Menoufia','ShibinElKom','ElGomaaStreet','32511');
INSERT INTO Address VALUES(32001012345683,'Gharbia','Tanta','ElGamhoriaStreet','31111');
INSERT INTO Address VALUES (30707189012345, 'Dakahlia', 'Mansoura', 'El-Shohadaa Square', '35111');
INSERT INTO Address VALUES (32401012345685, 'Sharkia', 'Zagazig', 'El-Nour Street', '41522');
INSERT INTO Address VALUES (30808190123456, 'Qalyubia', 'Benha', 'El-Orouba Street', '13511');
INSERT INTO Address VALUES (30909101234567, 'Monufia', 'Menoufia', 'El-Amria Street', '32511');
INSERT INTO Address VALUES (31001012345678, 'Alexandria', 'El-Mandara', 'El-Horreya Street', '21901');
INSERT INTO Address VALUES (31102123456789, 'El-Beheira', 'Damanhour', 'El-Midan Street', '22511');
INSERT INTO Address VALUES (31203134567890, 'Menoufia', 'Shibin El-Kom', 'El-Gomaa Street', '32511');
INSERT INTO Address VALUES (31304145678901, 'Gharbia', 'Tanta', 'El-Gamhoria Street', '31111');
INSERT INTO Address VALUES (31405156789012, 'Dakahlia', 'Mansoura', 'El-Shohadaa Square', '35111');
INSERT INTO Address VALUES (31506167890123, 'Sharkia', 'Zagazig', 'El-Nour Street', '41522');
INSERT INTO Address VALUES (31607178901234, 'Cairo', 'Maadi', 'Nile Corniche', '11431');
INSERT INTO Address VALUES (31708189012345, 'Luxor', 'Luxor', 'Karnak Avenue', '85511');
INSERT INTO Address VALUES (31809190123456, 'Aswan', 'Aswan', 'Nubian Street', '81422');
INSERT INTO Address VALUES (31901001234567, 'Port Said', 'Port Said', 'Suez Canal Street', '42111');
INSERT INTO Address VALUES (32101112345678, 'Sinai', 'Sharm El Sheikh', 'Naama Bay Road', '46621');

INSERT INTO Address VALUES(31102123456334,'Cairo','Giza','26thofJulyStreet','11741');


-- Legal Worker insertions -- done
INSERT INTO LegalWorker VALUES (30202134567889, 'El Harm');
INSERT INTO LegalWorker VALUES (30303145678901, 'El maady');
INSERT INTO LegalWorker VALUES (30404156789012, 'Nasr city');
INSERT INTO LegalWorker VALUES (30606178901234, 'shrouq');
INSERT INTO LegalWorker VALUES (31001012345678, 'Judge');
INSERT INTO LegalWorker VALUES (30202134567890, 'Shrouq');
INSERT INTO LegalWorker VALUES (30505167890123, 'Nasr City');
INSERT INTO LegalWorker VALUES (30707189012345, 'Zaied');
INSERT INTO LegalWorker VALUES (30808190123456, 'EL maady');
INSERT INTO LegalWorker VALUES (30909101234567, 'Nasr city');

-- Insertions for Legal Officer -- done
INSERT INTO LegalOfficer VALUES (30505167890123, 'Investigator', 7540);
INSERT INTO LegalOfficer VALUES (30202134567890, 'Inspector', 7541);
INSERT INTO LegalOfficer VALUES (30707189012345, 'Detective', 7542);
INSERT INTO LegalOfficer VALUES (30808190123456, 'Special Agent', 7543);
INSERT INTO LegalOfficer VALUES (30909101234567, 'Commander', 7544);

-- Insertions for Judge -- done
INSERT INTO Judge VALUES (30202134567889, 'Civil Law');
INSERT INTO Judge VALUES (30303145678901, 'Criminal Law');
INSERT INTO Judge VALUES (30404156789012, 'Family Law');
INSERT INTO Judge VALUES (30606178901234, 'Corporate Law');
INSERT INTO Judge VALUES (31001012345678, ' Criminal Law');



-- Prosecution -- done
INSERT INTO Prosecution VALUES (401, 30202134567889 ,'Convicted', '2023-03-15', 'Y'); -- judge
INSERT INTO Prosecution VALUES (402, 30606178901234 ,'Convicted','2023-04-20', 'N'); -- judge
INSERT INTO Prosecution VALUES (403, 30606178901234 , 'Acquitted' ,'2023-05-30', 'Y'); -- judge
INSERT INTO Prosecution VALUES (404, 31001012345678 ,'Acquitted', '2023-06-15', 'N'); -- judge
INSERT INTO Prosecution VALUES (405, 30202134567889 ,'Convicted', '2023-06-15', 'N'); -- officer



-- Criminal --done
INSERT INTO Criminal VALUES (31102123456789, 123.53);
INSERT INTO Criminal VALUES (31203134567890, 73.37);
INSERT INTO Criminal VALUES (31304145678901, 39.00);
INSERT INTO Criminal VALUES (31405156789012, 49.50);
INSERT INTO Criminal VALUES (31506167890123, 24.74);

INSERT INTO Criminal VALUES (31102123456334, 30.90);

-- Crime insertions -- done
INSERT INTO Crime VALUES (101, 'robbery', '2023-01-15', 'Theft of valuable items');
INSERT INTO Crime VALUES (102, 'Assault', '2023-02-20', 'Physical attack on an individual');
INSERT INTO Crime VALUES (103, 'Burglary', '2023-03-10', 'Breaking into a residence');
INSERT INTO Crime VALUES (104, 'Fraud', '2023-04-05', 'Deceptive financial practices');
INSERT INTO Crime VALUES (105, 'Kidnapping', '2023-05-12', 'Abduction of an individual');

INSERT INTO Crime VALUES (106, 'Incest', '2023-06-13', 'Intimacy with a 1st degree family member');

--Participate -- done
INSERT INTO Participate VALUES (101,31102123456789, 'School'); 
INSERT INTO Participate VALUES (101,31203134567890, 'School'); 
INSERT INTO Participate VALUES (102,31203134567890,'Bank');
INSERT INTO Participate VALUES (103,31304145678901,'Public Park');
INSERT INTO Participate VALUES (104,31405156789012,'Apartment Complex');
INSERT INTO Participate VALUES (105,31506167890123,'Public Park');

INSERT INTO Participate VALUES (106,31102123456789,'Apartment');
INSERT INTO Participate VALUES (106, 31102123456334,'Apartment');

-- Investigation insertions --done
INSERT INTO Investigation VALUES (201, 'Open', '2023-01-20', '2024-02-10', 'Investigating robbery case', 30202134567890 ,7541 ); -- officer 
INSERT INTO Investigation VALUES (202, 'Closed', '2023-02-25', '2023-03-15', 'Investigating assault case', 30909101234567 ,7544 ); -- officer
INSERT INTO Investigation VALUES (203, 'Open', '2023-03-15', '2024-04-05', 'Investigating burglary case', 30202134567889 ,NULL ); -- judge
INSERT INTO Investigation VALUES (204, 'Closed', '2023-04-20', '2023-05-15', 'Investigating fraud case', 31001012345678 ,NULL); -- judge
INSERT INTO Investigation VALUES (205, 'Open', '2023-05-25','2023-05-15' ,'Investigating kidnapping case', 30707189012345 ,7542); -- officer

-- Solve 
INSERT INTO Solve VALUES (101, 201,'Ongoing investigation into robbery at a convenience store','High');
INSERT INTO Solve VALUES (102, 202, 'Investigation closed with suspect apprehended', 'Medium');
INSERT INTO Solve VALUES (103, 203,'Continued surveillance on assault case suspects', 'High');
INSERT INTO Solve VALUES (104,204,'Fraud investigation underway, tracing financial transactions', 'Medium');
INSERT INTO Solve VALUES (105,205,'Homicide investigation, gathering witness statements', 'High');



--Trial insertions --done
INSERT INTO Trial VALUES (301, 'Court Transcript for Robbery Case', 'Guilty', 2 , '2023-03-01',101 ,  30202134567889, 401);
INSERT INTO Trial VALUES (302, 'Court Transcript for Assault Case', 'Not Guilty', 5 ,'2023-04-10', 102 ,30303145678901, 402);
INSERT INTO Trial VALUES (303, 'Court Transcript for Burglary Case', 'Guilty', 3 , '2023-05-20', 103 ,31001012345678, 403);
INSERT INTO Trial VALUES (304, 'Court Transcript for Fraud Case', 'Not Guilty', 1 , '2023-06-05', 104 ,30303145678901, 404);
INSERT INTO Trial VALUES (305, 'Court Transcript for Kidnapping Case', 'Pending', 0 , NULL, 105 ,30202134567889, 401);

-- Penalty done --
INSERT INTO Penalty VALUES (601, 'Imprisonment', '2023-07-01', '2023-12-31', '2023-12-01', 301);
INSERT INTO Penalty VALUES (602, 'Probation', '2023-07-01', '2024-07-01', '2023-05-03' ,302);
INSERT INTO Penalty VALUES (603, 'Community Service', NULL, '2023-07-01', '2024-01-01', 303);
INSERT INTO Penalty VALUES (604, 'Fine', NULL, '2023-07-01', '2023-08-01', 304);
INSERT INTO Penalty VALUES (605, 'House Arrest', NULL, '2023-07-01', '2024-01-01', 305);




-- Facility --done
INSERT INTO Facility VALUES (501, 'Prison', 'Central Prison Cairo', '123 Jail Street', '555-1234' ,601 );
INSERT INTO Facility VALUES (502, 'Correctional Facility', 'Nile Rehabilitation Center', '789 Rehab Street', '555-5678',602);
INSERT INTO Facility VALUES (503, 'Detention Center', 'Luxor Detention Facility', '456 Detention Street', '555-9012', 603);
INSERT INTO Facility VALUES (504, 'Juvenile Center', 'Aswan Juvenile Facility', '789 Juvenile Street', '555-3456',604);
INSERT INTO Facility VALUES (505, 'Halfway House', 'Port Said Reintegration House', '012 Reintegration Street', '555-7890',605);


-- Evidence --done
INSERT INTO Evidence VALUES (701, 'Document', 'Good condition', 'Signed confession', 'Confession document', 201);
INSERT INTO Evidence VALUES (702, 'Physical', 'Damaged', 'Bloodstained shirt', 'Crime scene evidence', 202);
INSERT INTO Evidence VALUES (703, 'Digital', 'Intact', 'Security camera footage', 'Surveillance footage', 203);
INSERT INTO Evidence VALUES (704, 'Testimonial', NULL, 'Witness statement', 'Eyewitness account', 204);
INSERT INTO Evidence VALUES (705, 'Physical', 'Intact', 'Fingerprint analysis report', 'Fingerprint analysis', 205);

--involve -- done
INSERT INTO Involve VALUES (31607178901234, 101, 'Vandalism'); 
INSERT INTO Involve VALUES (31708189012345, 102, 'Identity theft'); 
INSERT INTO Involve VALUES (31809190123456, 103, 'Facial injuries'); 
INSERT INTO Involve VALUES (31910101234567, 104, 'Psychological trauma'); 
INSERT INTO Involve VALUES (32011112345678, 105, 'Physical injuries'); 

-- Victim --done
INSERT INTO Victim VALUES (31607178901234, 0, 'Unknown');
INSERT INTO Victim VALUES (31708189012345, 1, 'Friends');
INSERT INTO Victim VALUES (31809190123456, 0, 'Sibilings');
INSERT INTO Victim VALUES (31910101234567, 0, 'Friends');
INSERT INTO Victim VALUES (32011112345678, 1, 'Unknown');
--------------------------------------------------------------------
	--Abdelrahman229214 updates 
UPDATE Victim
SET is_fetality = 1
WHERE Victim.National_id = '31910101234567';

UPDATE Crime
SET Crime_description = 'theft of valuable iteam and murder'
WHERE Crime_id = '101';

-----------------------------------------------------------------------
	-- Hossam235714 updates
-- Updates -- 
update Judge
set Specialization = 'Supreme Court Justices'
where National_id = 31001012345678

update Judge
set Specialization = 'Junior Division'
where National_id = 31001012345678

update Prosecution
set Verdict = 'Acquitted'
where Prosecution_id = 405

update Solve
set Case_Notes = 'Financial transactions being scrutinized in fraud probe.'
where Crime_id = 101;

update Solve
set Case_Notes = 'Authorities are maintaining close watch on the subjects implicated in the assault case.'
where Crime_id = 103;

update Penalty
set Penalty_type = 'Probation'
where Penalty_id = 601;

update Penalty
set Penalty_type = 'Imprisonment'
where Penalty_id = 601;
---------------------------------------------------------
-- Abdelsalalm Mohammed235429
--8)mark an investigation as closed(update)
update Investigation
set Status = 'Closed', End_date = '2023-06-30'
where Investigation_id = 201;


--9)Update the Contact_number for a specific facility(update)
update Facility
set Contact_number = '555-5555'
where Facility_id = 501;

------------------------------------------
--Ahmed El Galaly231051
--Updates
--UPDATE Person
--SET Email = 'john.doe@example.com'
--WHERE National_id = 30202134567889;


UPDATE Penalty
SET Due_date = '2023-12-31 23:59:59'
WHERE Penalty_id = 601;

-------------------------------------------------------------------------------------------------
-- HOSSAM EL SAYED 235174
-- query 1)  // this query is to return the full names of the suspects and all the crimes related to school they commited and the date they commited the crime in
	select
		(Fname + ' ' + Minit + ' ' + Lname) as 'Full Name',
		crim.Crime_description as 'Crime Description',
		crim.Dateofcommitment as 'Date Of Commitment'
	from Criminal cri
		JOIN Participate par on cri.National_id = par.criminal_id
		JOIN Crime crim on crim.Crime_id = par.crime_id
		JOIN Person per on per.National_id = cri.National_id
	where 
		par.crime_location like 'School';
-- query 2) // this query returns the full name of any judge handling a guilty case, and the description of this case 
	select
		(Fname + ' ' + Minit + ' ' + Lname) as 'judge Full Name',
		 Transcript,Case_status
	from 
		Trial trial join Person per on trial.Judge_id = per.National_id
	where trial.Judge_id in (
		select National_id
		from Judge 
		where Case_status like 'Guilty'
	);
-- query 3)  // returns the full names of high priority criminals , with the date of commiting this crime as well as the description of the crime
	select 
		(Fname + ' ' + Minit + ' ' + Lname) as 'Full Name', 
		Crime_description, Dateofcommitment
	from
		Crime cri join Participate par on cri.Crime_id = par.crime_id
		join Person per on per.National_id = par.criminal_id
	where cri.Crime_id in (
		select Crime_id
		from Solve
		where Priority_Level_ like 'High'
	);

-- query 4) // this query returns the officers handling open cases and the location they are serving at and whats their social status "married,divorced,etc..."
	select 
		(Fname + ' ' + Minit + ' ' + Lname) as 'Full Name',
		Service_Location as 'Service Location' , 
		Marital_Status as 'Martial Status'
	from LegalWorker leg join Person per on leg.National_id = per.National_id
	where per.National_id in (
		select National_id
		from LegalOfficer
		where Badge_number in (
			select badge_number
			from Investigation
			where Status like 'Open'
		)
	);

-- query 5)  //return the full name of all the judges ascosiated with a crime and the description of that crime

	select 	(Fname + ' ' + Minit + ' ' + Lname) as 'Judge"s Full Name',
	Crime_description

	from Person per join Trial tri on per.National_id = tri.Judge_id
	join Crime cri on tri.Crime_id = cri.Crime_id 

-- query 6)  //selecting the first name from people born within a specific period of time    

	SELECT (Fname + ' ' + Minit + ' ' + Lname) as 'Judge"s Full Name', DateOfBirth
	FROM Person
	WHERE DateOfBirth >= '1990-01-01' AND DateOfBirth <= '1999-12-31';

-- query 7)    // returns the average salary of working in-mates

	SELECT AVG(Paid_prison_labor_balance) as 'average labor balance of in-mates is'
	FROM Criminal

-- query 8)    // return the name of all the in-mates as well as their salaries
 
	SELECT  (Fname + ' ' + Minit + ' ' + Lname) as 'in-mate"s full name' ,Paid_prison_labor_balance
	FROM Person per join Criminal crim on per.National_id = crim.National_id

-- query 9)  // returns the full names of criminals and the description of their crime as well as the date they commited this crime at as well as the location they commited that crime at, and the specfic category for it

	select
		(Fname + ' ' + Minit + ' ' + Lname) as 'Full Name',
		crim.Crime_description as 'Crime Description',
		crim.Dateofcommitment as 'Date Of Commitment',
		crime_location as 'location of crime',
		Category
	from Criminal cri
		JOIN Participate par on cri.National_id = par.criminal_id
		JOIN Crime crim on crim.Crime_id = par.crime_id
		JOIN Person per on per.National_id = cri.National_id

-- query 10)  // this query prints the full name and the penalty that has been taken against suspects, as well as a description of what the criminal has done, i also added the the date of parole and  trial  as well as if the suspect is guilty or not

	select 	(Fname + ' ' + Minit + ' ' + Lname) as 'Full Name' ,
	Penalty_type as 'penalty' ,
	Transcript,
	Parole_eligibility_date,
	Trial_date,
	Case_status
	from Person per join Trial tri on per.National_id = tri.Judge_id
	join Penalty pen on tri.Trial_id = pen.Trial_id





-------------------------------------------------------------
-- Abdelrahman Salah 229214:
--1).  show the balance of the crimenal for his labor with his name using national_id, if National_ID not in Crimenal shows NULL for the balance

	SELECT Fname +' ' + Lname AS Name, P.National_id, C.Paid_prison_labor_balance AS Prisoner_Balance
	FROM Person P
	LEFT OUTER JOIN Criminal C ON P.National_id = C.National_id;
--2). show the victim's info and shows his trial info
	SELECT P.Fname AS Victim_Name, V.National_id AS Victim_National_id, V.is_fetality, V.Relation_to_offender, T.Trial_id, T.Case_status, T.Trial_date
	FROM Victim V
	INNER JOIN Involve I ON V.National_id = I.VictimID
	INNER JOIN Trial T ON I.crimeID = T.Crime_id
	INNER JOIN Person P ON V.National_id = P.National_id;
--3). shows the crime info with the victims info 
	SELECT CR.Crime_id, CR.Category, CR.Crime_description, P.Fname AS Victim_Firstname, V.is_fetality AS Victim_Fetality  
	FROM Crime CR
	LEFT JOIN Involve I ON CR.Crime_id = I.crimeID
	LEFT JOIN Victim V ON I.VictimID = V.National_id
	LEFT JOIN Person P ON V.National_id = P.National_id;

--4). show the evidance used for each  investigation
		SELECT Evidence_id, Details AS Evidence_Details, Status AS Case_Status , badge_number AS Officer_Badge_Number
		FROM Investigation inv	
		JOIN Evidence eve ON eve.Investigation_id = inv.Investigation_id;

--5). show victims marital status of victim under category Assault
		SELECT  Fname +' ' + Lname as 'Crimenal Full Name', Marital_Status
		from Person per 
		join Involve inv ON per.National_id = VictimID 
		WHERE  VictimID IN (
		SELECT VictimID 
		FROM Involve invy JOIN Crime CR ON invy.crimeID = CR.Crime_id 
		WHERE Category LIKE 'Assault'
		);

--6). show the national_id of the judege who are leading a fraud cases
		SELECT j.National_id AS Judge_ID, p.Prosecution_id, p.Verdict, p.Prosecution_date
	FROM Judge j
	JOIN Trial t ON j.National_id = t.Judge_id
	JOIN Prosecution p ON t.Prosecution_ID = p.Prosecution_id
	WHERE t.Crime_id IN (
		SELECT Crime_id
		FROM Crime
		WHERE Category = 'Fraud'
	);
	--------------------------------------------------------------------------------------------------
--Amr Sameh 224732

	SELECT * FROM Involve WHERE crimeID = [CrimeID];

	SELECT Involve.*, Person.Fname, Person.Lname
	FROM Involve
	JOIN Person ON Involve.VictimID = Person.National_id
	WHERE Involve.crimeID = [CrimeID];

	SELECT * FROM LegalWorker;

	SELECT * FROM LegalWorker WHERE National_id IN (SELECT National_id FROM LegalOfficer);

	SELECT * FROM LegalWorker
	WHERE National_id NOT IN (SELECT National_id FROM LegalOfficer);

	SELECT Service_Location, COUNT(National_id) AS NumberOfLegalWorkers
	FROM LegalWorker
	GROUP BY Service_Location;

	SELECT * FROM LegalWorker
	WHERE National_id NOT IN (SELECT National_id FROM LegalOfficer);---------------------------------------------------------------------------------------------------
-- Ahmed El Galaly231051
----------------------------------------------------------------------------------------------------
-- 1. Finding the evidence which is taken on the criminal based on the criminal name
SELECT distinct Person.Fname + ' ' + Person.Lname AS 'Full Name', Evidence.Description AS 'Evidence', Crime.Crime_description AS 'Crime Description'
FROM Person
JOIN Criminal ON Criminal.National_id = Person.National_id
JOIN Participate ON Participate.criminal_id = criminal_id
JOIN Crime ON Crime.Crime_id = Participate.crime_id
JOIN Solve ON Solve.Crime_id = Crime.Crime_id
JOIN Investigation ON Investigation.Investigation_id = Solve.Investigation_id
JOIN Evidence ON Evidence.Investigation_id = Investigation.Investigation_id
WHERE Person.Fname + ' ' + Person.Lname LIKE '%';

-- 2). Retriving the The Names and The penalties and the facility of Criminal based on their Name
	SELECT Person.Fname + ' ' + Person.Lname AS 'Full Name', Penalty.Penalty_type AS 'Penalty Type', Facility.Facility_name AS 'Facility Name'
	FROM Person
	JOIN Criminal ON Criminal.National_id = Person.National_id
	JOIN Participate ON Participate.criminal_id = Criminal.National_id
	JOIN Crime ON Crime.Crime_id = Participate.crime_id
	JOIN Trial ON Trial.Crime_id = Crime.Crime_id
	JOIN Penalty ON Penalty.Trial_id = Trial.Trial_id
	JOIN Facility ON Facility.PenaltyID = Penalty.Penalty_id
	WHERE Person.Fname + ' ' + Person.Lname LIKE '%';
-- 3). Shows Victims and Their Abusers
	SELECT Abuser.Fname + ' ' + Abuser.Lname AS 'Criminal Name',Vict.Fname + ' ' + Vict.Lname AS 'Victim Name'
	FROM Person Vict
	JOIN Person Abuser ON Abuser.National_id in (Select Criminal.National_id from Criminal)
	JOIN Criminal C ON C.National_id = Abuser.National_id
	JOIN Victim V ON V.National_id = Vict.National_id
	JOIN Participate P ON C.National_id= P.criminal_id
	JOIN Involve I ON V.National_id = I.VictimID
	RIGHT OUTER JOIN Crime CR ON CR.Crime_id = I.crimeID AND CR.Crime_id = P.crime_id
-- 4). Retrieving Officers Names and the category of the Crimes that they are working on
	SELECT OfficerName As 'Officer Name', Category
	FROM (
		SELECT Person.Fname + ' ' + Person.Lname AS OfficerName, Crime.Category
		FROM Person
		JOIN LegalWorker ON LegalWorker.National_id = Person.National_id
		JOIN LegalOfficer ON LegalOfficer.National_id = LegalWorker.National_id
		JOIN Investigation ON Investigation.officer_id = LegalOfficer.National_id
		JOIN Solve ON Solve.Investigation_id = Investigation.Investigation_id
		JOIN Crime ON Crime.Crime_id = Solve.Crime_id
	) AS NestedQuery;
-- 5). Retrieving information about investigations and their corresponding solved crimes (including unsolved investigations)
	SELECT I.Investigation_id, I.Status, I.Scenario, S.Case_Notes
	FROM Investigation I
	RIGHT JOIN Solve S ON I.Investigation_id = S.Investigation_id;

-- 6). Retrieving the names of legal officers, the total number of investigations each officer has conducted, and the average duration of their investigations
	SELECT OfficerName AS 'Officer Name', TotalInvestigations AS 'Total Investigations', AVGInvestigationDuration AS 'Avarage Investigation Duration'
	FROM (
		SELECT 
			CONCAT(P.Fname, ' ', P.Lname) AS OfficerName, 
			LO.National_id AS OfficerID,
			COUNT(I.Investigation_id) AS TotalInvestigations,
			AVG(DATEDIFF(DAY, I.Start_date, I.End_date)) AS AVGInvestigationDuration
		FROM LegalOfficer LO
		JOIN LegalWorker LW ON LO.National_id = LW.National_id
		JOIN Person P ON LO.National_id = P.National_id
		LEFT JOIN Investigation I ON LO.National_id = I.officer_id
		GROUP BY CONCAT(P.Fname, ' ', P.Lname), LO.National_id
	) AS LegalOfficerStats;
---------------------------------------------------------------------------------------
--Abdelsalalm Mohammed235429
-------------------------------------------------------------------------------------
-- 1)retrieve information about open investigations, including the officer's name, badge number, scenario.

	select I.Investigation_id, I.Status, I.Start_date, I.End_date, I.Scenario, P.Fname as Officer_FirstName, P.Lname as Officer_LastName, LO.Badge_number
	from Investigation I
	join LegalOfficer LO on I.officer_id = LO.National_id
	join Person P on LO.National_id = P.National_id
	where I.Status = 'Open';

--2)list all crimes,descriptions and participants Count

	select C.Crime_id, C.Category, C.Crime_description,
	count(P.Criminal_id) as Participants_Count
	from Crime C join Participate P on C.Crime_id = P.Crime_id
	group by C.Crime_id, C.Category, C.Crime_description

--3)retrieve solved cases, including case notes and priority levels.

	select S.Crime_id, S.Investigation_id, S.Case_Notes, S.Priority_Level_, I.Status as Investigation_Status
	from Solve S
	join Investigation I on S.Investigation_id = I.Investigation_id; 

--4)list all judges and the number of cases they have presided.(left join)

	select J.National_id, P.Fname, P.Lname, J.Specialization,
	count(T.Trial_id) as Cases_Presided
	from Judge J join Person P on J.National_id = P.National_id
	left join Trial T on J.National_id = T.Judge_id
	group by J.National_id, P.Fname, P.Lname, J.Specialization;

--5)Retrieve investigations that have evidence of type 'Document'
	select I.Investigation_id, I.Status, I.Start_date, I.End_date, I.Scenario, E.Evidence_id,
	E.Type as Evidence_Type, E.Condition as Evidence_Condition, E.Details as Evidence_Details, E.Description as Evidence_Description
	from Investigation I
	join Evidence E on I.Investigation_id = E.Investigation_id
	where E.Type = 'Document';

--6)Retrieve the names of judges who have participated in trials with a guilty verdict.
	select P.Fname as Judge_FirstName, P.Lname as Judge_LastName
	from Person P
	where P.National_id IN (select J.National_id from Judge J
	JOIN Trial T on J.National_id = T.Judge_id  where T.Case_status = 'Guilty');

--7)add a new column 'Lead_investigator' (alter)
	alter table Investigation
	add Lead_investigator VARCHAR(100);

--8)Retrieve the names of criminals who have participated in investigations.(exists)
	select P.Fname as Criminal_FirstName, P.Lname as Criminal_LastName
	from Person P
	where exists (select 1 from Participate Pa where Pa.criminal_id = P.National_id);
--9)retrieve names of legal officers with no investigations.(not exisit)
	select P.Fname as Officer_FirstName, P.Lname as Officer_LastName
	from Person P
	where not exists ( select 1 from LegalOfficer LO where LO.National_id = P.National_id);

--10) retrieves investigations and associated facilites (right join)
	select Facility.Facility_id, Facility.Facility_type, Facility.Facility_name
	from Investigation
	right join Facility on Investigation.Investigation_id = Facility.PenaltyID
	where Facility.Facility_type IS NOT NULL;


	--test q1 investigation that solved crime with the name of hte witness 

	select Evidence.Details 
	From Evidence 
	where Evidence_id in (
	select Investigation.Status
	from Investigation in (
	select Person.Fname AS 'Witness name no data in table'
	where Evidence.Evidence_id = Investigation.Investigation_id
	)
	);

	add column preferred contact method


		


