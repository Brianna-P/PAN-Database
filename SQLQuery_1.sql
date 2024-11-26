-- Person table
CREATE TABLE Person (
    SSN INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Profession VARCHAR(100),
);
CREATE NONCLUSTERED INDEX Person_SSN_Idx ON Person(SSN);

-- Donor table
CREATE TABLE Donor (
    SSN INT PRIMARY KEY,
    IsAnonymous BIT,
    FOREIGN KEY (SSN) REFERENCES Person(SSN)
);
CREATE NONCLUSTERED INDEX Donor_SSN_Idx ON Donor(SSN);

-- Donation table
CREATE TABLE Donation (
    SSN INT,
    DonationType VARCHAR(50),
    CampaignName VARCHAR(100),
    DonationDate DATE,
    DonationAmount DECIMAL(15, 2),
    PRIMARY KEY(SSN, DonationType, CampaignName, DonationDate),
    FOREIGN KEY (SSN) REFERENCES Donor(SSN)
);
CREATE NONCLUSTERED INDEX Donation_SSN_Idx ON Donation(SSN);

-- CardPayment table
CREATE TABLE CardPayment (
    SSN INT,
    DonationType VARCHAR(50),
    CampaignName VARCHAR(100),
    DonationDate DATE,
    CardNumber BIGINT,
    CardType VARCHAR(50),
    CardExpDate DATE,
    PRIMARY KEY(SSN, DonationType, CampaignName, DonationDate, CardNumber),
    FOREIGN KEY (SSN, DonationType, CampaignName, DonationDate) REFERENCES Donation(SSN, DonationType, CampaignName, DonationDate)
 );
 
-- CheckPayment table
CREATE TABLE CheckPayment (
    SSN INT,
    DonationType VARCHAR(50),
    CampaignName VARCHAR(100),
    DonationDate DATE,
    CheckNumber BIGINT,
    PRIMARY KEY(SSN, DonationType, CampaignName, DonationDate, CheckNumber),
    FOREIGN KEY (SSN, DonationType, CampaignName, DonationDate) REFERENCES Donation(SSN, DonationType, CampaignName, DonationDate)
);

-- Employee table
CREATE TABLE Employee (
    SSN INT PRIMARY KEY,
    Salary DECIMAL(15, 2),
    MaritalStatus VARCHAR(20),
    DateHired DATE,
    FOREIGN KEY (SSN) REFERENCES Person(SSN)
);
CREATE CLUSTERED INDEX Employee_SSN_Idx ON Employee(SSN);

-- Expense table
CREATE TABLE Expense (
    SSN INT,
    ExpenseDate DATE,
    ExpenseDescription VARCHAR(200),
    ExpenseAmount DECIMAL(15, 2),
    PRIMARY KEY(SSN, ExpenseDate),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN)
);
CREATE NONCLUSTERED INDEX Expense_SSN_Idx ON Expense(SSN);
CREATE NONCLUSTERED INDEX Expense_ExpenseDate_Idx ON Expense(ExpenseDate);

-- Client table
CREATE TABLE Client (
    SSN INT PRIMARY KEY,
    DoctorName VARCHAR(100),
    DoctorPhoneNumber BIGINT,
    DateAssigned DATE,
    FOREIGN KEY (SSN) REFERENCES Person(SSN)
);
CREATE NONCLUSTERED INDEX Client_SSN_Idx ON Client(SSN);

-- ClientNeed table
CREATE TABLE ClientNeed (
    SSN INT,
    NeedSpecification VARCHAR(200),
    LevelOfImportance INT,
    PRIMARY KEY(SSN, NeedSpecification),
    FOREIGN KEY (SSN) REFERENCES Client(SSN)
);
CREATE NONCLUSTERED INDEX ClientNeed_NeedSpec_Idx ON ClientNeed(NeedSpecification);

