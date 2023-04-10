Create database Festival
go 
use Festival

Create table Speaker
(
	Id int identity primary key,
	FullName nvarchar(20),
)
Create table City
(
	Id int identity primary key,
	Name nvarchar(20),
)
Create table Event
(
	Id int identity primary key,
	Name nvarchar(20),
	StartDate datetime2,
	EndDate datetime2,
	CityId int foreign key references City(Id)
)
Create Table EventSpeaker
(
	EventId int foreign key references Event(Id),
	Speaker int foreign key references Speaker(Id)
)
Alter table event
drop column SpeakerId
Drop table Speaker
Drop table Event
drop table City

insert into Speaker
values
('Amin Israfilzade'),
('ABB'),
('Maki'),
('Elvin'),
('Tural')
Insert into EventSpeaker
values
(1,1),
(1,4),
(2,3),
(3,2),
(3,3),
(3,4),
(4,1),
(4,3)

------------Dorduncu task-------------
Create PROCEDURE USP_InsertCities 
@Name NVARCHAR(30)
AS
INSERT INTO City
VALUES
(@Name)

Exec USP_InsertCities 'Paris'
Exec USP_InsertCities 'Tokyo'
Exec USP_InsertCities 'Afina'
Exec USP_InsertCities 'Baku'
Exec USP_InsertCities 'Washington DC'
---------------------------------------
Select * from City

Insert into Event
Values
('Fanta festival','2023-01-09 14:00','2023-01-10 14:00',2),
('Cola festival','2024-08-15 20:00','2024-08-16 04:00',4),
('Sprite festival','2022-04-05 11:00','2022-04-05 18:00',4),
('Pepsi festival','2023-05-02 23:00','2023-05-03 06:00',1)

---------------------Birinci Task---------------------------------------------

Select *,(Select City.Name from City where City.id=CityId) AS FestivalCity,
(Select Count(Speaker) from EventSpeaker where EventId=Event.Id) as SpeakerCount,
(Select DATEDIFF(MINUTE,StartDate,EndDate)) as DurationofFestival  from Event
-------------------------------------------------------------------------------

--------------------Ikinci task--------------------------------------------------------------------------------------
Create Procedure Usp_GetInfoByDateTime3
@Year nvarchar(15),
@Month Nvarchar(15),
@Day Nvarchar(15)
as
Select * from Event where Year(Event.StartDate)=@Year and month(Event.StartDate)=@Month and day(Event.StartDate)=@Day
exec Usp_GetInfoByDateTime3 2022,04,05
----------------------------------------------------------------------------------------------------------------------
--------------------------------------------------Ucuncu task-------------------------------------------------------
Create view VW_Speakers
as

select *,(Select Count(Speaker) from EventSpeaker where Speaker=Speaker.Id) as EventCountofSpeakers,
(Select SUM(DATEDIFF(MINUTE, Event.StartDate, Event.EndDate)) from Event where EventSpeaker.EventId = Event.Id)
from Speaker as S
---------------------------------------------------------------------------------------------------------------------
-----------------------------------------besinci task----------------------------------------------------------------
SELECT C.Id FROM Event as E
JOIN City as C
ON E.CityId=C.Id 
GROUP BY C.Id
HAVING COUNT(*) > 2

//burda ele bir sey yaratmamisam deye cixmir amma isliyir//

--------------------------------------altinci task---------------------------------------------------------------------
CREATE VIEW VW_LastYearEvents
as
Select *,(Select Count(Speaker) from EventSpeaker where EventId=Event.Id) SpeakerCount,
(Select City.Name from City where City.id=CityId) AS FestivalCity from Event
where Event.StartDate <= DATEADD(year, -1, GETDATE())

