--Procedure to add a new team to the Team table
CREATE PROCEDURE AddTeam(
    @TeamName VARCHAR(100),
    @TeamType VARCHAR(50),
    @DateFormed DATE
)
AS
BEGIN
    INSERT INTO Team (TeamName, TeamType, DateFormed) 
    VALUES (@TeamName, @TeamType, @DateFormed);
END;
GO

--Procedure to add a new person to the Person table
CREATE PROCEDURE AddPerson(
    @SSN INT,
    @Name VARCHAR(100),
    @Gender VARCHAR(10),
    @Profession VARCHAR(100),
    @PhoneNumber BIGINT,
    @EmailAddress VARCHAR(100),
    @MailingAddress VARCHAR(200),
    @IsOnMailingList BIT,
    @EmergencyContactPhoneNumber BIGINT,
    @EmergencyContactName VARCHAR(100),
    @EmergencyContactRelationship VARCHAR(50)
)
AS
BEGIN
    --ERROR HANDLING: Check if the person already exists in the database
    IF NOT EXISTS (SELECT * FROM Person WHERE SSN = @SSN)
    BEGIN
        INSERT INTO Person (SSN, Name, Gender, Profession)
        VALUES (@SSN, @Name, @Gender, @Profession);
        INSERT INTO ContactInfo (SSN, PhoneNumber, EmailAddress, MailingAddress, IsOnMailingList)
        VALUES (@SSN, @PhoneNumber, @EmailAddress, @MailingAddress, @IsOnMailingList);
        INSERT INTO EmergencyContact (SSN, PhoneNumber, Name, Relationship)
        VALUES (@SSN, @EmergencyContactPhoneNumber, @EmergencyContactName, @EmergencyContactRelationship);
    END;
END;
GO

--Procedure to add a new client to the Client table
CREATE PROCEDURE AddClient(
    @SSN INT,
    @DoctorName VARCHAR(100),
    @DoctorPhone INT,
    @DateAssigned DATE
)
AS
BEGIN
    INSERT INTO Client (SSN, DoctorName, DoctorPhoneNumber, DateAssigned)
    VALUES (@SSN, @DoctorName, @DoctorPhone, @DateAssigned);
END;
GO

--Procedure to add a new "cares for" relationship to the CaresFor table
CREATE PROCEDURE AddCaresFor(
    @SSN INT,
    @TeamName VARCHAR(100),
    @ClientIsActive BIT
)
AS
BEGIN
    INSERT INTO CaresFor (SSN, TeamName, ClientIsActive)
    VALUES (@SSN, @TeamName, @ClientIsActive);
END;
GO

--Procedure to add a new client need to the ClientNeed table
CREATE PROCEDURE AddClientNeed(
    @SSN INT,
    @NeedSpecification VARCHAR(200),
    @Importance INT
)
AS
BEGIN
    INSERT INTO ClientNeed (SSN, NeedSpecification, LevelOfImportance)
    VALUES (@SSN, @NeedSpecification, @Importance);
END;
GO

--Procedure to add a new insurance policy to the InsurancePolicy table
CREATE PROCEDURE AddClientInsurance(
    @SSN INT,
    @UniqueID INT,
    @ProviderName VARCHAR(100),
    @ProviderAddress VARCHAR(200),
    @Type VARCHAR(50)
)
AS
BEGIN
    INSERT INTO InsurancePolicy (SSN, UniqueID, ProviderName, ProviderAddress, Type)
    VALUES (@SSN, @UniqueID, @ProviderName, @ProviderAddress, @Type);
END;
GO

--Procedure to add a new volunteer to the Volunteer table
CREATE PROCEDURE AddVolunteer(
    @SSN INT,
    @DateJoined DATE,
    @DateRecentlyTrained DATE,
    @LocationRecentlyTrained VARCHAR(100)
)
AS
BEGIN
    INSERT INTO Volunteer (SSN, DateJoined, DateRecentlyTrained, LocationRecentlyTrained)
    VALUES (@SSN, @DateJoined, @DateRecentlyTrained, @LocationRecentlyTrained);
END;
GO

--Procedure to add a new team assignment to the IsAssignedTo table
CREATE PROCEDURE AddIsAssignedTo(
    @SSN INT,
    @TeamName VARCHAR(100),
    @IsActive BIT,
    @IsLeader BIT
)
AS
BEGIN
    INSERT INTO IsAssignedTo (SSN, TeamName, IsActive, IsLeader)
    VALUES (@SSN, @TeamName, @IsActive, @IsLeader);
    IF @IsLeader = 1
    BEGIN
        INSERT INTO Leads (SSN, TeamName)
        VALUES (@SSN, @TeamName);
    END;
