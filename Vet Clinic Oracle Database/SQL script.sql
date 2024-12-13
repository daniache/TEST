----------------------------------- DROPING TABLES-------------------------------------------

DROP TABLE prescription;
DROP TABLE diagnosis;
DROP TABLE medication;
DROP TABLE illness;
DROP TABLE nursesInAppointment;
DROP TABLE appointment;
DROP TABLE nurse;
DROP TABLE doctor;
DROP TABLE pet;
DROP TABLE petOwner;


----------------------------------- CREATING TABLES ---------------------------------------


CREATE TABLE petOwner (
    ownerId NUMBER GENERATED ALWAYS AS IDENTITY START WITH 5000 INCREMENT BY 1 CHECK (ownerId < 7000),
    ownerName VARCHAR2(50) NOT NULL,
    ownerAddress VARCHAR2(250) NOT NULL,
    ownerAge NUMBER NOT NULL,
    ownerMobileNumber NUMBER NOT NULL,
  
  	CONSTRAINT pk_petOwner PRIMARY KEY (ownerId)
);


CREATE TABLE pet (
    petId NUMBER GENERATED ALWAYS AS IDENTITY START WITH 1000 INCREMENT BY 1 CHECK (petId <=  3000),
    ownerId NUMBER,
    petName VARCHAR2(50) NOT NULL,
    petAge NUMBER NOT NULL CHECK (petAge > 0 AND petAge <= 12),
    petBreed VARCHAR2(50) NOT NULL,
    petWeight FLOAT NOT NULL,
    petColor VARCHAR2(25) NOT NULL,
    petSex CHAR(1) NOT NULL CHECK (petSex IN ('M', 'F')),
    petType VARCHAR2(25) NOT NULL,
  
    CONSTRAINT pk_petId PRIMARY KEY (petId),
    CONSTRAINT fk_petOwner FOREIGN KEY (ownerId) REFERENCES petOwner(ownerId)
);


CREATE TABLE doctor (
    doctorId NUMBER GENERATED ALWAYS AS IDENTITY START WITH 001 INCREMENT BY 1 CHECK (doctorId < 100),
    doctorName VARCHAR2(100) NOT NULL,
    doctorPhone NUMBER NOT NULL,
    doctorEmail VARCHAR2(50) NOT NULL UNIQUE,
    doctorIsFullTime CHAR(1) CHECK (doctorIsFullTime IN ('Y', 'N')) NOT NULL,
    doctorOfficeNumber NUMBER NOT NULL,

  	CONSTRAINT pk_doctorId PRIMARY KEY (doctorId)
);


CREATE TABLE nurse (
    nurseId NUMBER GENERATED ALWAYS AS IDENTITY START WITH 100 INCREMENT BY 1 CHECK (nurseId < 300),
    nurseName VARCHAR2(100) NOT NULL,
    nursePhone NUMBER NOT NULL,
    nurseEmail VARCHAR2(50) NOT NULL,
    nurseIsFullTime CHAR(1) CHECK (nurseIsFullTime IN ('Y', 'N')) NOT NULL,
    
    CONSTRAINT pk_nurseId PRIMARY KEY (nurseId)
);


CREATE TABLE appointment (
    apptId NUMBER GENERATED ALWAYS AS IDENTITY START WITH 50000 INCREMENT BY 1 CHECK (apptId < 70000),
    doctorId NUMBER,
    petId NUMBER,
    apptdate DATE NOT NULL,
    apptattended CHAR CHECK (apptattended IN ('Y', 'N')),
    apptfees NUMBER CHECK (apptfees IN (10,15,20)),
    apptcancelFeePaid CHAR CHECK (apptcancelFeePaid IN ('Y', 'N')),
    apptisDeferral CHAR CHECK (apptisDeferral IN ('Y', 'N')),
    apptNotes VARCHAR2(250),
  
    CONSTRAINT pk_appId PRIMARY KEY (apptId),
    CONSTRAINT fk_appDoctor FOREIGN KEY (doctorId) REFERENCES doctor (doctorId),
    CONSTRAINT fk_appPet FOREIGN KEY (petId) REFERENCES pet (petId),
    -- THE APPOINTMENT DATE CAN ONLY BE ON MONDAY OR FRIDAY. EXISITING APPOINMENT DATES ARE NOT MONDAY OR FRIDAY. 
    --SO, THE FUTURE APPOINTMENT MADE IN AND AFTER NOVEMBER 2023, WILL BE ALLOWED, ONLY IF ITS A FRIDAY OR MONEY.
    CONSTRAINT apptDayCheck CHECK (apptdate < TO_DATE('2023-11-01', 'YYYY-MM-DD') OR (TO_CHAR(apptdate, 'DY') IN ('MON', 'FRI')))
);
    

