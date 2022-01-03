CREATE DATABASE ASM4
GO
USE ASM4
GO
CREATE TABLE LoaiSP(
	MaLoaiSP CHAR(20) PRIMARY KEY,
	TenLoaiSP NVARCHAR(200),
	

)
GO
CREATE TABLE NguoiPhutrach (
	MaNPT INT PRIMARY KEY,
	TenNPT NVARCHAR(200)
)
GO
CREATE TABLE SanPham(
	MaSSP CHAR(20) PRIMARY KEY,
	NgaySX DATE,
	MaLoaiSP CHAR(20) FOREIGN KEY REFERENCES dbo.LoaiSP(MaLoaiSP),
	MaNPT INT FOREIGN KEY REFERENCES dbo.NguoiPhutrach(MaNPT)
)
INSERT INTO dbo.LoaiSP
(
    MaLoaiSP,
    TenLoaiSP
)
VALUES
(   'Z37E',  -- MaLoaiSP - char(20)
    N'Máy tính cầm tay' -- TenLoaiSP - nvarchar(200)
    ),
(   'Z38E',  -- MaLoaiSP - char(20)
    N'Máy tính ko dây ' -- TenLoaiSP - nvarchar(200)
    ),
(   'Z39E',  -- MaLoaiSP - char(20)
    N'Máy Tính có dây ' -- TenLoaiSP - nvarchar(200)
    )
INSERT INTO dbo.NguoiPhutrach
(
    MaNPT,
    TenNPT
)
VALUES
(   1,   -- MaNPT - int
    N'Tạ Duy Linh ' -- TenNPT - nvarchar(200)
    ),
(   2,   -- MaNPT - int
    N'Vú Viết Qúy ' -- TenNPT - nvarchar(200)
    )
INSERT INTO dbo.SanPham
(
    MaSSP,
    NgaySX,
    MaLoaiSP,
    MaNPT
)
VALUES
(   '123',   -- MaSSP - char(20)
    '20220102', -- NgaySX - date
    'Z37E', -- MaLoaiSP - char(20)
    1  -- MaNPT - int
    ),
(   '345',   -- MaSSP - char(20)
    '20211209', -- NgaySX - date
    'Z38E', -- MaLoaiSP - char(20)
    2 -- MaNPT - int
    ),
(   '678',   -- MaSSP - char(20)
    '20211112', -- NgaySX - date
    'Z39E', -- MaLoaiSP - char(20)
    1 -- MaNPT - int
    )
--4a Liệt kê danh sách loại sản phẩm của công ty.
SELECT *FROM dbo.DanhSachSP
--4B Liệt kê danh sách sản phẩm của công ty.
SELECT*FROM dbo.SanPham
--4C Liệt kê danh sách người chịu trách nhiệm của công ty.
SELECT*FROM dbo.NguoiPhutrach
--5a  Liệt kê danh sách loại sản phẩm của công ty theo thứ tự tăng dần của tên
SELECT*FROM dbo.LoaiSP 
ORDER BY TenLoaiSP ASC 
--5b Liệt kê danh sách người chịu trách nhiệm của công ty theo thứ tự tăng dần của tên.
SELECT*FROM dbo.NguoiPhutrach
ORDER BY  TenNPT ASC
--5C Liệt kê các sản phẩm của loại sản phẩm có mã số là Z37E.
SELECT*FROM dbo.LoaiSP 
WHERE MaLoaiSP = 'Z37E'
--5D Liệt kê các sản phẩm Nguyễn Văn An chịu trách nhiệm theo thứ tự giảm đần của mã.
SELECT *FROM dbo.SanPham
WHERE MaNPT = (
	SELECT MaNPT FROM dbo.NguoiPhutrach
	WHERE TenNPT = N'Tạ Duy Linh'
)
--6A Số sản phẩm của từng loại sản phẩm.
SELECT MaLoaiSP,COUNT(MaSSP) AS 'Số Sp' FROM dbo.SanPham
GROUP BY MaLoaiSP
--6c Hiển thị toàn bộ thông tin về sản phẩm và loại sản phẩm.
SELECT *FROM dbo.SanPham
INNER JOIN dbo.LoaiSP
ON LoaiSP.MaLoaiSP = SanPham.MaLoaiSP
--6d Hiển thị toàn bộ thông tin về người chịu trách nhiêm, loại sản phẩm và sản phẩm.
SELECT * FROM dbo.NguoiPhutrach
JOIN dbo.SanPham
ON SanPham.MaNPT = NguoiPhutrach.MaNPT
JOIN dbo.LoaiSP
ON LoaiSP.MaLoaiSP = SanPham.MaLoaiSP

--7A Viết câu lệnh để thay đổi trường ngày sản xuất là trước hoặc bằng ngày hiện tại.
ALTER TABLE dbo.SanPham 
ADD CONSTRAINT
CHECK_Ngay CHECK(NgaySX<= GETDATE())
--7b Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.
--7c Viết câu lệnh để thêm trường phiên bản của sản phẩm.
ALTER TABLE dbo.SanPham
ADD PhienBan INT 