END;
GO

--Procedure to log hours worked by a volunteer in the HoursWorked table
CREATE PROCEDURE LogHours(
    @SSN INT,
    @TeamName VARCHAR(100),
    @Month VARCHAR(20),
    @HoursWorked REAL
)
AS
BEGIN
    INSERT INTO HoursWorked (SSN, TeamName, CurrentMonth, MonthlyHours)
    VALUES (@SSN, @TeamName, @Month, @HoursWorked);
END;
GO

--Procedure to add a new employee to the Employee table
CREATE PROCEDURE AddEmployee(
    @SSN INT,
    @Salary DECIMAL(15, 2),
    @MaritalStatus BIT,
    @DateHired DATE
)
AS
BEGIN
    INSERT INTO Employee (SSN, Salary, MaritalStatus, DateHired)
    VALUES (@SSN, @Salary, @MaritalStatus, @DateHired);
END;
GO

--Procedure to add a new team assignment to the ReportsTo table
CREATE PROCEDURE AddEmployeeTeam(
    @SSN INT,
    @TeamName VARCHAR(100),
    @ReportDescription VARCHAR(200),
    @ReportDate DATE
)
AS
BEGIN
    INSERT INTO ReportsTo (SSN, TeamName, ReportDescription, ReportDate)
    VALUES (@SSN, @TeamName, @ReportDescription, @ReportDate);
END;
GO

--Procedure to add a new expense to the Expense table
CREATE PROCEDURE AddExpense(
    @SSN INT,
    @ExpenseDate DATE,
    @ExpenseDescription VARCHAR(200),
    @ExpenseAmount DECIMAL(15, 2)
)
AS
BEGIN
    INSERT INTO Expense (SSN, ExpenseDate, ExpenseDescription, ExpenseAmount)
    VALUES (@SSN, @ExpenseDate, @ExpenseDescription, @ExpenseAmount);
END;
GO

--Procedure to add a new donor to the Donor table
CREATE PROCEDURE AddDonor(
    @SSN INT,
    @IsAnonymous BIT
)
AS
BEGIN
    INSERT INTO Donor (SSN, IsAnonymous)
    VALUES (@SSN, @IsAnonymous);
END;
GO

--Procedure to add a new donation to the Donation table
CREATE PROCEDURE AddDonation(
    @SSN INT,
    @DonationType VARCHAR(50),
    @CampaignName VARCHAR(100),
    @DonationDate DATE,
    @DonationAmount DECIMAL(15, 2)
)
AS
BEGIN
    INSERT INTO Donation (SSN, DonationType, CampaignName, DonationDate, DonationAmount)
    VALUES (@SSN, @DonationType, @CampaignName, @DonationDate, @DonationAmount);
END;
GO

--Procedure to add a new card payment to the CardPayment table
CREATE PROCEDURE AddCardPayment(
    @SSN INT,
    @DonationType VARCHAR(50),
    @CampaignName VARCHAR(100),
    @DonationDate DATE,
    @CardNumber BIGINT,
    @CardType VARCHAR(50),
    @CardExpDate DATE
)
AS
BEGIN
    INSERT INTO CardPayment (SSN, DonationType, CampaignName, DonationDate, CardNumber, CardType, CardExpDate)
    VALUES (@SSN, @DonationType, @CampaignName, @DonationDate, @CardNumber, @CardType, @CardExpDate);
END;
GO

--Procedure to add a new check payment to the CheckPayment table
CREATE PROCEDURE AddCheckPayment(
    @SSN INT,
    @DonationType VARCHAR(50),
    @CampaignName VARCHAR(100),
    @DonationDate DATE,
    @CheckNumber BIGINT
)
AS
BEGIN
    INSERT INTO CheckPayment (SSN, DonationType, CampaignName, DonationDate, CheckNumber)
    VALUES (@SSN, @DonationType, @CampaignName, @DonationDate, @CheckNumber);
END;
GO

--Procedure to retrieve a doctor's name and phone number from the Client table
CREATE PROCEDURE GetDoctor(
    @SSN INT
)
AS
BEGIN
    SELECT DoctorName, DoctorPhoneNumber
    FROM Client
    WHERE SSN = @SSN;
END;
GO

--Procedure to retrieve an employee's charged expenses from the Expense table
CREATE PROCEDURE GetExpenses(
    @StartDate DATE,
    @EndDate DATE
)
AS
BEGIN
    SELECT SSN, SUM(ExpenseAmount)
    FROM Expense
    WHERE ExpenseDate BETWEEN @StartDate AND @EndDate
    GROUP BY SSN
    ORDER BY SUM(ExpenseAmount) DESC;
END;
GO

