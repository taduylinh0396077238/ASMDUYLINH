CREATE DATABASE ASM5
GO 
USE ASM5
GO
CREATE TABLE SĐT(
	TenIDDB INT PRIMARY KEY ,
	Phone CHAR(20)
)

GO 
CREATE TABLE ThongTinkh (
	TenIDDB INT FOREIGN KEY REFERENCES dbo.SĐT(TenIDDB),
	Ten NVARCHAR(200),
	DiaChi NVARCHAR(300),
	NgaySinh DATE
)
INSERT INTO dbo.SĐT
(
    TenIDDB,
    Phone
)
VALUES
(   0,   -- TenIDDB - int
    '0396077238' -- Phone - int
    ),
(   1,   -- TenIDDB - int
    '0987654345' -- Phone - int
    ),
(   2,   -- TenIDDB - int
    '0977603809' -- Phone - int
    )
INSERT INTO dbo.ThongTinkh
(
    TenIDDB,
    Ten,
    DiaChi,
    NgaySinh
)
VALUES
(   0, -- TenIDDB - int
    N'Nguyễn Văn A ', -- Ten - nvarchar(200)
    N'Thái Nguyên ', -- DiaChi - nvarchar(300)
    '20030715'  -- NgaySinh - date
    ),
(   1, -- TenIDDB - int
    N'Nguyễn Văn B ', -- Ten - nvarchar(200)
    N'Thái Bình ', -- DiaChi - nvarchar(300)
    '20030109'  -- NgaySinh - date
    ),
(   2, -- TenIDDB - int
    N'Nguyễn Văn C ', -- Ten - nvarchar(200)
    N'Ninh Bình ', -- DiaChi - nvarchar(300)
    '19990103'  -- NgaySinh - date
    )
--4a Liệt kê danh sách những người trong danh bạ
SELECT*FROM dbo.ThongTinkh
--4b Liệt kê danh sách số điện thoại có trong danh bạ
SELECT* FROM dbo.SĐT
--5a Liệt kê danh sách người trong danh bạ theo thứ thự alphabet.
SELECT* FROM dbo.ThongTinkh
ORDER BY Ten
--5b Liệt kê các số điện thoại của người có thên là Nguyễn Văn A
SELECT * FROM dbo.SĐT
WHERE Phone = '0396077238'
--5c Liệt kê những người có ngày sinh là 15/07/2003
SELECT * FROM dbo.ThongTinkh
WHERE NgaySinh = '20030715'
--6a Tìm số lượng số điện thoại của mỗi người trong danh bạ.
SELECT Ten,COUNT(Phone) AS SDT FROM dbo.SĐT
JOIN dbo.ThongTinkh 
ON ThongTinkh.TenIDDB = SĐT.TenIDDB
GROUP BY Ten 
--6b Tìm tổng số người trong danh bạ sinh vào thang 01
SELECT COUNT(TenIDDB) AS 'Người sinh tháng 1 ' FROM dbo.ThongTinkh
WHERE MONTH(NgaySinh) = 1
--6c Hiển thị toàn bộ thông tin về người, của từng số điện thoại.
SELECT* FROM dbo.SĐT
JOIN dbo.ThongTinkh
ON ThongTinkh.TenIDDB = SĐT.TenIDDB
--6D Hiển thị toàn bộ thông tin về người, của số điện thoại 123456789.
SELECT * FROM dbo.SĐT
JOIN dbo.ThongTinkh 
ON ThongTinkh.TenIDDB = SĐT.TenIDDB
WHERE Phone = '0396077238'
--7A Viết câu lệnh để thay đổi trường ngày sinh là trước ngày hiện tại.
ALTER TABLE dbo.ThongTinkh
ADD CONSTRAINT
CHECK_NGAY CHECK(NgaySinh<= GETDATE())
--7B  Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.
--7c Viết câu lệnh để thêm trường ngày bắt đầu liên lạc.
ALTER TABLE dbo.SĐT
ADD NgayLL DATE 
--8A1 IX_HoTen : đặt chỉ mục cho cột Họ và tên
CREATE INDEX IX_HoTen
ON dbo.ThongTinkh(Ten)
--8A2 IX_SoDienThoai: đặt chỉ mục cho cột Số điện thoại
CREATE INDEX IX_SoDienThoai
ON dbo.SĐT(Phone)
--8B1 View_SoDienThoai: hiển thị các thông tin gồm Họ tên, Số điện thoại
CREATE VIEW View_SoDienThoai
AS
SELECT ThongTinkh.Ten, SĐT.Phone FROM dbo.ThongTinkh
JOIN dbo.SĐT
ON SĐT.TenIDDB = ThongTinkh.TenIDDB
--8B2 View_SinhNhat: Hiển thị những người có sinh nhật trong tháng hiện tại (Họ tên, Ngày sinh, Số điện thoại)
CREATE VIEW View_SinhNhat
AS
SELECT Ten, NgaySinh, Phone FROM dbo.ThongTinkh
JOIN dbo.SĐT
ON SĐT.TenIDDB = ThongTinkh.TenIDDB
WHERE  MONTH(NgaySinh) = MONTH(GETDATE())
GO

--8c1 SP_Them_DanhBa: Thêm một người mới vào danh bạn
CREATE PROCEDURE SP_Them_DanhBa
	@TenIDDB INT,
	@Ten NVARCHAR(200),
	@DiaChi NVARCHAR(300),
	@NgaySinh DATE
AS
BEGIN
INSERT INTO dbo.ThongTinkh
(
    TenIDDB,
    Ten,
    DiaChi,
    NgaySinh
)
VALUES
(   @TenIDDB, -- TenIDDB - int
    @Ten, -- Ten - nvarchar(200)
    @DiaChi, -- DiaChi - nvarchar(300)
    @NgaySinh  -- NgaySinh - date
    )
END
EXEC dbo.SP_Them_DanhBa @TenIDDB = 0,            -- int
                        @Ten = N'Giay',              -- nvarchar(200)
                        @DiaChi = N'Thái Pinh',           -- nvarchar(300)
                        @NgaySinh = '2022-01-11' -- date
GO

--8c2 SP_Tim_DanhBa: Tìm thông tin liên hệ của một người theo tên (gần đúng)
CREATE PROCEDURE SP_Tim_DanhBa
AS
SELECT * FROM dbo.ThongTinkh 
WHERE Ten LIKE '%A%'

