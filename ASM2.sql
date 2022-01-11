CREATE DATABASE Asm2
GO
USE Asm2
GO 
CREATE TABLE SpHang(
	MaHang INT NOT NULL  PRIMARY KEY,
	TenHang NVARCHAR(200),
	DiaChi NVARCHAR(200),
	Phone  CHAR(20) CHECK(ISNUMERIC(Phone)=1)
)
GO
CREATE TABLE MaLoaiSP(
	MaLoai NVARCHAR(200)  PRIMARY KEY,
	LoaiSP NVARCHAR(100) 
)
GO
CREATE TABLE DanhSachSP(
	MaSP NVARCHAR(100) PRIMARY KEY,
	TenSP NVARCHAR(300),
	MaHang INT FOREIGN KEY REFERENCES dbo.SpHang(MaHang),
	MoTa NVARCHAR(100),
	DonVi NVARCHAR(200),
	Gia INT,
	SoLuong INT,
	MaLoai NVARCHAR(200) FOREIGN KEY REFERENCES dbo.MaLoaiSP(MaLoai)
)


INSERT INTO dbo.SpHang
(
    MaHang,
    TenHang,
    DiaChi,
    Phone
)
VALUES
(   123,    -- MaHang - int
    N'LapTop', -- TenHang - nvarchar(200)
    N'USA ', -- DiaChi - nvarchar(200)
    '0983232'  -- Phone - int
    ),
(   234,    -- MaHang - int
    N'APPLE', -- TenHang - nvarchar(200)
    N'USA ', -- DiaChi - nvarchar(200)
    '0983233'  -- Phone - int
    ),
(   456,    -- MaHang - int
    N'SAMSUNG', -- TenHang - nvarchar(200)
    N'USA ', -- DiaChi - nvarchar(200)
    '0983234'  -- Phone - int
    )


INSERT INTO dbo.MaLoaiSP
(
    MaLoai,
    LoaiSP
)
VALUES
(   'X01', -- MaLoai - nvarchar(200)
    N'APPle'  -- LoaiSP - nvarchar(100)
    ),
(   'X02', -- MaLoai - nvarchar(200)
    N'Điện THoại '  -- LoaiSP - nvarchar(100)
    ),
(   'X03', -- MaLoai - nvarchar(200)
    N'LapTop'  -- LoaiSP - nvarchar(100)
    )
INSERT INTO dbo.DanhSachSP
(
    MaSP,
    TenSP,
    MaHang,
    MoTa,
    DonVi,
    Gia,
    SoLuong,
	MaLoai
)
VALUES
(   N'01',  -- MaSP - nvarchar(100)
    N'APPLE', -- TenSP - nvarchar(300)
    123, -- MaHang - int
    N'NEW', -- MoTa - nvarchar(100)
    N'CHIẾC ', -- DonVi - nvarchar(200)
    1000, -- Gia - int
    10, -- SoLuong - int
	'X01'  -- MaLoai -
    ),
	(   N'02',  -- MaSP - nvarchar(100)
    N'SAMSUNG', -- TenSP - nvarchar(300)
    234, -- MaHang - int
    N'NEW', -- MoTa - nvarchar(100)
    N'CHIẾC ', -- DonVi - nvarchar(200)
    200, -- Gia - int
    200, -- SoLuong - int
	'X02'  -- MaLoai -
    ),
	(   N'03',  -- MaSP - nvarchar(100)
    N'LAPTOP', -- TenSP - nvarchar(300)
    456, -- MaHang - int
    N'NEW', -- MoTa - nvarchar(100)
    N'CHIẾC ', -- DonVi - nvarchar(200)
    10, -- Gia - int
    100, -- SoLuong - int
	'X03'  -- MaLoai -
    )