-- InsurancePolicy table
CREATE TABLE InsurancePolicy (
    SSN INT,
    UniqueID INT,
    ProviderName VARCHAR(100),
    ProviderAddress VARCHAR(200),
    Type VARCHAR(50),
    PRIMARY KEY(SSN, UniqueID),
    FOREIGN KEY (SSN) REFERENCES Client(SSN)
);
CREATE NONCLUSTERED INDEX InsurancePolicy_SSN_Idx ON InsurancePolicy(SSN);

-- Volunteer table
CREATE TABLE Volunteer (
    SSN INT PRIMARY KEY,
    DateJoined DATE,
    DateRecentlyTrained DATE,
    LocationRecentlyTrained VARCHAR(100),
    FOREIGN KEY (SSN) REFERENCES Person(SSN)
);

-- HoursWorked table
CREATE TABLE HoursWorked (
    SSN INT,
    CurrentMonth VARCHAR(20),
    TeamName VARCHAR(100),
    MonthlyHours REAL,
    PRIMARY KEY(SSN, CurrentMonth, TeamName),
    FOREIGN KEY (SSN) REFERENCES Volunteer(SSN)
);

-- IsAssignedTo table
CREATE TABLE IsAssignedTo (
    SSN INT,
    TeamName VARCHAR(100),
    IsActive BIT,
    IsLeader BIT,
    PRIMARY KEY(SSN, TeamName),
    FOREIGN KEY (SSN) REFERENCES Volunteer(SSN)
);
CREATE NONCLUSTERED INDEX IsAssignedTo_TeamName_Idx ON IsAssignedTo(TeamName);

-- Leads table
CREATE TABLE Leads (
    SSN INT,
    TeamName VARCHAR(100),
    PRIMARY KEY(SSN, TeamName),
    FOREIGN KEY (SSN) REFERENCES Volunteer(SSN)
);

-- Team table
CREATE TABLE Team (
    TeamName VARCHAR(100) PRIMARY KEY,
    TeamType VARCHAR(50),
    DateFormed DATE
    PRIMARY KEY (TeamName)
);
CREATE CLUSTERED INDEX Team_DateFormed_Idx ON Team(DateFormed);

-- ReportsTo table
CREATE TABLE ReportsTo (
    SSN INT,
    TeamName VARCHAR(100),
    ReportDate DATE,
    ReportDescription VARCHAR(200),
    PRIMARY KEY(SSN, TeamName),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN),
    FOREIGN KEY (TeamName) REFERENCES Team(TeamName)
);
CREATE CLUSTERED INDEX ReportsTo_SSN_Idx ON ReportsTo(SSN);

-- CaresFor table
CREATE TABLE CaresFor (
    SSN INT,
    TeamName VARCHAR(100),
    ClientIsActive BIT,
    PRIMARY KEY(SSN, TeamName),
    FOREIGN KEY (SSN) REFERENCES Client(SSN),
    FOREIGN KEY (TeamName) REFERENCES Team(TeamName)
);
CREATE NONCLUSTERED INDEX CaresFor_SSN_Idx ON CaresFor(SSN);

-- ContactInfo table
CREATE TABLE ContactInfo (
    SSN INT PRIMARY KEY,
    PhoneNumber BIGINT,
    EmailAddress VARCHAR(100),
    MailingAddress VARCHAR(200),
    IsOnMailingAddress BIT,
    PRIMARY KEY (SSN, PhoneNumber),
    FOREIGN KEY (SSN) REFERENCES PERSON(SSN)
);
CREATE NONCLUSTERED INDEX ContactInfo_SSN_Idx ON ContactInfo(SSN);

-- EmergencyContact table
CREATE TABLE EmergencyContact (
    SSN INT PRIMARY KEY,
    PhoneNumber BIGINT,
    Name VARCHAR(100),
    Relationship VARCHAR(50),
    PRIMARY KEY (SSN, PhoneNumber),
    FOREIGN KEY (SSN) REFERENCES PERSON(SSN)
);
CREATE NONCLUSTERED INDEX EmergencyContact_SSN_Idx ON EmergencyContact(SSN);
