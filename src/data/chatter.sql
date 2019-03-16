-- Start of Sample SQL Script
-- ***************************
--  Project Phase II
--  Group 2 (PostgreSQL)
--  This SQL Script created in PostgreSQL DBMS.
--  Postgre server was ran locally and was tested on
--  pgAdmin 4, a deskto management software for postgres.
--  You can run this script in any PostgreSQL server environment.
--  Group Members: Carl Argabright, Andrew Kim, Jason Dhami, Steven Huang
-- ***************************
-- Part A
-- ***************************

-- Table Device: store data about type of device such as android
DROP TABLE IF EXISTS DEVICE CASCADE;
CREATE TABLE DEVICE (DeviceID INT NOT NULL PRIMARY KEY,
                    Device VARCHAR(255) NOT NULL
);

-- Table Service: store data about type of service such as Verizon
DROP TABLE IF EXISTS SERVICE CASCADE;
CREATE TABLE SERVICE (ServiceID INT NOT NULL PRIMARY KEY,
                      Service VARCHAR(255),
                      Price INT NOT NULL
);

-- TABLE_PERSONAL_INFO: store data about member Personal Info
DROP TABLE IF EXISTS PERSONAL_INFO CASCADE;
CREATE TABLE PERSONAL_INFO (InfoID INT NOT NULL PRIMARY KEY,
                            Zip INT,
                            PhoneNumber VARCHAR(255),
                            Gender CHAR(1),
                            Age INT,
                            ServiceID INT,
                            DeviceID INT,
                            FOREIGN KEY(ServiceID) REFERENCES Service(ServiceID) ON DELETE SET NULL ON UPDATE CASCADE,
                            FOREIGN KEY(DeviceID) REFERENCES Device(DeviceID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- MEMBERS: store data about members
DROP TABLE IF EXISTS Members CASCADE;
CREATE TABLE Members (MemberID INT NOT NULL PRIMARY KEY,
                      FirstName VARCHAR(255) NOT NULL,
                      LastName VARCHAR(255) NOT NULL,
                      Username VARCHAR(255) NOT NULL UNIQUE,
                      Email VARCHAR(255) NOT NULL UNIQUE,
                      Password VARCHAR(255) NOT NULL,
                      SALT VARCHAR(255),
                      Verification INT DEFAULT 0,
                      InfoID INT,
                      FOREIGN KEY(InfoID) REFERENCES PERSONAL_INFO(InfoID) ON DELETE SET NULL ON UPDATE CASCADE
);

-- CHATS: store data about chats
DROP TABLE IF EXISTS Chats CASCADE;
CREATE TABLE Chats (ChatID INT NOT NULL PRIMARY KEY,
                    Name VARCHAR(255),
                    CreatedAt TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp
);

-- MESSAGES: store data about messages
DROP TABLE IF EXISTS Messages CASCADE;
CREATE TABLE Messages (MessageID INT NOT NULL PRIMARY KEY,
                      ChatID INT,
                      Message VARCHAR(255),
                      MemberID INT NOT NULL,
                      CreatedAt TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
                      FOREIGN KEY(ChatID) REFERENCES Chats(ChatID) ON DELETE CASCADE ON UPDATE CASCADE,
                      FOREIGN KEY(MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE ON UPDATE CASCADE
);


-- CONTACTS: store data about member contacts
DROP TABLE IF EXISTS Contacts CASCADE;
CREATE TABLE Contacts(ContactID INT NOT NULL PRIMARY KEY,
                      MemberID_A INT NOT NULL,
                      MemberID_B INT NOT NULL,
                      Verified INT DEFAULT 0,
                      FriendsSince TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
                      FOREIGN KEY(MemberID_A) REFERENCES Members(MemberID) ON DELETE CASCADE ON UPDATE CASCADE,
                      FOREIGN KEY(MemberID_B) REFERENCES Members(MemberID) ON DELETE CASCADE ON UPDATE CASCADE
);


-- chatmembers: store data about chat members
DROP TABLE IF EXISTS ChatMembers;
CREATE TABLE ChatMembers (ChatID INT NOT NULL,
                          MemberID INT NOT NULL,
                          FOREIGN KEY(MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE ON UPDATE CASCADE,
                          FOREIGN KEY(ChatID) REFERENCES Chats(ChatID) ON DELETE CASCADE ON UPDATE CASCADE
);


-- LINKS: store data about image links
DROP TABLE IF EXISTS LINKS;
CREATE TABLE Links (ChatID INT NOT NULL,
                    MessageID INT NOT NULL,
                    Link VARCHAR(255),
                    TimeStamp TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
                    PRIMARY KEY(ChatID, MessageID),
                    FOREIGN KEY(ChatID) REFERENCES Chats(ChatID) ON DELETE CASCADE ON UPDATE CASCADE,
                    FOREIGN KEY(MessageID) REFERENCES Messages(MessageID) ON DELETE CASCADE ON UPDATE CASCADE
);


-- ***************************
-- ***************************
-- Part B
-- ***************************

-- Sample data for Device
INSERT INTO DEVICE VALUES (1, 'IPhone XS');
INSERT INTO DEVICE VALUES (2, 'IPhone X');
INSERT INTO DEVICE VALUES (3, 'IPhone 8');
INSERT INTO DEVICE VALUES (4, 'IPhone 7');
INSERT INTO DEVICE VALUES (5, 'IPhone 6');
INSERT INTO DEVICE VALUES (6, 'Smartwatch');
INSERT INTO DEVICE VALUES (7, 'Smartfridge');
INSERT INTO DEVICE VALUES (8, 'Galaxy S7');
INSERT INTO DEVICE VALUES (9, 'IPad 6');
INSERT INTO DEVICE VALUES (10, 'Galaxy Tab S4');

-- Sample data for Service
INSERT INTO SERVICE VALUES (1, 'Verizon', 300);
INSERT INTO SERVICE VALUES (2, 'T-Mobile', 200);
INSERT INTO SERVICE VALUES (3, 'Sprint', 100);
INSERT INTO SERVICE VALUES (4, 'AT&T', 120);
INSERT INTO SERVICE VALUES (5, 'Cricket', 99);
INSERT INTO SERVICE VALUES (6, 'US Cellular', 100);
INSERT INTO SERVICE VALUES (7, 'MetroPCS', 89);
INSERT INTO SERVICE VALUES (8, 'Airtel', 75);
INSERT INTO SERVICE VALUES (9, 'Vodafone', 60);
INSERT INTO SERVICE VALUES (10, 'Straight Talk', 50);


-- Sample data for personal info
--INSERT INTO PERSONAL_INFO VALUES (1, 'address1', '123-456-7890', 'M', 20, 'American', 'Hi, my name is Andy', 1, 1);
--INSERT INTO PERSONAL_INFO VALUES (2, 'address2', '123-456-7891', 'M', 21, 'Asian', 'Hi, my name is Ben', 2, 2);
--INSERT INTO PERSONAL_INFO VALUES (3, 'address3', '123-456-7892', 'F', 22, 'British', 'Hi, my name is Cindy', 3, 3);
--INSERT INTO PERSONAL_INFO VALUES (4, 'address4', '123-456-7893', 'M', 23, 'White', 'Hi, my name is Daniel', 4, 4);
--INSERT INTO PERSONAL_INFO VALUES (5, 'address5', '123-456-7894', 'M', 24, 'African American', 'Hi, my name is Ethan', 5, 5);
--INSERT INTO PERSONAL_INFO VALUES (6, 'address6', '123-456-7895', 'M', 25, 'American', 'Hi, my name is Frank', 6, 6);
--INSERT INTO PERSONAL_INFO VALUES (7, 'address7', '123-456-7896', 'M', 26, 'African American', 'Hi, my name is Gray', 7, 7);
--INSERT INTO PERSONAL_INFO VALUES (8, 'address8', '123-456-7897', 'M', 27, 'British', 'Hi, my name is Harry', 8, 8);
--INSERT INTO PERSONAL_INFO VALUES (9, 'address9', '123-456-7898', 'M', 28, 'Latin America', 'Hi, my name is Ivan', 9, 9);
--INSERT INTO PERSONAL_INFO VALUES (10, 'address10', '123-456-7899', 'M', 29, 'Mexican', 'Hi, my name is Jason', 10, 10);

--INSERT INTO PERSONAL_INFO VALUES (10, 'address10', '123-456-7899', 'M', 29, 'Mexican', 'Hi, my name is Jason', 10, 10);


-- Sample data for members
--INSERT INTO Members VALUES (1, 'Andy', 'Andreson', 'andy', 'Andy@mail', 'password1', 'salt1', 1, 1);
--INSERT INTO Members VALUES (2, 'Ben', 'Beach', 'ben', 'Ben@mail', 'password2', 'salt2', 1, 2);
--INSERT INTO Members VALUES (3, 'Cindy', 'Cat', 'cindy', 'Cindy@mail', 'password3', 'salt3', 1, 3);
--INSERT INTO Members VALUES (4, 'Daniel', 'Dog', 'daniel', 'Daniel@mail', 'password4', 'salt4', 1, 4);
--INSERT INTO Members VALUES (5, 'Ethan', 'Earth', 'ethan', 'Ethan@mail', 'password5', 'salt5', 0, 5);
--INSERT INTO Members VALUES (6, 'Frank', 'Franklin', 'frank', 'Frank@mail', 'password6', 'salt6', 0, 6);
--INSERT INTO Members VALUES (7, 'Gray', 'Gay', 'gray', 'Gray@mail', 'password7', 'salt7', 1, 7);
--INSERT INTO Members VALUES (8, 'Harry', 'Hot', 'harry', 'Harry@mail', 'password8', 'salt8', 0, 8);
--INSERT INTO Members VALUES (9, 'Ivan', 'Iverson', 'ivan', 'Ivan@mail', 'password9', 'salt9', 1, 9);
--INSERT INTO Members VALUES (10, 'Jason', 'Jordan', 'jason', 'Jason@mail', 'password10', 'salt10', 0, 10);
--INSERT INTO Members VALUES (12, 'Jackson', 'Jordan', 'jackson', 'jackson@mail', 'password12', 'salt10', 0, 1);

\COPY PERSONAL_INFO(InfoID, Zip, PhoneNumber, Gender, Age, ServiceID, DeviceID) FROM 'personal_info.csv' DELIMITER ',' CSV HEADER;
\COPY Members(MemberID, firstname, LastName, Username, Email, Password, SALT, Verification, InfoID) FROM 'member_data.csv' DELIMITER ',' CSV HEADER;
\COPY Chats(ChatID, Name) FROM 'chats_data.csv' DELIMITER ',' CSV HEADER;
\COPY Messages(MessageID, ChatID, Message, MemberID, CreatedAt) FROM 'message_data.csv' DELIMITER ',' CSV HEADER;



-- Sample data for contacts
INSERT INTO CONTACTS VALUES (1, 1, 10, 0);
INSERT INTO CONTACTS VALUES (2, 2, 9, 0);
INSERT INTO CONTACTS VALUES (3, 3, 8, 0);
INSERT INTO CONTACTS VALUES (4, 4, 7, 0);
INSERT INTO CONTACTS VALUES (5, 5, 6, 0);
INSERT INTO CONTACTS VALUES (6, 6, 7, 0);
INSERT INTO CONTACTS VALUES (7, 6, 7, 0);
INSERT INTO CONTACTS VALUES (8, 1, 9, 0);
INSERT INTO CONTACTS VALUES (9, 2, 10, 0);
INSERT INTO CONTACTS VALUES (10, 3, 4, 0);

-- Sample data for chats
--INSERT INTO CHATS VALUES (1, 'SoccerChat');
--INSERT INTO CHATS VALUES (2, 'JavscriptChat');
--INSERT INTO CHATS VALUES (3, 'Chatroom1');
--INSERT INTO CHATS VALUES (4, 'Chatroom2');
--INSERT INTO CHATS VALUES (5, 'Chatroom3');
--INSERT INTO CHATS VALUES (6, 'Chatroom4');
--INSERT INTO CHATS VALUES (7, 'CSChat');
--INSERT INTO CHATS VALUES (8, 'SwiftTalk');
--INSERT INTO CHATS VALUES (9, 'AndysChat');
--INSERT INTO CHATS VALUES (10, 'Chatroom10');

-- Sample data for messages
--INSERT INTO Messages VALUES (1, null, 1, 'For writers, a random sentence can help them get their creative juices flowing. Since the topic of the sentence is completely unkno', 2, '2019-02-19 17:00:00.046072-08');
--INSERT INTO Messages VALUES (2, 2, null, 'alls. By taking the writer away from the subject matter that is causing the bloc', 3);
--INSERT INTO Messages VALUES (3, null, 3, 'It can also be successfully used as a daily exercise to get writers to begin writing. Being shown a random sentence ', 4);
--INSERT INTO Messages VALUES (4, 4, null, 'you are trying to come up with a new concept, a new idea or a new product, a random sentenc', 5);
--INSERT INTO Messages VALUES (5, null, 5, 'ying to incorporate the sentence into your project can help you look at it in different and unexpected w', 6);
--INSERT INTO Messages VALUES (6, 6, null, ' can also be a fun way to surprise others. You might choose to share a random sentence on', 7);
--INSERT INTO Messages VALUES (7, null, 7, 'These are just a few ways that one might use the random sentence generator for their benefit.', 8);
--INSERT INTO Messages VALUES (8, null, 8, 're not sure if it will help in the way you want, the best course of action is to try it and see. ', 9);
--INSERT INTO Messages VALUES (9, 9, null, 'Our goal is to make this tool as useful as possible. For anyone who uses this tool and comes up with a way ', 10);
--INSERT INTO Messages VALUES (10, null, 10, 'Producing random sentences can be helpful in a number of different ways.', 1);
--INSERT INTO Messages VALUES (11, null, 2, 'This is a DM', 1);
--INSERT INTO Messages VALUES (12, null, 4, 'Personal MSG', 1);
--INSERT INTO Messages VALUES (13, null, 4, 'BLKSDF:DJG:DGJKLD', 1);
--INSERT INTO Messages VALUES (14, 3, null, 'alls. By taking the writer away from the subject matter that is causing the bloc', 3);
--INSERT INTO Messages VALUES (15, 4, null, 'ChatMessage', 1);
--INSERT INTO Messages VALUES (16, 4, null, 'ChatMessage', 2);
--INSERT INTO Messages VALUES (17, 4, null, 'ChatMessage', 3);
--INSERT INTO Messages VALUES (18, 4, null, 'ChatMessage', 4);
--INSERT INTO Messages VALUES (19, 4, null, 'ChatMessage', 5);

-- Sample data for chat members
INSERT INTO ChatMembers VALUES (1, 1);
INSERT INTO ChatMembers VALUES (2, 2);
INSERT INTO ChatMembers VALUES (3, 3);
INSERT INTO ChatMembers VALUES (4, 4);
INSERT INTO ChatMembers VALUES (5, 5);
INSERT INTO ChatMembers VALUES (6, 6);
INSERT INTO ChatMembers VALUES (7, 7);
INSERT INTO ChatMembers VALUES (8, 8);
INSERT INTO ChatMembers VALUES (9, 9);
INSERT INTO ChatMembers VALUES (10, 10);


-- Sample data for image links
--INSERT INTO LINKS VALUES (1, 2, 'http://www.example.com/image1');
--INSERT INTO LINKS VALUES (2, 3, 'http://www.example.com/image2');
--INSERT INTO LINKS VALUES (3, 4, 'http://www.example.com/image3');
--INSERT INTO LINKS VALUES (4, 5, 'http://www.example.com/image4');
--INSERT INTO LINKS VALUES (5, 6, 'http://www.example.com/image5');
--INSERT INTO LINKS VALUES (6, 7, 'http://www.example.com/image6');
--INSERT INTO LINKS VALUES (7, 8, 'http://www.example.com/image7');
--INSERT INTO LINKS VALUES (8, 9, 'http://www.example.com/image8');
--INSERT INTO LINKS VALUES (9, 10, 'http://www.example.com/image9');
--INSERT INTO LINKS VALUES (10, 1, 'http://www.example.com/image10');



-- ***************************
-- ***************************
-- Part C
-- ***************************
-- SQL Query 1: 

-- The purpose of this query is to join three tables, Messages, DM, and Member. 
-- To display only the tuples that are DM’s. 
-- The expected results are only those rows that have ChatID as null, a
-- nd DMId exists, meaning that this type of message is a DM, and that it was not sent in a group chat. 

--SELECT  MESSAGES.DMID, ChatID, Message, Messages.MemberID 
--FROM MESSAGES
--inner join DM on DM.DMID = MESSAGES.DMID
--inner join Members m on m.MemberID = MESSAGES.MemberID;

-- ***************************
-- SQL Query 2: 

-- The purpose of this query is to find all the members that have sent messages after 6:00PM 
-- on February 19th. The expected results are just the first and last names of the people 
-- that have sent any kind of message after 6:00PM on Tuesday February 19 2019. Currently, 
-- this is only one person, so only one row is in the result-set.

SELECT FirstName, LastName
FROM Members
WHERE MemberID = ANY (SELECT MemberID FROM Messages 
    WHERE CreatedAt < '2019-02-19 17:00:32.046072-08')
    GROUP BY FirstName, LastName;

-- ***************************

-- SQL Query 3: A correlated nested query

-- b.) The purpose of this query is trying to find all the emails from a certain person’s contact. 
--  It will give the certain person other information to connect to his/her contacts.
-- c.) In this case, the membered = 1, and the result will be Ivan@mail and Jason@mail

SELECT email FROM members 
WHERE memberid= ANY(SELECT memberid_b 
  FROM contacts 
  WHERE memberid_a =1);

-- ***************************

-- SQL Query 4:   

-- The purpose of this query is to gather the personal information of each verified Member 
-- by joining them from the two tables: Member and PERSONAL_INFO. 
-- The expected results are to see the phone number, age, gender and ethnicity of each verified member.

SELECT PhoneNumber, Age, Gender 
FROM PERSONAL_INFO
FULL JOIN Members mem
       ON mem.InfoID = PERSONAL_INFO.InfoID;
-- ***************************

-- SQL Query 5

-- a) This query can be used to search the memberIDs of members who lives in a 
--  certain zip code AND with a certain last name.  Our application might used this to 
--  query to help members look for family members with the same last name who uses our 
--  application in a certain area. 
-- b) The query uses INTERSECT to find memberID attribute that occurs in both locations table with 
--  a certain zip code and the members table with a certain last name. This query in particular 
--  should return memberID 1 since he lives in zip code of 98400 and has a last name of “Anderson”
-- ***************************

