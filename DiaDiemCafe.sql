CREATE DATABASE DiaDiem 
GO
USE DiaDiem
GO
CREATE TABLE City(
	CityID INT PRIMARY KEY,
	CityName NVARCHAR(300)
)
GO
CREATE TABLE District(
	DistrictID INT PRIMARY KEY,
	DistrictName NVARCHAR(400),
	CityID INT FOREIGN KEY REFERENCES dbo.City(CityID)
)
GO
CREATE TABLE Utilities(
	UtilitiesID INT PRIMARY KEY,
	UtilitiesName NVARCHAR(300)
)
GO
CREATE TABLE Store(

	StoreID INT PRIMARY KEY,
	StoreName NVARCHAR(300),
	Address NVARCHAR(300),
	CityID INT FOREIGN KEY REFERENCES dbo.City(CityID),
	DistrictID INT FOREIGN KEY REFERENCES dbo.District(DistrictID),
	Tel INT,
	Dateon DATETIME,
	UtilitiID INT FOREIGN KEY REFERENCES dbo.Utilities(UtilitiesID),
	Pay NVARCHAR(300),
	
)


INSERT INTO dbo.City
(
    CityID,
    CityName
)
VALUES
(   0,   -- CityID - int
    N'Thái Nguyên ' -- CityName - nvarchar(300)
    ),
(   1,   -- CityID - int
    N'Thái Bình ' -- CityName - nvarchar(300)
    ),
(   2,   -- CityID - int
    N'Ninh Bình ' -- CityName - nvarchar(300)
    )
INSERT INTO dbo.District
(
    DistrictID,
    DistrictName,
    CityID
)
VALUES
(   0,    -- DistrictID - int
    N'Đồng Hỷ', -- DistrictName - nvarchar(400)
    0  -- CityID - int
    ),
(   1,    -- DistrictID - int
    N'Thái Thụy', -- DistrictName - nvarchar(400)
    1  -- CityID - int
    ),
(   2,    -- DistrictID - int
    N'Nho Quan', -- DistrictName - nvarchar(400)
    2  -- CityID - int
    )
INSERT INTO dbo.Utilities
(
    UtilitiesID,
    UtilitiesName
)
VALUES
(   0,   -- UtilitiesID - int
    N'Nghe Thổi Kèn ' -- UtilitiesName - nvarchar(300)
    ),
(   1,   -- UtilitiesID - int
    N'Tẩm Quất ' -- UtilitiesName - nvarchar(300)
    ),
(   2,   -- UtilitiesID - int
    N'Masa và Thổi Kèn  ' -- UtilitiesName - nvarchar(300)
    )
INSERT INTO dbo.Store
(
    StoreID,
    StoreName,
    Address,
    DistrictID,
    Tel,
    Dateon,
    UtilitiID,
    Pay
)
VALUES
(   0,    -- StoreID - int
    N'Cafe Thái Nguyên ', -- StoreName - nvarchar(300)
    N'Thái NGuyên,Đồng Hỷ, Đồng Quang ', -- Address - nvarchar(300)
    0, -- DistrictID - int
    NULL, -- Tel - int
    '7:30', -- Dateon - date
    0, -- UtilitiID - int
    N'Thanh Toán Bằng Thẻ '  -- Pay - nvarchar(300)
    ),
(   1,    -- StoreID - int
    N'Cafe Thái Bình ', -- StoreName - nvarchar(300)
    N'Thái Bình , Thái Thụy , TQ', -- Address - nvarchar(300)
    1, -- DistrictID - int
    NULL, -- Tel - int
    '8:30', -- Dateon - date
    1, -- UtilitiID - int
    N'Thanh Toán Bằng Thẻ'  -- Pay - nvarchar(300)
    ),
(   2,    -- StoreID - int
    N'Cafe Ninh Bình', -- StoreName - nvarchar(300)
    N'Ninh Bình, Nho Quan, china', -- Address - nvarchar(300)
    2, -- DistrictID - int
    NULL, -- Tel - int
    '7:35', -- Dateon - date
    2, -- UtilitiID - int
    N'Thanh Toán Bằng Thẻ'  -- Pay - nvarchar(300)
    )
SELECT*FROM dbo.City
SELECT*FROM dbo.District
SELECT*FROM dbo.Utilities
SELECT*FROM dbo.Store


--Truy vấn 
SELECT StoreName FROM dbo.Store
WHERE DistrictID IN(
	SELECT DistrictID FROM dbo.District
    WHERE CityID IN (
	SELECT CityID FROM dbo.City
	WHERE CityName = N'Thái Nguyên'
	)
)
SELECT StoreName FROM dbo.Store
WHERE DistrictID IN(
	SELECT DistrictID FROM dbo.District
    WHERE CityID IN (
	SELECT CityID FROM dbo.City
	WHERE CityName = N'Thái Bình '
	)
)
SELECT StoreName FROM dbo.Store
WHERE DistrictID IN(
	SELECT DistrictID FROM dbo.District
    WHERE CityID IN (
	SELECT CityID FROM dbo.City
	WHERE CityName = N'Ninh Bình'
	)
)
 SELECT StoreName,UtilitiID FROM dbo.Store
 WHERE UtilitiID IN(
	SELECT UtilitiID FROM dbo.Utilities
	WHERE UtilitiesID = 0
 )



