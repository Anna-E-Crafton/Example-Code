DROP TABLE ARC CASCADE CONSTRAINTS;
DROP TABLE class CASCADE CONSTRAINTS;
DROP TABLE HERO CASCADE CONSTRAINTS;
DROP TABLE agency CASCADE CONSTRAINTS;
DROP TABLE INTERNSHIP CASCADE CONSTRAINTS;
DROP TABLE relation_12 CASCADE CONSTRAINTS;
DROP TABLE relation_15 CASCADE CONSTRAINTS;
DROP TABLE relation_16 CASCADE CONSTRAINTS;
DROP TABLE relation_17 CASCADE CONSTRAINTS;
DROP TABLE relation_3 CASCADE CONSTRAINTS;
DROP TABLE STAFF CASCADE CONSTRAINTS; 
DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE VILLAIN CASCADE CONSTRAINTS;



-- ARC TABLE
CREATE TABLE arc (
    arcid   VARCHAR2(100) NOT NULL,
    arcname VARCHAR2(100)
);

ALTER TABLE arc ADD CONSTRAINT arc_pk PRIMARY KEY ( arcid );


CREATE TABLE class (
    classid   NUMBER NOT NULL,
    classname VARCHAR2(1),
    studentid NUMBER NOT NULL
);


CREATE UNIQUE INDEX class__idx ON
    class (
        studentid
    ASC );

ALTER TABLE class ADD CONSTRAINT class_pk PRIMARY KEY ( classid );


CREATE TABLE hero (
    heroid     NUMBER NOT NULL,
    heroname   VARCHAR2(30),
    herorank   VARCHAR2(30),
    arcid      VARCHAR2(100) NOT NULL
);

ALTER TABLE hero ADD CONSTRAINT hero_pk PRIMARY KEY ( heroid );

-- arc id default to 0
-- HERO RECORDS
-- added staff
-- ALL ARC ID ARE 0 BY DEFAULT


-- agency
CREATE TABLE agency (
    agencyid   NUMBER NOT NULL,
    agencyname VARCHAR2(30),
    heroid     NUMBER NOT NULL
);

CREATE UNIQUE INDEX agency__idx ON
    agency (
        heroid
    ASC );

ALTER TABLE agency ADD CONSTRAINT hero_agency_pk PRIMARY KEY ( agencyid );

--AGENCY Incerts


CREATE TABLE internship (
    internshipid   NUMBER NOT NULL,
    internshipname varchar(100),
    agencyid       NUMBER NOT NULL
);

ALTER TABLE internship ADD CONSTRAINT internship_pk PRIMARY KEY ( internshipid );



CREATE TABLE relation_12 (
    hero_heroid NUMBER NOT NULL,
    arc_arcid   VARCHAR2(100) NOT NULL
);

ALTER TABLE relation_12 ADD CONSTRAINT relation_12_pk PRIMARY KEY ( hero_heroid,
                                                                    arc_arcid );

CREATE TABLE relation_15 (
    villains_villainid NUMBER NOT NULL,
    arc_arcid          VARCHAR2(100) NOT NULL
);

ALTER TABLE relation_15 ADD CONSTRAINT relation_15_pk PRIMARY KEY ( villains_villainid,
                                                                    arc_arcid );

CREATE TABLE relation_16 (
    students_studentid NUMBER NOT NULL,
    arc_arcid          VARCHAR2(100) NOT NULL
);

ALTER TABLE relation_16 ADD CONSTRAINT relation_16_pk PRIMARY KEY ( students_studentid,
                                                                    arc_arcid );

CREATE TABLE relation_17 (
    hero_agency_agencyid     NUMBER NOT NULL,
    internships_internshipid NUMBER NOT NULL
);

ALTER TABLE relation_17 ADD CONSTRAINT relation_17_pk PRIMARY KEY ( hero_agency_agencyid,
                                                                    internships_internshipid );

CREATE TABLE relation_3 (
    students_studentid NUMBER NOT NULL,
    staff_staffid      NUMBER NOT NULL
);