CREATE TABLE nursesInAppointment (
    apptId NUMBER,
    nurseId NUMBER,
  
    CONSTRAINT pk_nursesInApp PRIMARY KEY (apptId, nurseId),
    CONSTRAINT fk_nursesInAppApp FOREIGN KEY (apptId) REFERENCES appointment(apptId),
    CONSTRAINT fk_nursesInAppNurse FOREIGN KEY (nurseId) REFERENCES nurse(nurseId)
);

CREATE TABLE illness (
    illnessId NUMBER GENERATED ALWAYS AS IDENTITY START WITH 300 INCREMENT BY 1 CHECK (illnessId < 500),
    illnessName VARCHAR(50) NOT NULL,

  	CONSTRAINT pk_illnessId PRIMARY KEY (illnessId)
);


CREATE TABLE medication (
    medId NUMBER GENERATED ALWAYS AS IDENTITY START WITH 500 INCREMENT BY 1 CHECK (medId < 1000),
    medName VARCHAR2(50) NOT NULL,
    medPrice FLOAT NOT NULL,
    pharmacy VARCHAR2(50) NOT NULL,

    CONSTRAINT pk_medId PRIMARY KEY (medId)
);


CREATE TABLE diagnosis (
    apptId NUMBER,
    illnessId NUMBER,
  
    CONSTRAINT pk_diagnosis PRIMARY KEY (apptId, illnessId),
    CONSTRAINT fk_diagnosisApp FOREIGN KEY (apptId) REFERENCES appointment (apptId),
    CONSTRAINT fk_diagnosisIll FOREIGN KEY (illnessId) REFERENCES illness (illnessId)
);


CREATE TABLE prescription (
    prescId NUMBER GENERATED ALWAYS AS IDENTITY START WITH 20000 INCREMENT BY 1 CHECK (prescId < 50000),
    apptId NUMBER,
    illnessId NUMBER,
    medId NUMBER,
    prescDate DATE NOT NULL,

  	CONSTRAINT pk_prescId PRIMARY KEY (prescId),
    CONSTRAINT fk_prescriptionApp FOREIGN KEY (apptId) REFERENCES appointment (apptId),
    CONSTRAINT fk_prescriptionIll FOREIGN KEY (illnessId) REFERENCES illness (illnessId),
    CONSTRAINT fk_prescriptionMed FOREIGN KEY (medId) REFERENCES medication (medId)
);


----------------------------------INSERTING DATA INTO TABLES----(with FIVE additional tuples)-------------------------------

-------------------TO PETOWNER TABLE

INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('David', '42 Willow Street Manchester M14 7QH', 30, 07234567890);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Sam', '17 Beechwood Avenue Manchester M3 5FP', 60, 07345678901);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Craig', '29 Elmwood Terrace Manchester M12 6JN', 50, 07456789012);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('George', '8 Sycamore Lane Manchester M16 9DW', 21, 07567890123);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Kylie', '56 Oakwood Close Manchester M8 4NP', 37, 07678901234);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Chabbu', '12 Cedar Avenue Manchester M21 5LN', 28, 07789012345);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Sarah', '7 Pine Grove Manchester M19 8UQ', 22, 07890123456);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Gabby', '3 Maple Street Manchester M17 8XY', 36, 07901234567);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Karu', '4 Deansgate Street Manchester', 38, 07012345678);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Gayan', '25 Canal Street Manchester', 39, 07123456789);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Suman', '63 King Street Manchester', 65, 07234567891);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Ben', '222 Shambles Square Manchester', 42, 07345678902);
INSERT INTO petOwner (ownerName, ownerAddress, ownerAge, ownerMobileNumber) VALUES ('Lilly', '56 Gold Street Manchester', 56, 07456789013);


