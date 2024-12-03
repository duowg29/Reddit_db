--view User's Account--
CREATE VIEW View_TaiKhoan AS
SELECT MaTaiKhoan, AnhDaiDien, TenTaiKhoan, Email, NgayThamGia, QuocGia, DiemDongGop, Vang, HangTaiKhoan, ChucVu
FROM TaiKhoan;
--view Posts--
CREATE VIEW View_BaiDang AS
SELECT MaBaiDang, MaTaiKhoan, TieuDe, NoiDung, TepDinhKem, The, LuotXem
FROM BaiDang;
--view Community--
CREATE VIEW View_HoiNhom AS
SELECT MaHoiNhom, TenNhom, MoTa, NgayThanhLap
FROM HoiNhom;
--view Chatroom--
CREATE VIEW View_PhongNhanTin AS
SELECT MaPhongNhanTin, TenPhong, ChuDePhong
FROM PhongNhanTin;

--view top 10 Trending Tags--
CREATE VIEW MostUsedTag AS
SELECT TOP 10 The AS Tag, COUNT(*) AS UsageCount
FROM BaiDang
WHERE The IS NOT NULL AND The <> ''
GROUP BY The
ORDER BY COUNT(*) DESC;

--view All Tags--
CREATE VIEW AllTags AS
SELECT DISTINCT The AS Tag
FROM BaiDang
WHERE The IS NOT NULL AND The <> '';

--View top 10 Posts By Views
CREATE VIEW Top10PostsByViews AS
SELECT TOP 10 MaBaiDang, MaTaiKhoan, TieuDe, NoiDung, TepDinhKem, The, LuotXem
FROM BaiDang
ORDER BY LuotXem DESC;

--view top 10 User With Most Donation--
CREATE VIEW Top10UserWithMostDonation AS
SELECT TOP 10 MaTaiKhoan, SUM(SoTien) AS TongTienNap
FROM TaiKhoan_NapTien_TaiKhoan
GROUP BY MaTaiKhoan
ORDER BY TongTienNap DESC;
--------------------------------

-- INDEX
CREATE INDEX IX_TaiKhoan_Email ON TaiKhoan (Email);

CREATE INDEX IX_HoiNhom_NgayThanhLap ON HoiNhom (NgayThanhLap);

CREATE INDEX IX_PhongNhanTin_TenPhong ON PhongNhanTin (TenPhong);

CREATE INDEX IX_BaoCao_ThoiGianBaoCao ON BaoCao (ThoiGianBaoCao);

CREATE INDEX IX_TaiKhoanQuangCao_TenDoanhNghiep ON TaiKhoanQuangCao (TenDoanhNghiep);

CREATE INDEX IX_BaiDang_TieuDe ON BaiDang (TieuDe);

CREATE INDEX IX_HoiNhom_TenNhom ON HoiNhom (TenNhom);

CREATE INDEX IX_MucTieu_TenMucTieu ON MucTieu (TenMucTieu);

CREATE INDEX IX_ChienDich_TieuDe ON ChienDich (TieuDe);

CREATE INDEX IX_TaiKhoan_BinhLuan_BaiDang_ThoiGianBinhLuan ON TaiKhoan_BinhLuan_BaiDang (ThoiGianBinhLuan);

------------------------------
--TRIGGER
--Trigger Increase Contribute Point when User Posting--
CREATE TRIGGER TangDiemDongGop
ON BaiDang
AFTER INSERT
AS
BEGIN
    UPDATE TaiKhoan
    SET DiemDongGop = DiemDongGop + 1
    WHERE MaTaiKhoan IN (SELECT MaTaiKhoan FROM inserted);
END;

-- Trigger Increase Upvote when Users upvote with post
CREATE TRIGGER TangUpvote
ON TaiKhoan_TuongTac_BaiDang
AFTER INSERT
AS
BEGIN
    UPDATE BaiDang
    SET Upvote = Upvote + 1
    WHERE MaBaiDang IN (SELECT MaBaiDang FROM inserted);
END;
GO

-- Trigger Decrease Upvote when Users cancel upvote with post
CREATE TRIGGER GiamUpvote
ON TaiKhoan_TuongTac_BaiDang
AFTER DELETE
AS
BEGIN
    UPDATE BaiDang
    SET Upvote = Upvote - 1
    WHERE MaBaiDang IN (SELECT MaBaiDang FROM deleted);
END;
GO

-- Trigger Increase Downvote when Users downvote with post
CREATE TRIGGER TangDownvote
ON TaiKhoan_TuongTac_BaiDang
AFTER INSERT
AS
BEGIN
    UPDATE BaiDang
    SET Downvote = Downvote + 1
    WHERE MaBaiDang IN (SELECT MaBaiDang FROM inserted);
END;
GO

-- Trigger Decrease Downvote when Users cancel downvote with post
CREATE TRIGGER GiamDownvote
ON TaiKhoan_TuongTac_BaiDang
AFTER DELETE
AS
BEGIN
    UPDATE BaiDang
    SET Downvote = Downvote - 1
    WHERE MaBaiDang IN (SELECT MaBaiDang FROM deleted);
END;
GO

--trigger update user's gold after user's donate
CREATE TRIGGER CapNhatSoVangTaiKhoan
ON TaiKhoan_NapTien_TaiKhoan
AFTER INSERT
AS
BEGIN
    DECLARE @SoVangNhanDuoc INT;
    SELECT @SoVangNhanDuoc = SoVangNhanDuoc
    FROM inserted
    WHERE MaGiaoDich = (SELECT MaGiaoDich FROM inserted);

    UPDATE TaiKhoan
    SET Vang = Vang + @SoVangNhanDuoc
    WHERE MaTaiKhoan IN (SELECT MaTaiKhoan FROM inserted);
END;