ALTER TABLE relation_3 ADD CONSTRAINT relation_3_pk PRIMARY KEY ( students_studentid,
                                                                  staff_staffid );

CREATE TABLE staff (
    staffid        NUMBER NOT NULL,
    stafffirst     VARCHAR2(30),
    stafflast      VARCHAR2(30),
    jobdescription VARCHAR2(100),
    heroid         NUMBER NOT NULL
);

CREATE UNIQUE INDEX staff__idx ON
    staff (
        heroid
    ASC );

ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( staffid );

CREATE TABLE student (
    studentid    NUMBER NOT NULL,
    studentfirst VARCHAR2(30),
    studentlast  VARCHAR2(30),
    studentyear  NUMBER,
    internshipid NUMBER NOT NULL,
    staffid      NUMBER NOT NULL,
    arcid        VARCHAR2(100) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( studentid );


CREATE TABLE villain (
    villainid    NUMBER NOT NULL,
    villainname  VARCHAR2(30),
    villainfirst VARCHAR2(30),
    villainlast  VARCHAR2(30),
    arcid        VARCHAR2(100) NOT NULL
);

ALTER TABLE villain ADD CONSTRAINT villains_pk PRIMARY KEY ( villainid );

ALTER TABLE class
    ADD CONSTRAINT class_student_fk FOREIGN KEY ( studentid )
        REFERENCES student ( studentid );

ALTER TABLE agency
    ADD CONSTRAINT agency_hero_fk FOREIGN KEY ( heroid )
        REFERENCES hero ( heroid );
        
ALTER TABLE hero
  ADD CONSTRAINT hero_arc_fk FOREIGN KEY ( arcid )
       REFERENCES arc ( arcid );

ALTER TABLE internship
    ADD CONSTRAINT internships_hero_agency_fk FOREIGN KEY ( agencyid )
        REFERENCES agency ( agencyid );

ALTER TABLE relation_12
    ADD CONSTRAINT relation_12_arc_fk FOREIGN KEY ( arc_arcid )
        REFERENCES arc ( arcid );


ALTER TABLE relation_12
    ADD CONSTRAINT relation_12_hero_fk FOREIGN KEY ( hero_heroid )
        REFERENCES hero ( heroid );

ALTER TABLE relation_15
    ADD CONSTRAINT relation_15_arc_fk FOREIGN KEY ( arc_arcid )
        REFERENCES arc ( arcid );

ALTER TABLE relation_15
    ADD CONSTRAINT relation_15_villains_fk FOREIGN KEY ( villains_villainid )
        REFERENCES villain ( villainid );

ALTER TABLE relation_16
    ADD CONSTRAINT relation_16_arc_fk FOREIGN KEY ( arc_arcid )
        REFERENCES arc ( arcid );

ALTER TABLE relation_16
    ADD CONSTRAINT relation_16_students_fk FOREIGN KEY ( students_studentid )
        REFERENCES student ( studentid );
        
 ALTER TABLE relation_17
    ADD CONSTRAINT relation_17_hero_agency_fk FOREIGN KEY ( hero_agency_agencyid )
        REFERENCES agency ( agencyid );
        
ALTER TABLE relation_17
    ADD CONSTRAINT relation_17_internships_fk FOREIGN KEY ( internships_internshipid )
        REFERENCES internship ( internshipid );

ALTER TABLE relation_3
    ADD CONSTRAINT relation_3_staff_fk FOREIGN KEY ( staff_staffid )
        REFERENCES staff ( staffid );

ALTER TABLE relation_3
    ADD CONSTRAINT relation_3_students_fk FOREIGN KEY ( students_studentid )
        REFERENCES student ( studentid );

ALTER TABLE staff
    ADD CONSTRAINT staff_hero_fk FOREIGN KEY ( heroid )
        REFERENCES hero ( heroid );

ALTER TABLE student
    ADD CONSTRAINT students_arc_fk FOREIGN KEY ( arcid )
        REFERENCES arc ( arcid );

ALTER TABLE student
    ADD CONSTRAINT students_internships_fk FOREIGN KEY ( internshipid )
        REFERENCES internship ( internshipid );

ALTER TABLE student
    ADD CONSTRAINT students_staff_fk FOREIGN KEY ( staffid )
        REFERENCES staff ( staffid );

ALTER TABLE villain
    ADD CONSTRAINT villains_arc_fk FOREIGN KEY ( arcid )
        REFERENCES arc ( arcid );


-- Inserts Start Here
-- Some keys are inaccurate! 
-- Table Order is Important!!

-- ARC INSERTS
insert into arc (arcid, arcname) values ('0', 'Default');
insert into arc(arcid, arcname) values ('1', 'Entrance Exams');
insert into arc(arcid, arcname) values ('2', 'USJ');
insert into arc(arcid, arcname) values ('3', 'Hero Killer');
insert into arc(arcid, arcname) values ('4', 'Forest Training');
insert into arc(arcid, arcname) values ('5', 'Hideout Raid');
insert into arc(arcid, arcname) values ('6', 'Provisional License Exams');
insert into arc(arcid, arcname) values ('7', 'Remedial Course');
insert into arc(arcid, arcname) values ('8', 'School Festival');
insert into arc(arcid, arcname) values ('9', 'Pro Hero Arc');
insert into arc(arcid, arcname) values ('10', 'Meta Liberation Arc'); 

--HERO INSERTS
insert into hero(heroid, heroname, herorank, ARCID) 
values ('1', 'All Might', '1', 1);
insert into hero(heroid, heroname, herorank, ARCID) -- Internship
values ('2', 'Endeavor', '2', 10);
insert into hero(heroid, heroname, herorank, ARCID) -- Internship
values('3', 'Hawks', '3', 10);
insert into hero(heroid, heroname, herorank, ARCID)
values('10', 'Ectoplasm', '11', 4);
insert into hero(heroid, heroname, herorank, ARCID)
values ('4', 'Mt. Lady', '23', 4);
insert into hero(heroid, heroname, herorank, ARCID)
values ('5', 'Gang Orca', '12', 6);
insert into hero(heroid, heroname, herorank, ARCID)-- Internship
values('6', 'Best Jeanist', '4', 6);
insert into hero(heroid, heroname, herorank, ARCID)
values('7', 'Nighteye', NULL, 6);
insert into hero(heroid, heroname, herorank, ARCID) -- 3rd year Internship (not added yet)
values('8', 'Mirko', '5', 5);
insert into hero(heroid, heroname, herorank, ARCID)
values('9', 'Fat Gum', '58', 5);
insert into hero(heroid, heroname, ARCID) -- unknown rank, underground? 
values('11', 'Eraserhead', 4);
insert into hero(heroid, heroname, ARCID) -- Didn't look up rank
values('12', 'Present Mic', 4);
insert into hero(heroid, heroname,ARCID) -- Didn't look up rank
values('13', 'Recovery Girl', 8);
insert into hero(heroid, heroname, ARCID) -- unknown rank, underground? 
values('14', 'Nedzu', 8);
insert into hero(heroid, heroname, ARCID) -- Didn't look up rank 
values('15', 'Midnight', 9);
insert into hero(heroid, heroname, ARCID) -- Didn't look up rank 
values('16', 'Lunch Rush', 7); 
insert into hero(heroid, heroname, ARCID) -- Didn't look up rank 
values('17', 'Hound Dog', 8); 
insert into hero(heroid, heroname, ARCID) -- Didn't look up rank 
values('18', 'Vald King', 1);
insert into hero(heroid, heroname, ARCID) -- Internship, Didn't look up rank
values('19', 'Selkie', 7);
insert into hero(heroid, heroname, ARCID) -- Internship, Didn't look up rank
values('20', 'Death Arms', 6); 
insert into hero(heroid, heroname, ARCID) -- Internship, Didn't look up rank
values('21', 'Uwabami' , 7); 
insert into hero(heroid, heroname, ARCID) -- Internship, Didn't look up rank
values('22', 'Fourth Kind', 8); 
insert into hero(heroid, heroname, ARCID) -- Internship, Didn't look up rank
values('23', 'Gunhead', 9); 
insert into hero(heroid, heroname, ARCID) -- Internship, Didn't look up rank
values('24', 'Manual', 3); 
insert into hero(heroid, heroname, ARCID) -- Internship, Didn't look up rank
values('25', 'Gran Torino', 0); 

--STAFF_INSERTS
INSERT INTO STAFF (STAFFID, STAFFFIRST, STAFFLAST, JOBDESCRIPTION, HEROID)
VALUES(1, 'Toshinori', 'Yagi', 'teacher', '01');

INSERT INTO STAFF VALUES
(2, 'Shota', 'Aizawa','teacher','11');

INSERT INTO STAFF VALUES
(3, 'Hizashi', 'Yamada', 'teacher','12');

INSERT INTO STAFF VALUES
(4, 'Shūzenji', 'Chiyo','nurse','13');

INSERT INTO STAFF VALUES
(5, 'Nedzu', NULL,'principal','14');

INSERT INTO STAFF VALUES
(6, 'Nemuri', 'Kayama','teacher','15');

INSERT INTO STAFF VALUES
(7, 'Kurose', 'Anan', 'teacher','03'); --thirteen

INSERT INTO STAFF VALUES
(8, 'Ranchi', 'Russhu','cook','16'); --food guy

INSERT INTO STAFF VALUES
(9, 'Ryo', 'Inui', 'councler','17'); 

INSERT INTO STAFF VALUES
(10, 'Sekijiro', 'Kan','teacher','18'); --Vald


--AGENCY INSERTS
insert into agency(agencyid, agencyname, heroid) values ('1', 'Endeavor Agency', '2');
insert into agency(agencyid, agencyname, heroid) values ('2', 'Fat Gum Agency', '9');
insert into agency(agencyid, agencyname, heroid) values ('3', 'Genius Office', '6');
insert into agency(agencyid, agencyname, heroid) values ('4', 'Hawks` Agency', '3');
insert into agency(agencyid, agencyname, heroid) values ('5', 'Might Tower', '1');
insert into agency(agencyid, agencyname, heroid) values ('6', 'Mt. Agency', '4');
insert into agency(agencyid, agencyname, heroid) values ('7', 'Nighteye Agency', '7');
insert into agency(agencyid, agencyname, heroid) values ('8', 'Ryuku Agency', '8');
insert into agency(agencyid, agencyname, heroid) values ('9', 'Gang Orca Agency', '5'); 
insert into agency(agencyid, agencyname, heroid) values ('10', 'Gunhead Agency', '23');
insert into agency (agencyid, agencyname, heroid) values ('11', 'Normal Agency', '24');
insert into agency (agencyid, agencyname, heroid) values ('12', 'Fourth Kind Agency', '22');
insert into agency (agencyid, agencyname, heroid) values('13', 'Underground', '11');
insert into agency (agencyid, agencyname, heroid) values('14', 'Death Arms Agency', '20');


INSERT INTO INTERNSHIP (INTERNSHIPID, INTERNSHIPNAME, AGENCYID)
VALUES ('00', 'Mastering One-For-All', 5 ); -- Deku, ALl Might
INSERT INTO INTERNSHIP VALUES ('1', 'Birds of a Feather', '1' ); -- Tokiami (emo bird), Hawlks
INSERT INTO INTERNSHIP VALUES ('2', 'Hunt in Hosu City', 11 ); -- Ida, Manual
INSERT INTO INTERNSHIP VALUES ('3', 'Bad Hair Day TM', 3 ); -- Katsuki, Best Jeanist
INSERT INTO INTERNSHIP VALUES ('4', 'Gunhead Martial Arts', '10' ); -- Ochoko, Gunhead
INSERT INTO INTERNSHIP VALUES ('5', 'Guts and Chialry', '12' ); -- Kirishima, Tetsu Tetsu, Fourth Kind
INSERT INTO INTERNSHIP VALUES ('6', 'Good Hair Day TM', '8' ); -- Momo, Itsuka, Uwabami
INSERT INTO INTERNSHIP VALUES ('7', 'Heros at Sea', '9' ); -- Froppy, Selkie
INSERT INTO INTERNSHIP VALUES ('8', 'Forshadowing', '1' ); -- Shoto, Endevor
INSERT INTO INTERNSHIP VALUES ('9', 'What is Sleep?', '13' ); -- Shinsou, Aizawa
INSERT INTO INTERNSHIP VALUES ('10', 'Death Metal',  '14'); -- Kyoka, Death Arms

-- STUDENT INCERTS
INSERT INTO STUDENT (STUDENTID, STUDENTFIRST, STUDENTLAST, STUDENTYEAR, INTERNSHIPID, STAFFID, ARCID)
VALUES --ID, first, last, year, internshipid, staffid, arcid
(1, 'Izuku', 'Midoriya', 1, 0, 2 , 3);

INSERT INTO STUDENT VALUES
(2, 'Katsuki', 'Bakugo', 1, 3, 2 , 1);

INSERT INTO STUDENT VALUES
(3, 'Shoto', 'Todoroki', 1, 8, 2 , 3);

INSERT INTO STUDENT VALUES
(4, 'Ochako', 'Uraraka', 1, 4, 2, 1);

INSERT INTO STUDENT VALUES
(5, 'Tenya', 'Ida', 1, 2, 2, 3);

INSERT INTO STUDENT VALUES
(6, 'Hitoshi', 'Shinso', 1, 9, 10, 0);

INSERT INTO STUDENT VALUES
(7, 'Tsyu', 'Asu', 1, 7, 2, 2);

INSERT INTO STUDENT VALUES
(8, 'Tokiymai', NULL, 1, 1, 2, 2);

INSERT INTO STUDENT VALUES
(9, 'Mirio', NULL, 3, 1, 2, 2);

INSERT INTO STUDENT VALUES
(10, 'Enjiro', 'Kirishima', 1, 5, 2, 5);

INSERT INTO STUDENT VALUES
(11, 'Tetsu', 'Tetsu', 1, 5, 2, 5);

INSERT INTO STUDENT VALUES
(12, 'Koyka', 'Jiro', 1, 10, 3, 8);

INSERT INTO STUDENT VALUES
(13, 'Momo', 'Yayozoru', 1, 6, 2, 8);

INSERT INTO STUDENT VALUES
(14, '?', 'Itsuka', 1, 6, 2, 1); 





-- VILLAIN Incerts
insert into  villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('001', 'All For One', 'Shigaraki', NULL, 10);
insert into  villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('002', NULL, 'Tomura', 'Shigaraki', 2);
insert into  villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('003', 'Twice', 'Jin', 'Bubaigawara', 2);
insert into  villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('004', 'Dabi', 'Toya', 'Todoroki', 10);
insert into villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('005', NULL, 'Toga', 'Himiko', 10);
insert into  villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('006', 'Stain', 'Chizome', 'Akaguro', 3);
insert into  villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('007', 'Spinner', 'Shuichi', 'Iguchi', 5);
insert into  villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('008', 'Overhaul', 'Kai', 'Chisaki', 9);
insert into villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('009', 'Iceman', 'Geten', NULL, 4);
insert into  villain(villainid, villainname, villainfirst, villainlast, ARCID)
values ('010', 'Nomu', NULL, NULL, 2);

INSERT INTO CLASS (CLASSID, CLASSNAME, STUDENTID)
VALUES (01, 'A', 01);  
INSERT INTO CLASS (CLASSID, CLASSNAME, STUDENTID)
VALUES (03, 'B', 09); 
INSERT INTO CLASS (CLASSID, CLASSNAME, STUDENTID)
VALUES (02, 'A', 10); 
INSERT INTO CLASS (CLASSID, CLASSNAME, STUDENTID)
VALUES (04, 'B', 11); 
INSERT INTO CLASS (CLASSID, CLASSNAME, STUDENTID)
VALUES (05, 'C', 13); 




COMMIT;