-------------------TO PET TABLE

-- For David's Pet (ownerId = 5000)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5000, 'ChappyDog', 2, 'Alsation', 3, 'Beige', 'M', 'Dog');
-- For Sam's Pet (ownerId = 5001)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5001, 'Chiwado', 10, 'Chiwawa', 1, 'Black', 'F', 'Dog');
-- For Craig's Pet (ownerId = 5002)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5002, 'BullyTom', 6, 'Bulldog', 4.5, 'Grey', 'F', 'Dog');
-- For George's Pet (ownerId = 5003)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5003, 'TerryToe', 4, 'Terrier', 1.2, 'White', 'F', 'Dog');
-- For Kylie's Pets (ownerId = 5004)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5004, 'Poody', 8, 'Boxer', 1, 'Black', 'M', 'Dog');
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5004, 'LabbyDee', 12, 'Labrador', 11, 'White', 'M', 'Dog');
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5004, 'ShiTzo', 7, 'Shih Tzu', 1, 'Mixed Brown', 'F', 'Dog');
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5004, 'Gotty', 4, 'Shih Tzu', 1, 'Mixed Brown', 'M', 'Dog');
-- For Chabbu's Pet (ownerId = 5005)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5005, 'Dood', 3, 'Dalmation', 7, 'Spotted', 'F', 'Dog');
-- For Sarah's Pet (ownerId = 5006)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5006, 'Dood', 11, 'SheepWolf', 10, 'Brown', 'M', 'Dog');
-- For Gabby's Pet (ownerId = 5007)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5007, 'Jake', 3, 'Shih Tzu', 4, 'Greyish White', 'M', 'Dog');
-- For Karu's Pet (ownerId = 5008)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5008, 'Sparky', 4, 'Australian Shepherd', 4, 'Black', 'M', 'Dog');
-- For Gayan's Pet (ownerId = 5009)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5009, 'Gizmo', 7, 'Shih Tzu', 4, 'White', 'M', 'Dog');
-- For Suman's Pet (ownerId = 5010)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5010, 'Luna', 2, 'Dalmation', 4, 'Spotted', 'F', 'Dog');
-- For Ben's Pet (ownerId = 5011)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5011, 'Max', 1, 'Dalmation', 4, 'Spotted', 'M', 'Dog');
-- For Lilly's Pet (ownerId = 5012)
INSERT INTO pet (ownerId, petName, petAge, petBreed, petWeight, petColor, petSex, petType) 
VALUES (5012, 'Bella', 9, 'Boxer', 4, 'Black', 'F', 'Dog');


-------------------TO DOCTOR TABLE

INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime,doctorOfficeNumber ) 
VALUES ('Cleverly',073628598746,'cleverly_cl@noahs.com', 'N', 12);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime,doctorOfficeNumber ) 
VALUES ('Mike', 073628547890, 'mikeK@noahs.com', 'Y', 34);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime,doctorOfficeNumber ) 
VALUES ('Farraday', 073628567321, 'farradayF@noahs.com', 'Y', 34);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime,doctorOfficeNumber ) 
VALUES ('Fred', 073628576132, 'fredF@noahs.com', 'Y', 41);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime,doctorOfficeNumber ) 
VALUES ('Watson', 073628589043, 'watsS@noahs.com', 'Y',1);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime,doctorOfficeNumber ) 
VALUES ('Freeman', 073628543214, 'freemanF@noahs.com', 'Y',2);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime,doctorOfficeNumber ) 
VALUES ('Crowley', 073628565432, 'crowleyC@noahs.com', 'Y', 10);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime,doctorOfficeNumber ) 
VALUES ('Rahib', 073628512345, 'rahibB@noahs.com', 'Y', 16);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime, doctorOfficeNumber) 
VALUES ('Hannah', 07654321890, 'hannahA@noahs.com', 'N', 20);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime, doctorOfficeNumber) 
VALUES ('Lucas', 07432156987, 'lucasB@noahs.com', 'Y', 25);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime, doctorOfficeNumber) 
VALUES ('Evelyn', 07561238900, 'evelynC@noahs.com', 'N', 30);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime, doctorOfficeNumber) 
VALUES ('Mason', 07765412300, 'masonD@noahs.com', 'N', 35);
INSERT INTO doctor (doctorName, doctorPhone, doctorEmail, doctorIsFullTime, doctorOfficeNumber) 
VALUES ('Sophia', 07987654321, 'sophiaE@noahs.com', 'N', 40);


