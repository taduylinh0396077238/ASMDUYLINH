CREATE DATABASE ASM6 
GO 
USE ASM6
GO 
CREATE TABLE NXB  (
	MaNhaXB INT PRIMARY KEY,
	NhaXB NVARCHAR(200),
	
)
CREATE TABLE Tgia(
	MaTG INT PRIMARY KEY,
	TenTG NVARCHAR(300),
	
)
CREATE TABLE LoaiSach (
	MaLoai	INT PRIMARY KEY,
	TenLoai NVARCHAR( 100),
	
)
CREATE TABLE Sach (
	MaSach INT PRIMARY KEY,
	TenSach NVARCHAR(200),
	MaNhaXB INT FOREIGN KEY REFERENCES dbo.NXB,
	MaTG INT FOREIGN KEY REFERENCES dbo.Tgia,
	MaLoai INT FOREIGN KEY REFERENCES dbo.LoaiSach,
	NoiDung TEXT,
	NamXB DATE,
	LanDauXB INT,
	DiaChiNXB NVARCHAR(300),
	Gia INT,
	SoLuong INT
)

INSERT INTO dbo.NXB
(
    MaNhaXB,
    NhaXB
)
VALUES
(   0,   -- MaNhaXB - int
    N'Trí Tuệ Do Thái   ' -- NhaXB - nvarchar(200)
    ),
(  1,   -- MaNhaXB - int
    N'Duy Linh    ' -- NhaXB - nvarchar(200)
    )

INSERT INTO dbo.Tgia
(
    MaTG,
    TenTG
)
VALUES
(   0,   -- MaTG - int
    N'Duy Linh ' -- TenTG - nvarchar(300)
    )
INSERT INTO dbo.LoaiSach
(
    MaLoai,
    TenLoai
)
VALUES
(   0,   -- MaLoai - int
    N'Kỹ Năng Sống  ' -- TenLoai - nvarchar(100)
    ),
(   1,   -- MaLoai - int
    N'Nghệ Thuật  ' -- TenLoai - nvarchar(100)
    ),
(   2,   -- MaLoai - int
    N'Tự Truyện  ' -- TenLoai - nvarchar(100)
    ),
(   3,   -- MaLoai - int
    N'Ngoại Ngữ ' -- TenLoai - nvarchar(100)
    )
INSERT INTO dbo.Sach
(
    MaSach,
    TenSach,
    MaNhaXB,
    MaTG,
    MaLoai,
    NoiDung,
    NamXB,
    LanDauXB,
    DiaChiNXB,
    Gia,
    SoLuong
)
VALUES
(   0,    -- MaSach - int
    N'Kim Đồng ', -- TenSach - nvarchar(200)
    0, -- MaNhaXB - int
    0, -- MaTG - int
    0, -- MaLoai - int
    'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốc', -- NoiDung - text
    '2010', -- NamXB - date
    1, -- LanDauXB - int
    N'Thái Nguyên ', -- DiaChiNXB - nvarchar(300)
    99, -- Gia - int
    200 -- SoLuong - int
    ),
(   1,    -- MaSach - int
    N'Linh Đẹp Trai ', -- TenSach - nvarchar(200)
    1, -- MaNhaXB - int
    0, -- MaTG - int
    1, -- MaLoai - int
    'Hay Xuất Sắc ko điểm chê HAY. HẾT ', -- NoiDung - text
    '2022', -- NamXB - date
    2, -- LanDauXB - int
    N'Thái Nguyên CITY ', -- DiaChiNXB - nvarchar(300)
    10, -- Gia - int
    5  -- SoLuong - int
    )
--2 Viết lệnh SQL chèn vào các bảng của CSDL các dữ liệu mẫu
SELECT * FROM dbo.NXB
SELECT * FROM dbo.Tgia
SELECT * FROM dbo.LoaiSach
SELECT * FROM dbo.Sach
--3 Liệt kê các cuốn sách có năm xuất bản từ 2010 đến nay
SELECT * FROM dbo.Sach
WHERE YEAR(NamXB) >= 2010 
--4 Liệt kê 10 cuốn sách có giá bán cao nhất
SELECT TOP 1*FROM dbo.Sach
ORDER BY Gia DESC 
--5 Tìm những cuốn sách có tiêu đề chứa từ “Ngoại Ngữ ”
SELECT * FROM dbo.Sach
WHERE TenSach LIKE N'%Kim Đồng%'
--6 Liệt kê các cuốn sách có tên bắt đầu với chữ “K” theo thứ tự giá giảm dần
SELECT * FROM dbo.Sach 
WHERE TenSach LIKE N'K%'
ORDER BY Gia  DESC
--7 Liệt kê các cuốn sách của nhà xuất bản Trí Tuệ Do Thái 
SELECT * FROM dbo.NXB 
JOIN dbo.Sach
ON Sach.MaNhaXB = NXB.MaNhaXB
WHERE NhaXB = N'Trí Tuệ Do Thái  '
--8 Lấy thông tin chi tiết về nhà xuất bản xuất bản cuốn sách “Trí tuệ Do Thái”
SELECT NXB.MaNhaXB,NhaXB FROM dbo.NXB
JOIN dbo.Sach
ON Sach.MaNhaXB = NXB.MaNhaXB
WHERE TenSach = N'Linh Đẹp Trai '
--9 Hiển thị các thông tin sau về các cuốn sách: Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản,Loại sách
SELECT MaSach,TenSach,NamXB, NhaXB, LoaiSach.TenLoai FROM dbo.NXB
JOIN dbo.Sach
ON Sach.MaNhaXB = NXB.MaNhaXB
JOIN dbo.LoaiSach 
ON LoaiSach.MaLoai = Sach.MaLoai 
--10 Tìm cuốn sách có giá bán đắt nhất
SELECT TOP 1* FROM dbo.Sach 
ORDER BY Gia DESC
--11 Tìm cuốn sách có số lượng lớn nhất trong kho
SELECT TOP 1* FROM dbo.Sach
ORDER BY SoLuong DESC
--12 Tìm các cuốn sách của tác giả “Eran Katz”
SELECT * FROM dbo.Tgia
JOIN dbo.Sach
ON Sach.MaTG = Tgia.MaTG
WHERE TenTG = N'Duy Linh '
--13 Giảm giá bán 10% các cuốn sách xuất bản từ năm 2008 trở về trước
UPDATE dbo.Sach 
SET Gia = Gia*0.9
WHERE YEAR(NamXB) <= 2008
--14 Thống kê số đầu sách của mỗi nhà xuất bản
SELECT NhaXB,COUNT(TenSach) AS 'số lượng ' FROM dbo.NXB
JOIN dbo.Sach
ON Sach.MaNhaXB = NXB.MaNhaXB
GROUP BY NhaXB
--15 Thống kê số đầu sách của mỗi loại sách
SELECT TenLoai, COUNT(TenSach) AS 'SL'  FROM dbo.LoaiSach
JOIN dbo.Sach
ON Sach.MaLoai = LoaiSach.MaLoai
GROUP BY TenLoai
-- 16 Đặt chỉ mục (Index) cho trường tên sách
CREATE INDEX IX_Sach ON dbo.Sach(TenSach)
GO

--17 Viết view lấy thông tin gồm: Mã sách, tên sách, tác giả, nhà xb và giá bán
CREATE VIEW VIEW_thongTin
AS
SELECT MaSach, TenSach, TenTG, NhaXB, Gia FROM dbo.Tgia
JOIN dbo.Sach
ON Sach.MaTG = Tgia.MaTG
JOIN dbo.NXB
ON NXB.MaNhaXB = Sach.MaNhaXB