
-- VIEW
-- thống kê số lượng bài viết theo từng tài khoản
CREATE OR REPLACE VIEW View_ThongKeBaiDang AS
SELECT TaiKhoan.MaTaiKhoan, TaiKhoan.TenTaiKhoan, COUNT(BaiDang.MaBaiDang) AS SoLuongBaiDang
FROM TaiKhoan
LEFT JOIN BaiDang ON TaiKhoan.MaTaiKhoan = BaiDang.MaTaiKhoan
GROUP BY TaiKhoan.MaTaiKhoan, TaiKhoan.TenTaiKhoan
ORDER BY SoLuongBaiDang DESC;
SELECT * FROM View_ThongKeBaiDang
-- Top 10 tài khoản có điểm đóng góp cao nhất
CREATE OR REPLACE VIEW View_Top10TaiKhoan_DiemDongGop AS
SELECT MaTaiKhoan, TenTaiKhoan, Email, DiemDongGop
FROM TaiKhoan
ORDER BY DiemDongGop DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10TaiKhoan_DiemDongGop
-- 10 bài đăng có lượt tương tác cao nhất
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

-- các báo cáo được gửi theo chủ đ�?
CREATE OR REPLACE VIEW View_BaoCao_ByChuDe AS
SELECT ChuDe, COUNT(MaBaoCao) AS SoLuongBaoCao
FROM BaoCao
GROUP BY ChuDe
ORDER BY SoLuongBaoCao DESC;
SELECT * FROM View_BaoCao_ByChuDe

-- các chiến dịch quảng cáo có chi phí cao nhất
CREATE OR REPLACE VIEW View_Top10ChienDich_ByChiPhi AS
SELECT c.MaChienDich, c.TieuDe, SUM(m.ChiPhi) AS TongChiPhi
FROM ChienDich c
JOIN MucTieu m ON c.MaChienDich = m.MaChienDich
GROUP BY c.MaChienDich, c.TieuDe
ORDER BY SUM(m.ChiPhi) DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10ChienDich_ByChiPhi


-- ngư�?i dùng có tổng số ti�?n nạp cao nhất
CREATE OR REPLACE VIEW View_Top10TaiKhoan_ByNapTien AS
SELECT MaTaiKhoan, SUM(SoTien) AS TongTienNap
FROM TaiKhoan_NapTien_TaiKhoan
GROUP BY MaTaiKhoan
ORDER BY TongTienNap DESC
FETCH FIRST 10 ROWS ONLY;
SELECT * FROM View_Top10TaiKhoan_ByNapTien
-- Tài khoản không hoạt động trong 30 ngày
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

SELECT * FROM View_TaiKhoan_Inactive