-------------------TO NURSE TABLE

INSERT INTO nurse (nurseName, nursePhone, nurseEmail, nurseIsFullTime) VALUES ('Alice', 073621234567, 'alice@noahs.com', 'Y');
INSERT INTO nurse (nurseName, nursePhone, nurseEmail, nurseIsFullTime) VALUES ('Bob', 073627654321, 'bob@noahs.com', 'N');
INSERT INTO nurse (nurseName, nursePhone, nurseEmail, nurseIsFullTime) VALUES ('Carol', 073629876543, 'carol@noahs.com', 'Y');
INSERT INTO nurse (nurseName, nursePhone, nurseEmail, nurseIsFullTime) VALUES ('David', 073624567890, 'david@noahs.com', 'N');
INSERT INTO nurse (nurseName, nursePhone, nurseEmail, nurseIsFullTime) VALUES ('Eve', 073628765432, 'eve@noahs.com', 'Y');


--------------------TO APPOINTMENT TABLE
--0-5 yrs, £10 per visit; 5-10 yrs, £15 per visit; 10-12 yrs, £20 per visit

-- For Pet ChappyDog (2 years old, fee £10)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (2, 1000, TO_DATE('2023-08-05', 'YYYY-MM-DD'), 'Y', 10, 'N', 'N', 'Bring him Tuesdays 10 to 12.00pm');
-- For Chiwado (10 years old, fee £15)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (1, 1001, TO_DATE('2023-08-05', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Get Drug AA from Smiths Pharmacy');
-- For Pet LabbyDee (12 years old, fee £20)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (2, 1005, TO_DATE('2023-08-09', 'YYYY-MM-DD'), 'Y', 20, 'Y', 'N', 'Take Park walks every evening');
-- For BullyTom (6 years old, fee £15)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (3, 1002, TO_DATE('2023-08-16', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Surgery on 21-Nov-23');
-- For BullyTom (6 years old, fee £15)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (5, 1002, TO_DATE('2023-10-07', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Routine health examination next month');
-- For Poody (8 years old, fee £15)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (4, 1002, TO_DATE('2023-10-11', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Surgery on 27-Nov-23');
-- For ShiTzo (7 years old, fee £15)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (7, 1004, TO_DATE('2023-09-02', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Routine health examination next month');
-- For Dood (3 years old, fee £10)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (3, 1008, TO_DATE('2023-09-06', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Dental check next week');
-- For Luna (2 years old, fee £10)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (5, 1013, TO_DATE('2023-09-27', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Routine health examination next month');
-- For Max (1 years old, fee £10)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (4, 1014, TO_DATE('2023-10-04', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Surgery on 27-Nov-23');

-- For Pet Dood (11 years old, fee £20)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (3, 1009, TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Y', 10, 'N', 'N', 'Surgery on 21-Feb-24');
-- For ChappyDog (2 years old, fee £10)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (7, 1000, TO_DATE('2023-11-10', 'YYYY-MM-DD'), 'Y', 10, 'N', 'N', 'Checkup and vaccinations');
-- For Chiwado (10 years old, fee £15)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (1, 1001, TO_DATE('2023-11-24', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Routine health examination next month');
-- For BullyTom (6 years old, fee £15)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (9, 1002, TO_DATE('2023-11-24', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'Dental check next week');
-- For TerryToe (4 years old, fee £10)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (1, 1003, TO_DATE('2023-11-27', 'YYYY-MM-DD'), 'Y', 10, 'N', 'N', 'Ear infection treatment day after');
-- For Poody (8 years old, fee £15)
INSERT INTO appointment (doctorId, petId, apptdate, apptattended, apptfees, apptcancelFeePaid, apptisDeferral, apptNotes) 
VALUES (11, 1004, TO_DATE('2023-11-27', 'YYYY-MM-DD'), 'Y', 15, 'N', 'N', 'General wellness check next month');


--------------------TO NURSES IN APPOINTMENTS TABLE

INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50000, 100);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50001, 101);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50002, 102);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50003, 100);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50004, 104);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50005, 101);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50006, 102);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50007, 103);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50008, 101);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50009, 104);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50010, 102);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50011, 101);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50012, 100);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50013, 100);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50014, 103);
INSERT INTO nursesInAppointment (apptId, nurseId) VALUES (50015, 101);


---------------------TO ILLNESS TABLE

INSERT INTO illness (illnessName) VALUES ('Ear Infection');
INSERT INTO illness (illnessName) VALUES ('Dental Issues');
INSERT INTO illness (illnessName) VALUES ('Skin Allergy');
INSERT INTO illness (illnessName) VALUES ('Arthritis');
INSERT INTO illness (illnessName) VALUES ('Obesity');
INSERT INTO illness (illnessName) VALUES ('Anxiety');
INSERT INTO illness (illnessName) VALUES ('Heartworm');
INSERT INTO illness (illnessName) VALUES ('Lack of Socialisation');
INSERT INTO illness (illnessName) VALUES ('Epilepsy');
INSERT INTO illness (illnessName) VALUES ('Kidney Disease');


----------------------TO DIAGNOSIS TABLE

INSERT INTO diagnosis (apptId, illnessId) VALUES (50000, 300);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50001, 301);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50002, 302);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50003, 303);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50004, 304);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50005, 301);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50006, 306);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50007, 307);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50008, 302);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50009, 301);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50010, 303);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50011, 304);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50012, 305);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50013, 306);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50014, 301);
INSERT INTO diagnosis (apptId, illnessId) VALUES (50015, 307);


