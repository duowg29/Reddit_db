--1. Top 5 tài khoản có tổng số điểm đóng góp cao nhất

SELECT 
    TenTaiKhoan,
    DiemDongGop
FROM 
    TaiKhoan
ORDER BY 
    DiemDongGop DESC
FETCH FIRST 5 ROWS ONLY;



--2. Danh sách các bài đăng có số lượt xem lớn hơn 1000000
SELECT 
    MaBaiDang,
    TieuDe,
    NoiDung,
    LuotXem
FROM 
    BaiDang
WHERE 
    LuotXem > 1000000
ORDER BY 
    LuotXem DESC;



--3. Danh sách bài đăng chứa các từ khóa cụ thể trong tiêu đ�? (ví dụ: 'database', 'reddit')
SELECT 
    MaBaiDang,
    TieuDe,
    NoiDung
FROM 
    BaiDang
WHERE 
    LOWER(TieuDe) LIKE '%database%' 
    OR LOWER(TieuDe) LIKE '%reddit%';

--
----4. Danh sách các hội nhóm có số lượng bài đăng trên 100
--SELECT 
--    h.MaHoiNhom,
--    h.TenHoiNhom,
--    COUNT(b.MaBaiDang) AS SoLuongBaiDang
--FROM 
--    HoiNhom h
--JOIN 
--    BaiDang b ON h.MaHoiNhom = b.MaHoiNhom
--GROUP BY 
--    h.MaHoiNhom, h.TenHoiNhom
--HAVING 
--    COUNT(b.MaBaiDang) > 100
--ORDER BY 
--    SoLuongBaiDang DESC;



----5. Danh sách các hội nhóm có tên chứa từ khóa "Database"
--SELECT 
--    MaHoiNhom,
--    TenNhom,
--    MoTa
--FROM 
--    HoiNhom
--WHERE 
--    LOWER(TenNhom) LIKE '%database%';



--6. Danh sách 5 tài khoản có bài đăng nhi�?u nhất và số lượng bài của h�?

SELECT 
    t.TenTaiKhoan,
    COUNT(b.MaBaiDang) AS SoLuongBaiDang
FROM 
    TaiKhoan t
JOIN 
    BaiDang b ON t.MaTaiKhoan = b.MaTaiKhoan
GROUP BY 
    t.TenTaiKhoan
ORDER BY 
    SoLuongBaiDang DESC
FETCH FIRST 5 ROWS ONLY;


--7. Tìm top 10 bài đăng có nhi�?u lượt upvote nhất
SELECT 
    MaBaiDang,
    Upvote
FROM 
    TaiKhoan_TuongTac_BaiDang
ORDER BY 
    Upvote DESC
FETCH FIRST 10 ROWS ONLY;



--8. Tim tat ca cac bai dang trong mot khoang thoi gian nhat dinh

SELECT 
    MaBaiDang,
    ThoiGianDangBai
FROM 
    TaiKhoan_Dang_BaiDang
WHERE 
    ThoiGianDangBai BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
                        AND TO_DATE('2024-12-31', 'YYYY-MM-DD');


--9. thống kê các tài khoản thuộc quốc gia Việt Nam
SELECT 
    MaTaiKhoan,
    TenTaiKhoan,
    QuocGia
FROM 
    TaiKhoan
WHERE 
    LOWER(QuocGia) = 'Viet Nam';


--10. thống kê 10 bài đăng có lượt upvote cao nhất:

SELECT 
    b.MaBaiDang,
    b.TieuDe,
    SUM(tt.Upvote) AS TongUpvote
FROM 
    TaiKhoan_TuongTac_BaiDang tt
JOIN 
    BaiDang b ON tt.MaBaiDang = b.MaBaiDang
GROUP BY 
    b.MaBaiDang, b.TieuDe
ORDER BY 
    TongUpvote DESC
FETCH FIRST 10 ROWS ONLY;
