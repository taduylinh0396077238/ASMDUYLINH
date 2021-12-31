CREATE DATABASE Fromhang 
GO
USE Fromhang
GO
CREATE TABLE Orders(
	OrderID INT PRIMARY KEY , --id đặt hàng 
	CustomerID INT, --id khách hàng 
	Orderdate Date, --ngày đặt hàng 
	STATUS varchar(20)-- trạng thái 
)
GO
CREATE TABLE Customer(
	CustomerId INT PRIMARY KEY, --id khách hàng 
	Name NVARCHAR(30), --Tên khách hàng 
	Address NVARCHAR(20),--Địa chỉ khách hàng 
	Tel INT, -- SĐT khách hàng 
	STATUS nvarchar(20)-- trạng thái 
)
GO
CREATE TABLE Product(
	ProductID INT PRIMARY KEY ,--ID sản phẩm 
	Name NVARCHAR(30),--Tên khách hàng 
	Description VARCHAR(30), -- MÔ tả sản phẩm 
	Unti VARCHAR(10),-- Đơn vị 
	Price MONEY ,--Tiền 
	Qty INT, --Số Lượng 
	Status NVARCHAR(20) --TRạng Thái 
)
GO
CREATE TABLE OrderDetails(
	OrderID INT FOREIGN KEY REFERENCES dbo.Orders(OrderID),--ID đặt hàng 
	ProductID INT FOREIGN KEY REFERENCES dbo.Product(ProductID), -- ID Sản phẩm
	Price money, --Tiền 
	Qty INT -- Số lượng 
)
INSERT INTO dbo.Customer
(
    CustomerId,
    Name,
    Address,
    Tel,
    STATUS
)
VALUES
(   0,    -- CustomerId - int
    'Tạ Duy Linh ', -- Name - nvarchar(30)
    'Đồng Hỷ- Thái Nguyên ', -- Address - nvarchar(20)
     0396077238, -- Tel - int
     'Không Đổi ' -- STATUS - nvarchar(20)
    ),
	(   1,    -- CustomerId - int
    'Vũ Viết Qúy ', -- Name - nvarchar(30)
    'Thái Bình  ', -- Address - nvarchar(20)
     0396077238, -- Tel - int
     'Không Đổi ' -- STATUS - nvarchar(20)
    ),
	(   2,    -- CustomerId - int
    'Đinh Quang Anh ', -- Name - nvarchar(30)
    'Ninh Bình ', -- Address - nvarchar(20)
     0396077238, -- Tel - int
     'Không Đổi ' -- STATUS - nvarchar(20)
    )

INSERT INTO dbo.Product
(
    ProductID,
    Name,
    Description,
    Unti,
    Price,
    Qty,
    Status
)
VALUES
(   0,    -- ProductID - int
    'LILOVO 2021', -- Name - nvarchar(30)
    'New ', -- Description - varchar(30)
    'Chiếc ', -- Unti - varchar(10)
    2500000, -- Price - money
    6, -- Qty - int
    'Sẵn TRong Kho '  -- Status - nvarchar(20)
    ),
(   1,    -- ProductID - int
    'IPhone 13prm', -- Name - nvarchar(30)
    'New ', -- Description - varchar(30)
    'Chiếc ', -- Unti - varchar(10)
    3500000, -- Price - money
    5, -- Qty - int
    'Sẵn TRong Kho '  -- Status - nvarchar(20)
    ),
(   2,    -- ProductID - int
    'IPhone 20prm', -- Name - nvarchar(30)
    'New ', -- Description - varchar(30)
    'Chiếc ', -- Unti - varchar(10)
    5500000, -- Price - money
    300, -- Qty - int
    'Sẵn TRong Kho '  -- Status - nvarchar(20)
    )
INSERT INTO dbo.Orders
(
    OrderID,
    CustomerID,
    Orderdate,
    STATUS
)
VALUES
(   0,    -- OrderID - int
    0, -- CustomerID - int
    GETDATE(), -- Orderdate - date
    'Đang Giao Hàng '  -- STATUS - varchar(20)
    )
INSERT INTO dbo.OrderDetails
(
    OrderID,
    ProductID,
    Price,
    Qty
)
VALUES
(   0, -- OrderID - int
    0, -- ProductID - int
    2500000, -- Price - money
    1  -- Qty - int
    ),
(   0, -- OrderID - int
    1, -- ProductID - int
    3500000, -- Price - money
    2  -- Qty - int
    )
--4.Viết các câu lênh truy vấn để
--4a.Liệt kê danh sách khách hàng đã mua hàng ở cửa hàng.
SELECT*FROM dbo.Customer WHERE CustomerId IN(
		SELECT CustomerId FROM dbo.Orders
)
--4b.Liệt kê danh sách sản phẩm của của hàng
SELECT*FROM dbo.Product
--4c.Liệt kê danh sách các đơn đặt hàng của cửa hàng.
SELECT*FROM dbo.Orders 
--5a.Liệt kê danh sách khách hàng theo thứ thự alphabet.
	SELECT Name FROM  dbo.Customer ORDER BY Name 
--5b.Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá giảm dần.
SELECT Name,Price FROM dbo.Product ORDER BY Price DESC
--5c.Liệt kê các sản phẩm mà khách hàng Tạ Duy Linh  đã mua.
SELECT NAME FROM dbo.Product  WHERE ProductID IN(
	SELECT ProductID FROM dbo.OrderDetails WHERE OrderID IN(
		SELECT OrderID FROM dbo.Orders WHERE CustomerID = 0
	)
)
--6a.Số khách hàng đã mua ở cửa hàng.
SELECT COUNT( DISTINCT CustomerID) FROM dbo.Orders 
--6b.Số mặt hàng mà cửa hàng bán.
SELECT COUNT(ProductID) FROM dbo.Product
--6c.Tổng tiền của từng đơn hàng.
SELECT OrderID,SUM(Price * Qty) 'Tổng' FROM OrderDetails 
	GROUP BY OrderID
--7a.Viết câu lệnh để thay đổi trường giá tiền của từng mặt hàng là dương(>0).
ALTER TABLE dbo.Product ADD CONSTRAINT CK_Price CHECK(Price>0)
--7b.Viết câu lệnh để thay đổi ngày đặt hàng của khách hàng phải nhỏ hơn ngày hiện tại.
ALTER TABLE dbo.Orders ADD CONSTRAINT CK_Date CHECK(Orderdate<GETDATE())
--7c.Viết câu lệnh để thêm trường ngày xuất hiện trên thị trường của sản phẩm.
ALTER TABLE dbo.Orders ADD PublicDate DATE