-----------------------TO MEDICATION TABLE

INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Paracetamol', 20.10, 'Smiths Pharmacy');
INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Penicillin', 15.20, 'Johnsons Pharmacy');
INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Nobivac', 25.60, 'Smiths Pharmacy');
INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Antiparasitic', 30.80, 'Smiths Pharmacy');
INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Ibuprofen', 18.90, 'HealthMart Pharmacy');
INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Aspirin', 22.40, 'Community Vet Pharmacy');
INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Cetirizine', 28.60, 'Community Vet Pharmacy');
INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Omeprazole', 35.40, 'Johnsons Pharmacy');
INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Cephalexin', 40.10, 'Community Vet Pharmacy');
INSERT INTO medication (medName, medPrice, pharmacy) VALUES ('Enrofloxacin', 17.00, 'Johnsons Pharmacy');


------------------------TO PRESCRIPTION TABLE

INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50000, 300, 504, TO_DATE('2023-08-05', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50001, 307, 505, TO_DATE('2023-08-05', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50002, 302, 505, TO_DATE('2023-08-09', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50003, 303, 500, TO_DATE('2023-08-16', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50004, 304, 502, TO_DATE('2023-10-07', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50005, 301, 500, TO_DATE('2023-10-11', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50006, 306, 504, TO_DATE('2023-09-02', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50007, 307, 505, TO_DATE('2023-09-06', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50008, 302, 505, TO_DATE('2023-09-27', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50009, 301, 500, TO_DATE('2023-10-04', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50010, 300, 509, TO_DATE('2023-11-10', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50011, 304, 506, TO_DATE('2023-11-10', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50012, 305, 504, TO_DATE('2023-11-24', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50013, 300, 509, TO_DATE('2023-11-24', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50014, 301, 500, TO_DATE('2023-11-27', 'YYYY-MM-DD'));
INSERT INTO prescription (apptId, illnessId, medId, prescDate) VALUES (50015, 307, 505, TO_DATE('2023-11-27', 'YYYY-MM-DD'));


----------------------------------------------RETRIEVE DATA FROM EACH TABLE-----------------------------------------

SELECT * FROM petOwner;
SELECT * FROM pet;
SELECT * FROM doctor;
SELECT * FROM nurse;
SELECT * FROM appointment;
SELECT * FROM nursesInAppointment;
SELECT * FROM illness;
SELECT * FROM diagnosis;
SELECT * FROM medication;
SELECT * FROM prescription;