SELECT*FROM dbo.SpHang
SELECT*FROM dbo.DanhSachSP
SELECT *FROM dbo.MaLoaiSP
--Truy Vẫn Đề
--4A Hiển Thị Các hãng sản xuất 
SELECT*FROM dbo.SpHang
--4B Hiển Thị Tất Cả Các SP
SELECT * FROM dbo.DanhSachSP
--5A Liệt kê danh sách hãng theo thứ thự ngược với alphabet của tên.
SELECT*FROM dbo.SpHang ORDER BY TenHang 
--5B Liệt kê danh sách sản phẩm của cửa hàng theo thứ thự giá giảm dần.
SELECT*FROM dbo.DanhSachSP ORDER BY Gia DESC
--5c Hiển thị thông tin của hãng Asus.
SELECT*FROM dbo.SpHang 
WHERE TenHang LIKE 'APPLE%'
--5D Liệt kê danh sách sản phẩm còn ít hơn 11 chiếc trong kho
SELECT *FROM dbo.DanhSachSP
WHERE SoLuong < 11
--5e Liệt kê danh sách sản phẩm của hãng Asus
SELECT*FROM dbo.DanhSachSP
WHERE TenSP LIKE 'APPLE%'
--6A Số hãng sản phẩm mà cửa hàng có.
SELECT COUNT(MaHang) AS'SoHang'  FROM dbo.SpHang

--6b Số mặt hàng mà cửa hàng bán.
SELECT COUNT(MaSP) FROM dbo.DanhSachSP
--6c Tổng số loại sản phẩm của mỗi hãng có trong cửa hàng.
SELECT MaLoai,COUNT(MaSP) AS'Tổng' FROM dbo.DanhSachSP
GROUP BY MaLoai
--6d Tổng số đầu sản phẩm của toàn cửa hàng
SELECT SUM(SoLuong) FROM dbo.DanhSachSP
--7a Viết câu lệnh để thay đổi trường giá tiền của từng mặt hàng là dương(>0).
ALTER TABLE dbo.DanhSachSP
	ADD CONSTRAINT
CHECK_GIA CHECK(Gia>0)
--7B Viết câu lệnh để thay đổi số điện thoại phải bắt đầu bằng 0.
ALTER TABLE dbo.SpHang
	ADD CHECK(LEFT(Phone,1)='0')
--7c Viết các câu lệnh để xác định các khóa ngoại và khóa chính của các bảng.
--8a  Thiết lập chỉ mục (Index) cho các cột sau: Tên hàng và Mô tả hàng để tăng hiệu suất truy vấn dữ liệu từ 2 cột này
CREATE INDEX IX_TenHang ON dbo.SpHang(TenHang)
CREATE INDEX IX_MoTa ON dbo.DanhSachSP(MoTa)
--8b Viết Các VIEW
CREATE VIEW View_SanPham 
SELECT MaSP, TenSP, Gia FROM dbo.DanhSachSP

SELECT * FROM View_SanPham_Hang 

CREATE VIEW View_SanPham_Hang AS
SELECT DanhSachSP.MaSP, DanhSachSP.TenSP, SpHang.TenHang FROM dbo.DanhSachSP
JOIN dbo.SpHang
ON SpHang.MaHang = DanhSachSP.MaHang
--8c1 SP_SanPham_TenHang: Liệt kê các sản phẩm với tên hãng truyền vào store
GO
CREATE PROCEDURE SP_SanPham_TenHang
	@TenHang NVARCHAR(200)
	
AS
SELECT TenSP FROM dbo.DanhSachSP
JOIN dbo.SpHang
ON SpHang.MaHang = DanhSachSP.MaHang
WHERE TenHang = @TenHang
--8c2  SP_SanPham_Gia: Liệt kê các sản phẩm có giá bán lớn hơn hoặc bằng giá bán truyền vào
GO
CREATE PROCEDURE SP_SanPham_Gia
	@Gia MONEY
AS
SELECT * FROM dbo.DanhSachSP
WHERE Gia >= @Gia
--8c3 SP_SanPham_HetHang: Liệt kê các sản phẩm đã hết hàng (số lượng = 0)
GO
CREATE PROCEDURE SP_SanPham_HetHang
AS 
SELECT * FROM dbo.DanhSachSP
WHERE SoLuong = 0
