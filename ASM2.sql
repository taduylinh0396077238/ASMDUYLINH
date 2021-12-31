CREATE DATABASE ASM2
GO
USE ASM2
GO
CREATE TABLE Information(
	BrandID INT PRIMARY KEY,--ID hãng 
	CarrierNumberID INT , --ID SỐ HÃNG 
	Status NVARCHAR(200)

)
GO
CREATE TABLE ProductSP(
	CarrierCode INT PRIMARY KEY ,--Mẫ số hãng 
	BrandName NVARCHAR(100),--TÊN HÃNG 
	Address NVARCHAR(100),-- Địa chỉ 
	Tel INT --SĐT
	
)
GO
CREATE TABLE ListofProducts(
	ProductID INT PRIMARY KEY,--ID SẢN PHẨM 
	Name NVARCHAR(200),--Tên hàng 
	Unit NVARCHAR(100),--Đơn Vị 
	Price MONEY,-- GIÁ
	QuantityAvailable INT 
)
