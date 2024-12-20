-- VIEW
--1. Thong ke so luong bai viet theo tung tai khoan
CREATE OR REPLACE VIEW View_ThongKeBaiDang AS
SELECT TaiKhoan.MaTaiKhoan, TaiKhoan.TenTaiKhoan, COUNT(BaiDang.MaBaiDang) AS SoLuongBaiDang
FROM TaiKhoan
LEFT JOIN BaiDang ON TaiKhoan.MaTaiKhoan = BaiDang.MaTaiKhoan
GROUP BY TaiKhoan.MaTaiKhoan, TaiKhoan.TenTaiKhoan
ORDER BY SoLuongBaiDang DESC;
SELECT * FROM View_ThongKeBaiDang;
--2. Top 10 tai khoan co diem dong gop cao nhat
CREATE OR REPLACE VIEW View_Top10TaiKhoan_DiemDongGop AS
SELECT MaTaiKhoan, TenTaiKhoan, Email, DiemDongGop
FROM TaiKhoan
ORDER BY DiemDongGop DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10TaiKhoan_DiemDongGop;
--3. 10 bai dang co luot tuong tac cao nhat
CREATE OR REPLACE VIEW View_Top10Posts_ByInteractions AS
SELECT 
    b.MaBaiDang, 
    b.TieuDe, 
    TO_CHAR(b.NoiDung) AS NoiDung, 
    b.LuotXem, 
    COALESCE(SUM(t.Upvote), 0) AS SoUpvote,
    COALESCE(SUM(t.Downvote), 0) AS SoDownvote
FROM 
    BaiDang b
LEFT JOIN 
    TaiKhoan_TuongTac_BaiDang t 
ON 
    b.MaBaiDang = t.MaBaiDang
GROUP BY 
    b.MaBaiDang, 
    b.TieuDe, 
    TO_CHAR(b.NoiDung), 
    b.LuotXem
ORDER BY 
    (COALESCE(SUM(t.Upvote), 0) - COALESCE(SUM(t.Downvote), 0)) DESC
FETCH FIRST 10 ROWS ONLY;

SELECT * FROM View_Top10Posts_ByInteractions;

--4. cac chien dich quang cao co chi phi cao nhat
CREATE OR REPLACE VIEW View_Top10ChienDich_ByChiPhi AS
SELECT c.MaChienDich, c.TieuDe, SUM(m.ChiPhi) AS TongChiPhi
FROM ChienDich c
JOIN MucTieu m ON c.MaChienDich = m.MaChienDich
GROUP BY c.MaChienDich, c.TieuDe
ORDER BY SUM(m.ChiPhi) DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10ChienDich_ByChiPhi;


--5. nguoi dung co tong so tien nap cao nhat
CREATE OR REPLACE VIEW View_Top10TaiKhoan_ByNapTien AS
SELECT MaTaiKhoan, SUM(SoTien) AS TongTienNap
FROM TaiKhoan_NapTien_TaiKhoan
GROUP BY MaTaiKhoan
ORDER BY TongTienNap DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10TaiKhoan_ByNapTien;

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
SELECT 
    t.MaTaiKhoan,
    t.TenTaiKhoan,
    COUNT(DISTINCT b.MaBaiDang) AS SoLanKhoaBaiDang,
    COUNT(DISTINCT c.ThoiGianBinhLuan) AS SoLanKhoaBinhLuan,
    COUNT(DISTINCT b.MaBaiDang) + COUNT(DISTINCT c.ThoiGianBinhLuan) AS TongSoLanKhoa
FROM 
    TaiKhoan t
LEFT JOIN TaiKhoan_Dang_BaiDang d
    ON t.MaTaiKhoan = d.MaTaiKhoan
    AND EXTRACT(MONTH FROM d.ThoiGianDangBai) = EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM d.ThoiGianDangBai) = EXTRACT(YEAR FROM SYSDATE)
LEFT JOIN BaiDang b
    ON d.MaBaiDang = b.MaBaiDang
    AND b.TrangThai = 'Locked'
    AND b.MaTaiKhoan != t.MaTaiKhoan  
LEFT JOIN TaiKhoan_BinhLuan_BaiDang c
    ON t.MaTaiKhoan = c.MaTaiKhoan
    AND c.TrangThai = 'Locked'
    AND EXTRACT(MONTH FROM c.ThoiGianBinhLuan) = EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM c.ThoiGianBinhLuan) = EXTRACT(YEAR FROM SYSDATE)
    AND c.MaTaiKhoan != t.MaTaiKhoan
GROUP BY 
    t.MaTaiKhoan, t.TenTaiKhoan
HAVING 
    COUNT(DISTINCT b.MaBaiDang) > 10 OR COUNT(DISTINCT c.ThoiGianBinhLuan) > 20
ORDER BY 
    TongSoLanKhoa DESC;
    
SELECT * FROM VIEW_TAIKHOAN_BIKHOANHIEULAN_THANG;
