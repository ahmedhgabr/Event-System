CREATE Database Milestone2
	
GO

CREATE PROC createAllTables 
AS

CREATE TABLE SystemUser(
username Varchar(20) PRIMARY KEY ,
Password Varchar(20)
);


CREATE TABLE Stadium(  -- edit the order
ID int PRIMARY KEY IDENTITY,
Name Varchar(20) UNIQUE,
Location Varchar(20),
Capacity int,
Status bit  --  0 means unavailable and 1 means available
);


CREATE TABLE StadiumManager( -- change the order
ID int PRIMARY KEY IDENTITY,
Name Varchar(20),
Stadium_ID int FOREIGN KEY REFERENCES Stadium(ID) ON UPDATE CASCADE ON DELETE CASCADE , -- staduim id  instead of Manager_ID
username Varchar(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(username) 
);

CREATE TABLE Club(  
club_ID int PRIMARY KEY IDENTITY,  -- club_id instead of id
Name Varchar(20)  UNIQUE,
Location Varchar(20)
);

CREATE TABLE ClubRepresentative( -- change the order
ID int PRIMARY KEY IDENTITY,
Name Varchar(20),
Club_ID int FOREIGN KEY REFERENCES Club(club_ID) ON UPDATE CASCADE ON DELETE CASCADE,
username Varchar(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(username) 

);

CREATE TABLE Match( -- change the order
match_ID int PRIMARY KEY IDENTITY, -- match_id instead of id
Start_Time datetime, -- start_time instead of startTime
end_time datetime ,										 -- new att
Host_Club_ID int FOREIGN KEY REFERENCES Club(club_ID) , 
Guest_Club_ID int FOREIGN KEY REFERENCES Club(club_ID) , 
Stadium_ID int FOREIGN KEY REFERENCES Stadium(ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE HostRequest( -- change the order
ID int PRIMARY KEY IDENTITY,
representative_ID int FOREIGN KEY REFERENCES ClubRepresentative(ID) , 
Manager_ID int FOREIGN KEY REFERENCES StadiumManager(ID) ,
Match_ID INT  FOREIGN KEY REFERENCES Match(match_ID) ON UPDATE CASCADE ON DELETE CASCADE ,
Status varchar(20)
);

CREATE TABLE Fan( --change the order
National_ID Varchar(20) PRIMARY KEY, 
Name Varchar(20),
Birth_Date datetime, 
Address Varchar(20),
Phone_No Varchar(20), 
Status bit,			--For fans, 0 means blocked and 1 means unblocked.
username Varchar(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(username) ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE Ticket( -- delete attrib
ID int PRIMARY KEY IDENTITY,
Status bit, -- For tickets, 0 means sold and 1 means available
Match_ID int FOREIGN KEY REFERENCES Match(match_ID) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE TicketBuyingTransactions( -- new table
fan_national_ID VARCHAR(20) FOREIGN KEY REFERENCES Fan(National_ID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
ticket_ID int FOREIGN KEY REFERENCES Ticket(ID) NOT NULL
);


CREATE TABLE SystemAdmin(
ID int PRIMARY KEY IDENTITY, 
Name Varchar(20),
username Varchar(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(username) ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE SportsAssociationManager(
ID int PRIMARY KEY IDENTITY,
Name Varchar(20),
username Varchar(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(username) ON UPDATE CASCADE ON DELETE CASCADE 
);
GO

CREATE PROC dropAllTables

AS

DROP TABLE SportsAssociationManager

DROP TABLE SystemAdmin

DROP TABLE TicketBuyingTransactions

DROP TABLE Ticket

DROP TABLE Fan

DROP TABLE HostRequest

DROP TABLE Match

DROP TABLE ClubRepresentative

DROP TABLE Club

DROP TABLE StadiumManager

DROP TABLE Stadium

DROP TABLE SystemUser
GO

CREATE PROC dropAllProceduresFunctionsViews

AS

DROP PROCEDURE createAllTables

DROP PROCEDURE dropAllTables

DROP PROCEDURE clearAllTables

DROP VIEW allAssocManagers

DROP VIEW allClubRepresentatives

DROP VIEW allStadiumManagers

DROP VIEW allFans

DROP VIEW allMatches

DROP VIEW allTickets

DROP VIEW allCLubs

DROP VIEW allStadiums

DROP VIEW allRequests

DROP PROCEDURE addAssociationManager

DROP PROCEDURE addNewMatch

DROP VIEW clubsWithNoMatches

DROP PROCEDURE deleteMatch

DROP PROCEDURE deleteMatchesOnStadium

DROP PROCEDURE addClub

DROP PROCEDURE addTicket

DROP PROCEDURE deleteClub

DROP PROCEDURE addStadium

DROP PROCEDURE deleteStadium

DROP PROCEDURE blockFan

DROP PROCEDURE unblockFan

DROP PROCEDURE addRepresentative

DROP FUNCTION viewAvailableStadiumsOn

DROP PROCEDURE addHostRequest

DROP FUNCTION allUnassignedMatches

DROP PROCEDURE addStadiumManager

DROP FUNCTION allPendingRequests

DROP PROCEDURE acceptRequest

DROP PROCEDURE rejectRequest

DROP PROCEDURE addFan

DROP FUNCTION upcomingMatchesOfClub

DROP FUNCTION availableMatchesToAttend

DROP PROCEDURE purchaseTicket

DROP PROCEDURE updateMatchHost

DROP PROCEDURE deleteMatchesOnStadium

DROP VIEW matchesPerTeam

DROP VIEW clubsNeverMatched

DROP FUNCTION clubsNeverPlayed

DROP FUNCTION matchWithHighestAttendance

DROP FUNCTION matchesRankedByAttendance

DROP FUNCTION requestsFromClub
GO

CREATE PROC clearAllTables

AS

DELETE from  SportsAssociationManager;

delete from SystemAdmin;

delete from TicketBuyingTransactions;

delete from Ticket;

delete from Fan;

delete from HostRequest;

delete from Match;

delete from ClubRepresentative;

delete from Club;

delete from StadiumManager;

delete from Stadium;

delete from SystemUser;

GO




--Hadary el brns



create View  [allAssocManagers] As
select s.username , su.password , s.Name 
from SportsAssociationManager s , SystemUser su
where   s.username = su.username


go

create view  allClubRepresentatives as
select   cr.username ,su.password , cr.Name  AS ClubRepresentatives, c.Name AS Clubs
from Club c ,ClubRepresentative cr ,  SystemUser su
where c.club_ID =cr.Club_ID and   cr.username = su.username



go

create view  allStadiumManagers as
select sm.username ,su.password,sm.name AS StadiumManagers ,s.name AS Stadiums
from Stadium s,StadiumManager sm , SystemUser su
where s.id=sm.Stadium_ID and sm.username = su.username

go

create view allFans as
Select  su.username ,su.password , f.Name, f.National_ID, f.Birth_Date , f.Status
from fan f , SystemUser su
where f.username = su.username


go

create view allMatches as
select c1.name as HostClub ,c2.name as GuestClub , m.Start_Time 
from (((Club c1 inner join Match m on c1.club_ID=m.Host_Club_ID) inner join Club c2 on c2.club_ID=m.Guest_Club_ID) )


go


create view allTickets as  
select c1.name as HostClub , c2.name  as GuestClub ,s.name , m.Start_Time
from Match m inner join  Ticket t on m.match_ID =t.Match_ID inner join Club c1 on c1.club_ID = m.Host_Club_ID 
	inner join Club c2 on c2.club_ID =m.Guest_Club_ID  inner join Stadium s on s.id = m.Stadium_ID


go

create view allCLubs as
select name , Location
from Club


go

create view allStadiums as 
select name , location , capacity ,status  
from Stadium

go


create view  allRequests as
select cr.username as ClubRepresentative  , sm.username as StadiumManager ,hr.status
from (( ClubRepresentative cr inner join HostRequest hr on hr.representative_ID=cr.id )
inner join StadiumManager sm on hr.Manager_ID=sm.id) , SystemUser  as su1 , SystemUser as su2
where sm.username = su1.username and   cr.username = su2.username 

go


--mohsen 

--i
CREATE PROC addAssociationManager
	@AssociationManager varchar(20),
	@username varchar(20),
	@password varchar(20)
AS
	INSERT INTO SystemUser(username,Password)
	VALUES(@username,@password);
	INSERT INTO SportsAssociationManager(Name,username)
	VALUES(@AssociationManager,@username);
GO

--ii
CREATE PROC addNewMatch
	@hostclub varchar(20),
	@guestclub varchar(20),
	@starttime datetime,
	@endtime datetime
AS 

	DECLARE @hostclubid int
	SELECT @hostclubid = club_ID
	FROM Club
	WHERE @hostclub = name

	DECLARE @guestclubid int
	SELECT @guestclubid = club_ID
	FROM Club
	WHERE @guestclub = name

	INSERT INTO Match (Guest_Club_ID,Host_Club_ID,Start_Time,end_time,Stadium_ID)
	VALUES(@guestclubid,@hostclubid,@starttime,@endtime,NULL); 
GO

--iii
CREATE VIEW clubsWithNoMatches AS
	SELECT c.name 
	FROM Club c
	WHERE c.name NOT IN (SELECT c1.Name
						 FROM Club c1, Match m
						 WHERE c1.club_ID = m.Host_Club_ID OR c1.club_ID = m.Guest_Club_ID);
GO


--iv
CREATE PROC deleteMatch
	@hostclub varchar(20),
	@guestclub varchar(20)
AS
	DECLARE @hostclubid int
	SELECT @hostclubid = club_ID
	FROM Club
	WHERE @hostclub = name

	DECLARE @guestclubid int
	SELECT @guestclubid = club_ID
	FROM Club
	WHERE @guestclub = name

	DELETE FROM Match
	WHERE Host_Club_ID = @hostclubid AND Guest_Club_ID = @guestclubid
GO

--v
CREATE PROC deleteMatchesOnStadium 
	@stadium VARCHAR(20)
AS 
	DELEtE FROM Match 
	WHERE Stadium_ID = (SELECT ID FROM Stadium WHERE @stadium = name) AND GETDATE() < Start_Time;
GO

--vi
CREATE PROC addClub
	@club VARCHAR(20),
	@clublocation VARCHAR(20)
AS
	INSERT INTO Club (Name,Location)
	Values(@club,@clublocation)
Go



--vii
CREATE PROC addTicket
	@hostclub varchar(20),
	@guestclub varchar(20),
	@starttime datetime
AS	
	DECLARE @hostclubid int
	SELECT @hostclubid = club_ID
	FROM Club
	WHERE @hostclub = name

	DECLARE @guestclubid int
	SELECT @guestclubid = club_ID
	FROM Club
	WHERE @guestclub = name

	DECLARE @matchid int
	SELECT @matchid = match_ID 
	FROM Match 
	WHERE Host_Club_ID = @hostclubid AND Guest_Club_ID = @guestclubid AND Start_Time = @starttime

	INSERT INTO Ticket(Match_ID ,Status )
	VALUES(@matchid , 1)
GO


--viii
CREATE PROC deleteClub 
	@club VARCHAR(20)
AS
	DELETE FROM clubsWithNoMatches
	WHERE name = @club
GO

--ix
CREATE PROC addStadium
	@stadium VARCHAR(20),
	@location VARCHAR(20),
	@capacity int
AS
	INSERT INTO Stadium(Capacity,Name,Location, Status)
	VALUES(@capacity,@stadium,@location , '1')
GO

--x
CREATE PROC deleteStadium -- if statues = 1 ???
	@stadium VARCHAR(20)
AS	
	--DECLARE @stadiumID INT
	--SELECT @stadiumID = ID
	--FROM Stadium
	--WHERE NAME = @stadium
	
	DELETE FROM Stadium
	WHERE name = @stadium
	



	--UPDATE MATCH
	--SET Stadium_ID = NULL
	--WHERE @staddiumID = Stadium_ID

	--UPDATE StadiumManager
	--SET Stadium_ID = NULL
	--WHERE @staddiumID = Stadium_ID
	
GO


--lujina 


CREATE PROC blockFan
@NationalID Varchar(20)
AS
Update Fan
set Status = 0 -- 0 Blocked
Where National_ID=@NationalID;


GO

CREATE PROC unblockFan
@NationalID Varchar(20)
AS
Update Fan
set Status = 1 -- 1 Unblocked
Where National_ID=@NationalID;

GO

CREATE PROC addRepresentative
@Name Varchar(20),
@ClubName Varchar(20),
@username Varchar(20),
@password Varchar(20)

AS

DECLARE @temp Varchar(20)

Select @temp=Club.club_ID
FROM Club
Where Name=@ClubName


INSERT INTO SystemUser VALUES (@username,@password);
INSERT INTO ClubRepresentative (Name,username,Club_ID) VALUES (@Name , @username , @temp);



GO

CREATE FUNCTION [viewAvailableStadiumsOn](@date datetime)
Returns Table

AS 

RETURN
Select Stadium.Name , Stadium.Capacity , Stadium.Location
From Stadium
INNER JOIN Match
ON Stadium.ID = Match.Stadium_ID
Where Stadium.status=1 AND Match.Start_Time<>@date ;

GO


CREATE PROC addHostRequest 
@ClubName Varchar(20),
@StadiumName Varchar(20),
@StartTime Datetime

AS
Declare @CR int
Declare @SM int
Declare @MatchID int 

Select @CR =  ClubRepresentative.ID
From ClubRepresentative inner join  Club on club.club_ID = ClubRepresentative.Club_ID 
Where Club.name = @ClubName;

Select  @MatchID = Match.match_ID
From match  
INNER JOIN Club  ON  match.Host_Club_ID = club.club_ID
Where Match.Start_Time = @StartTime AND club.Name = @ClubName   ;

Select @SM = StadiumManager.ID
From StadiumManager inner join  Stadium  on Stadium.ID = StadiumManager.Stadium_ID
Where Stadium.Name = @StadiumName;

Insert Into HostRequest (Match_ID , Status , Manager_ID , representative_ID ) Values (@MatchID , 'unhandled',@SM , @CR)
GO


CREATE FUNCTION [allUnassignedMatches] (@HostClub Varchar(20))
Returns Table
AS
Return 
Select guestClub.Name , Match.Start_Time 
From Match 
INNER JOIN Club hostClub ON hostClub.club_ID = Match.Host_Club_ID inner join Club guestClub ON guestClub.club_ID = Match.Guest_Club_ID
Where Match.Stadium_ID is null and hostClub.Name = @HostClub ;
GO


CREATE PROC addStadiumManager


@Name Varchar(20),
@StadiumName Varchar(20),
@username Varchar(20),
@password Varchar(20)

AS

DECLARE @temp Varchar(20)

Select @temp=ID
FROM Stadium
Where Name=@StadiumName


INSERT INTO SystemUser VALUES (@username,@password);
INSERT INTO StadiumManager(Name,username,Stadium_ID ) VALUES (@Name , @username , @temp);
GO


CREATE FUNCTION [allPendingRequests] (@SM Varchar(20))
Returns Table
AS
Return
Select ClubRepresentative.Name AS ClubRepresentativeName , Guest.Name AS GuestClubName , Match.Start_Time
From Stadium
Inner Join StadiumManager ON Stadium.ID = StadiumManager.Stadium_ID
Inner Join HostRequest ON StadiumManager.ID = HostRequest.Manager_ID
Inner Join Match ON Match.match_ID = HostRequest.Match_ID
Inner Join Club Host ON Host.club_ID=Match.Host_Club_ID
Inner Join Club Guest ON Guest.club_ID=Match.Guest_Club_ID
Inner Join ClubRepresentative ON HostRequest.representative_ID=ClubRepresentative.ID
Where StadiumManager.username = @SM AND HostRequest.Status = 'Unhandled';
GO

CREATE PROC acceptRequest
@StadiumManagerUserName Varchar(20),
@HostName Varchar(20),
@GuestName Varchar(20),
@time datetime
AS
Declare @temp int
Declare @Host int
Declare @Guest int
Declare @ID int
declare @cap int 
declare @matchId int 

Select @Host = club_ID
From Club
Where @HostName=Name

Select @Guest = club_ID
From Club
Where @GuestName=Name

Select @temp = HostRequest.ID , @ID=StadiumManager.Stadium_ID
From HostRequest
Inner Join StadiumManager ON StadiumManager.ID = HostRequest.Manager_ID
Right Outer Join Match ON Match.match_ID = HostRequest.Match_ID
Where Match.Guest_Club_ID = @Guest AND Match.Host_Club_ID = @Host AND Match.Start_Time=@time AND StadiumManager.username=@StadiumManagerUserName

select @cap = Capacity 
from Stadium
where Stadium.ID = @ID

select @matchId = match_ID 
from match
where Host_Club_ID= @Host and Guest_Club_ID= @Guest and Start_Time = @time

DECLARE @i INT = 0;
 
WHILE @i < @cap
	BEGIN
		Exec addTicket @HostName, @GuestName, @time
		SET @i = @i + 1;
	END;

Update HostRequest 
Set Status = 'accepted'
Where ID = @temp

Update Match 
Set Match.Stadium_ID=@ID
Where  Match.Guest_Club_ID=@Guest AND Match.Host_Club_ID=@Host AND Match.Start_Time=@time
GO

CREATE PROC rejectRequest
@StadiumManagerName Varchar(20),
@HostName Varchar(20),
@GuestName Varchar(20),
@time datetime
AS
Declare @temp int
Declare @Host int
Declare @Guest int

Select @Host = club_ID
From Club
Where @HostName=Name

Select @Guest = club_ID
From Club
Where @GuestName=Name


Select @temp = HostRequest.ID
From HostRequest
Inner Join StadiumManager ON StadiumManager.ID = HostRequest.Manager_ID 
Inner Join Match ON Match.Guest_Club_ID = @Guest AND Match.Host_Club_ID = @Host AND Match.Start_Time=@time  -- Match.Stadium_ID = StadiumManager.Stadium_ID 
Where  StadiumManager.username=@StadiumManagerName

Update HostRequest 
Set Status = 'rejected'
Where ID = @temp
GO



CREATE PROC addFan


@Name Varchar(20),
@Username Varchar(20),
@password Varchar(20),
@NationalID Varchar(20),
@Address Varchar(20),
@Phone Varchar(20),
@BirthDate datetime

AS
INSERT INTO SystemUser VALUES (@Username, @password);
INSERT INTO Fan (Name, National_ID , Address , Phone_No , Birth_Date ,Status , username) VALUES (@Name , @NationalID , @Address , @Phone , @BirthDate ,'1' , @Username);
GO



-- Hussein 

--xxii
CREATE FUNCTION [upcomingMatchesOfClub]
(@C VARCHAR(20))
RETURNS TABLE 
AS  
RETURN
SELECT C1.Name AS given_club , C2.Name AS competing_club , M.Start_Time , S.Name AS staduim
FROM Club C1 INNER JOIN Match M ON (C1.club_ID = M.Guest_Club_ID OR C1.club_ID = M.Host_Club_ID) 
INNER JOIN  Club C2 ON  C2.club_ID <>C1.club_ID AND (C2.club_ID = M.Host_Club_ID OR C2.club_ID = M.Guest_Club_ID) , Stadium S
WHERE C1.Name = @C AND CURRENT_TIMESTAMP < M.Start_Time  AND  S.ID = M.match_ID
GO



--xxiii 
CREATE FUNCTION [availableMatchesToAttend]
(@D datetime)
RETURNS TABLE 
AS  
RETURN
SELECT  distinct C1.Name AS HostClubName , C2.Name AS GuestClubName , M.Start_Time , Stadium.Name  
FROM Match M 
INNER JOIN Club C1 ON M.Host_Club_ID=C1.club_ID
INNER JOIN Club C2 ON M.Guest_Club_ID=C2.club_ID
INNER JOIN Stadium ON M.Stadium_ID=Stadium.ID ,Ticket T  
WHERE M.Start_Time > @D AND T.Match_ID = M.match_ID and T.Status = 1 

GO

--proc to find match id by host , guest , and date USED IN purchaseTicket
--CREATE PROC findMatch
--@hClubName VARCHAR(20),
--@guestClubName VARCHAR(20),
--@date datetime,
--@M int  OUTPUT
--AS 
--SELECT @M =M.match_ID
--FROM Match M INNER JOIN  Club C1 ON M.Host_Club_ID =C1.club_ID INNER JOIN Club C2 ON M.Guest_Club_ID = C2.club_ID
--WHERE  C1.Name = @hClubName AND C2.Name = @guestClubName AND M.Start_Time = @date 

 GO


--xxiv
CREATE PROC purchaseTicket
@n_id Varchar(20),
@hClubName VARCHAR(20),
@guestClubName VARCHAR(20),
@date datetime
AS
DECLARE @m_id int 
DECLARE @Ticket int

Select  TOP 1 @Ticket= Ticket.ID ,@m_id= Match.match_ID
From Ticket
INNER JOIN Match ON Match.match_ID=Ticket.Match_ID
INNER JOIN Club C1 ON MAtch.Host_Club_ID = C1.club_ID
INNER JOIN Club C2 ON MAtch.Guest_Club_ID = C2.club_ID
Where C1.Name=@hClubName AND C2.Name=@guestClubName AND Match.Start_Time=@date AND Ticket.Status=1

if (@Ticket is not null)
begin
	INSERT INTO TicketBuyingTransactions (fan_national_ID , ticket_ID  ) VALUES (@n_id , @Ticket )
	end
UPDATE Ticket 
SET Status = 0
WHERE Ticket.ID=@Ticket



GO


--proc to find club id by club name  USED IN purchaseTicket
--CREATE PROC findClub
--@clubName VARCHAR(20),
--@cid int OUTPUT
--AS 
--SELECT @cid = C.club_ID
--FROM  Club C 
--WHERE  C.Name = @clubName 




--xxv
CREATE PROC updateMatchHost
@hClubName VARCHAR(20),
@guestClubName VARCHAR(20),
@date datetime
AS
DECLARE @m_id int 

SELECT @m_id =M.match_ID
FROM Match M INNER JOIN  Club C1 ON M.Host_Club_ID =C1.club_ID INNER JOIN Club C2 ON M.Guest_Club_ID = C2.club_ID
WHERE  C1.Name = @hClubName AND C2.Name = @guestClubName AND M.Start_Time = @date 

DECLARE @ch_id int 
SELECT @ch_id = C.club_ID
FROM  Club C 
WHERE  C.Name =@hClubName 

DECLARE @cg_id int 
SELECT @cg_id = C.club_ID
FROM  Club C 
WHERE  C.Name = @guestClubName

UPDATE Match  
SET Host_Club_ID = @cg_id
WHERE match_ID= @m_id 
UPDATE Match 
SET Guest_Club_ID = @ch_id
WHERE match_ID= @m_id 
GO


--xxvi
CREATE VIEW matchesPerTeam AS
SELECT  C.Name , COUNT(M.match_ID) AS Match_NO
FROM Club C INNER JOIN Match M ON (C.club_ID = M.Host_Club_ID OR C.club_ID = M.Guest_Club_ID)
WHERE  CURRENT_TIMESTAMP > M.Start_Time
GROUP BY C.club_ID , C.Name
GO




--xxviii

CREATE VIEW clubsNeverMatched AS
select  C1.Name AS CLUB1 , C2.Name AS CLUB2 
from club c1 INNER JOIN club c2 ON c1.club_ID > c2.club_ID 
EXCEPT(SELECT c3.name, c4.name 
				 FROm Match INNER JOIN CLUB c3 ON Host_Club_ID = c3.club_ID INNER JOIN Club c4 ON Guest_Club_ID = c4.club_ID
				 )
EXCEPT (SELECT c5.name, c6.name 
		FROm Match INNER JOIN CLUB c5 ON Guest_Club_ID = c5.club_ID INNER JOIN Club c6 ON Host_Club_ID = c6.club_ID
		)

--Not Exists (select  C3.Name AS CLUB1 , C4.Name AS CLUB2
--From Match 
--Inner Join Club C3 On C3.club_ID= Match.Host_Club_ID
--Inner Join Club C4 ON C4.club_ID= Match.Guest_Club_ID
--Where (C3.club_ID=Match.Guest_Club_ID AND C4.club_ID=Match.Host_Club_ID) OR (C4.club_ID=Match.Guest_Club_ID AND C3.club_ID=Match.Host_Club_ID) )



GO

--xxix
CREATE FUNCTION [clubsNeverPlayed]
(@clubName VARCHAR(20))
RETURNS TABLE 
AS  
RETURN
select  C1.Name AS CLUB1 , C2.Name AS CLUB2 
from club c1 INNER JOIN club c2 ON c1.club_ID <> c2.club_ID 
WHERE c1.name = @clubName
EXCEPT(SELECT c3.name, c4.name 
				 FROm Match INNER JOIN CLUB c3 ON Host_Club_ID = c3.club_ID INNER JOIN Club c4 ON Guest_Club_ID = c4.club_ID
				 )
EXCEPT (SELECT c5.name, c6.name 
		FROm Match INNER JOIN CLUB c5 ON Guest_Club_ID = c5.club_ID INNER JOIN Club c6 ON Host_Club_ID = c6.club_ID
		)



GO


--xxx
CREATE FUNCTION [matchWithHighestAttendance]()
RETURNS TABLE 
AS  
RETURN
SELECT TOP 1 C1.Name AS HostClubName,  C2.Name AS GuestClubName 
FROM Match
INNER JOIN Ticket ON Ticket.Match_ID = Match.Match_ID
INNER JOIN Club C1 ON C1.club_ID = Match.Host_Club_ID
INNER JOIN Club C2 ON C2.club_ID = Match.Guest_Club_ID
WHERE Ticket.Status=0
GROUP BY C1.Name , C2.Name, match.Match_ID 
ORDER BY COUNT (Ticket.ID)  DESC


GO

--xxxi
CREATE FUNCTION [matchesRankedByAttendance]()
RETURNS TABLE 
AS  
RETURN
SELECT TOP 100   C1.Name AS HostClubName,  C2.Name AS GuestClubName 
FROM Match
INNER JOIN Ticket ON Ticket.Match_ID = Match.Match_ID
INNER JOIN Club C1 ON C1.club_ID = Match.Host_Club_ID
INNER JOIN Club C2 ON C2.club_ID = Match.Guest_Club_ID
WHERE Ticket.Status=0
GROUP BY C1.Name , C2.Name, match.Match_ID 
ORDER BY COUNT (Ticket.ID)  DESC

GO





--proc to find Staduim id by Staduim name and Staduim id  USED IN purchaseTicket

--CREATE PROC findStaduim
--@staduimName VARCHAR(20),
--@sid int OUTPUT
--AS 
--SELECT @sid = S.ID
--FROM  Stadium S 
--WHERE  S.Name = @staduimName 



--xxvi
--CREATE PROC deleteMatchesOnStadium
--@staduimName VARCHAR(20)
--AS 
--DECLARE @s_id int 
--EXEC findStaduim @staduimName ,@s_id OUTPUT
--DELETE FROM Match WHERE Stadium_ID = @s_id AND CURRENT_TIMESTAMP < Match.StartTime

GO


--xxxii
CREATE FUNCTION [requestsFromClub]
(@staduimName VARCHAR(20),@clubName VARCHAR(20))
RETURNS TABLE 
AS  
RETURN
SELECT  C1.Name AS HostClub , C2.Name AS GuestClub
FROM Stadium S INNER JOIN StadiumManager SM ON S.ID = SM.Stadium_ID  
	INNER JOIN HostRequest R ON  SM.ID = R.Manager_ID 
	INNER JOIN ClubRepresentative CR ON R.representative_ID = CR.ID 
	INNER JOIN Match M ON M.match_ID = R.Match_ID 
	INNER JOIN Club C ON C.club_ID =CR.Club_ID 
	, Club C1  , Club C2  
WHERE M.Host_Club_ID = C1.club_ID AND M.Guest_Club_ID = C2.club_ID AND S.Name = @staduimName AND C.Name = @clubName

GO