--select MemberID
--from Locations
--where ZIP = 98400

--intersect

--select MemberID
--from members
--where LastName = 'Andreson';

-- ***************************

-- SQL Query 6: Create your own non-trivial SQL query

-- a.)  The purpose of this is to find the distribution of the APP users, so we will know 
--  what group of people we should target them, making the adjustments according to the ages.
-- b.)  The result should be Average:24.5, Min: 20, Max: 29

SELECT CAST(AVG(Age) as int)
AS "Average Age",
MAX(Age) AS "Oldest Age",
MIN(Age) AS "Youngest Age"
FROM PERSONAL_INFO;

-- ***************************

-- SQL Query 7: Create your own non-trivial SQL query

-- a.)  The purpose of this is to get all the messages that been sent from certain area zip code.
-- b.)  In this example, zip = 98401, which should return 2 messages.

--SELECT message FROM Messages 
--where memberID = ANY(SELECT MemberID 
--  FROM Locations where zip = 98401);

-- **************************

-- SQL Query 8

-- a) Purpose is the retrieve the number of messages in a particular chat given the chat ID
-- b) Should return the count of all the messages in chat 
--  with a ChatID of 4. The count should be 6 with our given values.

select count(MessageID) as NumberOfMessagesInChat
from Messages
where ChatID = '4';

-- **************************

-- SQL Query 9

-- a) Purpose is to retrieve the number of distinct chats a particular 
--  member is part of given the memberID
-- b) Should return 2 since member with a memberID of 3 is part of 2 chats

select count(distinct ChatID) as NumberOfChatMemberIsPartOf
from messages
where MemberID = 3;

-- **************************

-- SQL Query 10: 

-- The purpose of this query is to count all the messages sent in each chat. 
-- This query is an important analytic. The expected results will be all the the 
-- ChatId’s and the total message count in each chat. 

SELECT ChatID, COUNT(MessageID) as TotalMessages 
from Messages 
where ChatID is not null
  Group By ChatID
  ORDER BY COUNT(MessageID) DESC;

-- End of Script (Feb 19, 2019)
