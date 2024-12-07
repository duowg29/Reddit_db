-- VIEW
--1. Thong ke so luong bai viet theo tung tai khoan
CREATE OR REPLACE VIEW View_ThongKeBaiDang AS
SELECT TaiKhoan.MaTaiKhoan, TaiKhoan.TenTaiKhoan, COUNT(BaiDang.MaBaiDang) AS SoLuongBaiDang
FROM TaiKhoan
LEFT JOIN BaiDang ON TaiKhoan.MaTaiKhoan = BaiDang.MaTaiKhoan
GROUP BY TaiKhoan.MaTaiKhoan, TaiKhoan.TenTaiKhoan
ORDER BY SoLuongBaiDang DESC;
SELECT * FROM View_ThongKeBaiDang
--2. Top 10 tai khoan co diem dong gop cao nhat
CREATE OR REPLACE VIEW View_Top10TaiKhoan_DiemDongGop AS
SELECT MaTaiKhoan, TenTaiKhoan, Email, DiemDongGop
FROM TaiKhoan
ORDER BY DiemDongGop DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10TaiKhoan_DiemDongGop
--3. 10 bai dang co luot tuong tac cao nhat
CREATE OR REPLACE VIEW View_Top10Posts_ByInteractions AS
SELECT b.MaBaiDang, b.TieuDe, TO_CHAR(b.NoiDung) AS NoiDung, b.LuotXem, 
       SUM(CASE WHEN t.Upvote = 1 THEN 1 ELSE 0 END) AS SoUpvote,
       SUM(CASE WHEN t.Downvote = 1 THEN 1 ELSE 0 END) AS SoDownvote
FROM BaiDang b
LEFT JOIN TaiKhoan_TuongTac_BaiDang t ON b.MaBaiDang = t.MaBaiDang
GROUP BY b.MaBaiDang, b.TieuDe, TO_CHAR(b.NoiDung), b.LuotXem
ORDER BY (SUM(CASE WHEN t.Upvote = 1 THEN 1 ELSE 0 END) - 
          SUM(CASE WHEN t.Downvote = 1 THEN 1 ELSE 0 END)) DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10Posts_ByInteractions

--4. cac chien dich quang cao co chi phi cao nhat
CREATE OR REPLACE VIEW View_Top10ChienDich_ByChiPhi AS
SELECT c.MaChienDich, c.TieuDe, SUM(m.ChiPhi) AS TongChiPhi
FROM ChienDich c
JOIN MucTieu m ON c.MaChienDich = m.MaChienDich
GROUP BY c.MaChienDich, c.TieuDe
ORDER BY SUM(m.ChiPhi) DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10ChienDich_ByChiPhi


--5. nguoi dung co tong so tien nap cao nhat
CREATE OR REPLACE VIEW View_Top10TaiKhoan_ByNapTien AS
SELECT MaTaiKhoan, SUM(SoTien) AS TongTienNap
FROM TaiKhoan_NapTien_TaiKhoan
GROUP BY MaTaiKhoan
ORDER BY TongTienNap DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10TaiKhoan_ByNapTien

--6.Tai khoan khong hoat dong trong 30 ngay
CREATE OR REPLACE VIEW View_TaiKhoan_Inactive AS
SELECT tk.MaTaiKhoan, tk.TenTaiKhoan, tk.Email, tk.NgayThamGia
FROM TaiKhoan tk
WHERE NOT EXISTS (
    SELECT 1 
    FROM TaiKhoan_Dang_BaiDang db 
    WHERE db.MaTaiKhoan = tk.MaTaiKhoan 
    AND db.ThoiGianDangBai >= TRUNC(SYSDATE) - 30
)
AND NOT EXISTS (
    SELECT 1 
    FROM TaiKhoan_TuongTac_BaiDang tt 
    WHERE tt.MaTaiKhoan = tk.MaTaiKhoan 
    AND tt.ThoiGianTuongTac >= TRUNC(SYSDATE) - 30
)
AND NOT EXISTS (
    SELECT 1 
    FROM TaiKhoan_ThamGia_HoiNhom th 
    WHERE th.MaTaiKhoan = tk.MaTaiKhoan 
    AND th.MaHoiNhom IS NOT NULL
)
AND NOT EXISTS (
    SELECT 1 
    FROM TaiKhoan_NhanTin_PhongNhanTin tn 
    WHERE tn.MaTaiKhoan = tk.MaTaiKhoan 
    AND tn.ThoiGianNhanTin >= TRUNC(SYSDATE) - 30
);

SELECT * FROM View_TaiKhoan_Inactive;

--7. Cac tai khoan bi khoa bai dang va binh luan nhieu lan
CREATE OR REPLACE VIEW View_TaiKhoan_BiKhoaNhieuLan_Thang AS
SELECT u.MaNguoiDung,
       u.TenNguoiDung,
       COUNT(DISTINCT p.MaBaiDang) AS SoLanKhoaBaiDang,
       COUNT(DISTINCT c.MaBinhLuan) AS SoLanKhoaBinhLuan,
       COUNT(DISTINCT p.MaBaiDang) + COUNT(DISTINCT c.MaBinhLuan) AS TongSoLanKhoa
FROM NguoiDung u
LEFT JOIN BaiDang p ON u.MaNguoiDung = p.MaNguoiDung 
    AND p.TrangThai = 'Locked'
    AND TRUNC(p.NgayTao, 'MM') = TRUNC(SYSDATE, 'MM')  -- Dieu kien loc bai dang trong thang nay
LEFT JOIN BinhLuan c ON u.MaNguoiDung = c.MaNguoiDung 
    AND c.TrangThai = 'Locked'
    AND TRUNC(c.NgayTao, 'MM') = TRUNC(SYSDATE, 'MM')  -- Dieu kien loc binh luan trong thang nay
GROUP BY u.MaNguoiDung, u.TenNguoiDung
HAVING COUNT(DISTINCT p.MaBaiDang) > 10 OR COUNT(DISTINCT c.MaBinhLuan) > 20
ORDER BY TongSoLanKhoa DESC;

