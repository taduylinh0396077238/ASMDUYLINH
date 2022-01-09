CREATE DATABASE ASM3
GO
USE ASM3
GO
CREATE TABLE KhachHang(
	MaKH INT PRIMARY KEY,
	TenKH NVARCHAR(200),
	SoCmt CHAR(20) CHECK(ISNUMERIC(SoCmt)=1),
	DiaChi NVARCHAR(200)
)
GO 
CREATE TABLE ThonTin(
	LoaiTB INT PRIMARY KEY,
	TenLoaiTB NVARCHAR(200)

)
GO
CREATE TABLE STB(
	MaTB INT PRIMARY KEY,
	MaKH INT FOREIGN KEY REFERENCES dbo.KhachHang(MaKH),
	LoaiTB INT FOREIGN KEY REFERENCES dbo.ThonTin(LoaiTB),
	SoTB CHAR(10) CHECK(ISNUMERIC(SoTB)=1),
	NgayDK DATE
)
INSERT INTO dbo.KhachHang
(
    MaKH,
    TenKH,
    SoCmt,
    DiaChi
)
VALUES
(   0,    -- MaKH - int
    N'Tạ Duy Linh ', -- TenKH - nvarchar(200)
    '12345690799', -- SoCmt - char(20)
    N'Thái Nguyên '  -- DiaChi - nvarchar(200)
    ),
(   1,    -- MaKH - int
    N'Vú Viết Qúy ', -- TenKH - nvarchar(200)
    '12345690798', -- SoCmt - char(20)
    N'Thái Bình city'  -- DiaChi - nvarchar(200)
    ),
(   2,    -- MaKH - int
    N'Đinh Quang Anh', -- TenKH - nvarchar(200)
    '12345690797', -- SoCmt - char(20)
    N'Ninh Bình '  -- DiaChi - nvarchar(200)
    )
INSERT INTO dbo.ThonTin
(
    LoaiTB,
    TenLoaiTB
)
VALUES
(   01,   -- LoaiTB - int
    N'Trả TRước ' -- TenLoaiTB - nvarchar(200)
    ),
(   02,   -- LoaiTB - int
    N'Trả Sau' -- TenLoaiTB - nvarchar(200)
    )
INSERT INTO dbo.STB
(
    MaTB,
    MaKH,
    LoaiTB,
    SoTB,
    NgayDK
)
VALUES
(   0,    -- MaTB - int
    0, -- MaKH - int
    1, -- LoaiTB - int
    '096669990', -- SoTB - char(10)
    '20220101'  -- NgayDK - date
    ),
(   1,    -- MaTB - int
    1, -- MaKH - int
    2, -- LoaiTB - int
    '095558888', -- SoTB - char(10)
    '20210101'  -- NgayDK - date
    ),
(   2,    -- MaTB - int
    2, -- MaKH - int
    2, -- LoaiTB - int
    '099998888', -- SoTB - char(10)
    '20210101'  -- NgayDK - date
    )
--4a Hiển thị toàn bộ thông tin của các khách hàng của công ty.
SELECT *FROM dbo.KhachHang
--4b Hiển thị toàn bộ thông tin của các số thuê bao của công ty.
SELECT*FROM dbo.STB
--5a Hiển thị toàn bộ thông tin của thuê bao có số: 096669990
SELECT*FROM dbo.STB
WHERE SoTB = '096669990'
--5B Hiển thị thông tin về khách hàng có số CMTND: 12345690799
SELECT*FROM dbo.KhachHang
WHERE SoCmt = '12345690799'
--5C  Hiển thị các số thuê bao của khách hàng có số CMTND:123456789
SELECT *FROM dbo.STB
WHERE SoTB = '096669990'
--5D Liệt kê các thuê bao đăng ký vào ngày 01/01/22
SELECT*FROM dbo.STB
WHERE NgayDK = '20220101'
--5E Liệt kê các thuê bao có địa chỉ tại Thái Nguyên 
SELECT*FROM dbo.KhachHang
WHERE DiaChi = 'Thái Nguyên '
--6a Tổng số khách hàng của công ty.
SELECT COUNT(TenKH) FROM dbo.KhachHang
--6B Tổng số thuê bao của công ty.
SELECT COUNT(SoTB) FROM dbo.STB
--6C Tổng số thuê bào đăng ký ngày 01/01/21
SELECT COUNT(NgayDK) FROM dbo.STB
WHERE NgayDK = '20210101'
--6D Hiển thị toàn bộ thông tin về khách hàng và thuê bao của tất cả các số thuê bao.
SELECT *FROM dbo.KhachHang 
 INNER JOIN dbo.STB 
 ON STB.MaKH = KhachHang.MaKH
 --7a Viết câu lệnh để thay đổi trường ngày đăng ký là not null.
ALTER TABLE dbo.STB
	ALTER COLUMN NgayDK DATE NOT NULL
--7B Viết câu lệnh để thay đổi trường ngày đăng ký là trước hoặc bằng ngày hiện tại.
ALTER TABLE dbo.STB 
	ADD CONSTRAINT
CHECK_Ngay CHECK(NgayDK<= GETDATE())
--7C Viết câu lệnh để thay đổi số điện thoại phải bắt đầu 09
ALTER TABLE dbo.STB 
ADD CHECK(LEFT(SoTB,2)='09')
--7D Viết câu lệnh để thêm trường số điểm thưởng cho mỗi số thuê bao.
--8A Đặt chỉ mục (Index) cho cột Tên khách hàng của bảng chứa thông tin khách hàng
CREATE INDEX TenKhanhIndex ON dbo.KhachHang(TenKH)
--8B Viết Các VIEW 
CREATE VIEW View_KhachHang AS
SELECT MaKH, TenKH, DiaChi FROM dbo.KhachHang

CREATE VIEW View_KhachHang_ThueBao AS
SELECT KhachHang.MaKH, KhachHang.TenKH, STB.SoTB FROM dbo.STB
JOIN dbo.KhachHang
ON KhachHang.MaKH = STB.MaKH