--Procedure to retrieve the volunteerd from a team that cares for a specific client
CREATE PROCEDURE RetrieveVolunteers(
    @SSN INT
)
AS
BEGIN
    SELECT Person.Name, Volunteer.DateJoined, Volunteer.DateRecentlyTrained, Volunteer.LocationRecentlyTrained
    FROM Person
    JOIN Volunteer ON Person.SSN = Volunteer.SSN
    JOIN IsAssignedTo ON Person.SSN = IsAssignedTo.SSN
    WHERE IsAssignedTo.TeamName IN (
        SELECT TeamName
        FROM CaresFor
        WHERE SSN = @SSN
    );
END;
GO

--Procedure to retrieve all teams formed after a specific date
CREATE PROCEDURE RetrieveTeams(
    @DateFormed DATE
)
AS
BEGIN
    SELECT TeamName
    FROM Team
    WHERE DateFormed > @DateFormed;
END;
GO

--Procedure to retrieve all client information
CREATE PROCEDURE GetAll
AS
BEGIN
    SELECT Person.SSN, Person.Name, ContactInfo.PhoneNumber, ContactInfo.EmailAddress, ContactInfo.MailingAddress, ContactInfo.IsOnMailingList, EmergencyContact.PhoneNumber, EmergencyContact.Name, EmergencyContact.Relationship
    FROM Person, ContactInfo, EmergencyContact
    WHERE Person.SSN = ContactInfo.SSN AND Person.SSN = EmergencyContact.SSN;
END;
GO

--Procedure to retrieve all donors who are also employees
CREATE PROCEDURE GetDonorEmployees
AS
BEGIN
    SELECT Name, SUM(DonationAmount), IsAnonymous
    FROM Person
    JOIN Donation ON Person.SSN = Donation.SSN
    JOIN Donor ON Person.SSN = Donor.SSN
    GROUP BY Name, IsAnonymous
    ORDER BY SUM(DonationAmount) DESC;
END;
GO

--Procedure to increase the salary of employees who have more than one team reporting to them
CREATE PROCEDURE IncreaseSalary
AS
BEGIN
    UPDATE Employee
    SET Salary = Salary * 1.1
    WHERE SSN IN (SELECT SSN FROM ReportsTo GROUP BY SSN HAVING COUNT(*) > 1);
    SELECT * FROM Employee
    WHERE SSN IN (SELECT SSN FROM ReportsTo GROUP BY SSN HAVING COUNT(*) > 1); 
END;
GO

--Procedure to retrieve all SSNs from the Person table
CREATE PROCEDURE GetAllSSNs
AS
BEGIN
    SELECT SSN
    FROM Person;
END;
GO

--Procedure to delete all poor people who do not have insurance and have a low need for transportation
CREATE PROCEDURE DeletePoorPeople
AS
BEGIN
    DECLARE @SSNsToDelete TABLE (SSN INT);

    INSERT INTO @SSNsToDelete (SSN)
    SELECT Client.SSN
    FROM Client
    JOIN ClientNeed ON Client.SSN = ClientNeed.SSN
    LEFT JOIN InsurancePolicy ON Client.SSN = InsurancePolicy.SSN
    WHERE ClientNeed.NeedSpecification = 'Transportation'
      AND ClientNeed.LevelOfImportance < 5
      AND InsurancePolicy.SSN IS NULL;

    DELETE FROM CaresFor
    WHERE SSN IN (SELECT SSN FROM @SSNsToDelete);

    DELETE FROM ClientNeed
    WHERE SSN IN (SELECT SSN FROM @SSNsToDelete);

    DELETE FROM Client
    WHERE SSN IN (SELECT SSN FROM @SSNsToDelete);

    DELETE FROM EmergencyContact
    WHERE SSN IN (SELECT SSN FROM @SSNsToDelete);

    DELETE FROM ContactInfo
    WHERE SSN IN (SELECT SSN FROM @SSNsToDelete);

    -- Delete from Person table, excluding those who are Employees, Volunteers, or Donors
    DELETE FROM Person
    WHERE SSN IN (SELECT SSN FROM @SSNsToDelete)
      AND SSN NOT IN (SELECT SSN FROM Employee)
      AND SSN NOT IN (SELECT SSN FROM Volunteer)
      AND SSN NOT IN (SELECT SSN FROM Donor);

    SELECT SSN FROM @SSNsToDelete;
END;
GO

--Procedure to export the names and mailing addresses of people on the mailing list
CREATE PROCEDURE Export
AS
BEGIN
    SELECT Name, MailingAddress
    FROM Person
    JOIN ContactInfo ON Person.SSN = ContactInfo.SSN
    WHERE IsOnMailingList = 1;
END;
