-- Hợp nhất Trigger cho bảng BaiDang và BinhLuan để cập nhật thống kê
CREATE OR REPLACE TRIGGER trg_update_stats
AFTER INSERT ON BaiDang OR BinhLuan
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        IF :NEW IS NOT NULL THEN
            -- Phân biệt loại cập nhật
            IF INSERTING ON BaiDang THEN
                UPDATE ThongKe
                SET SoBaiViet = SoBaiViet + 1
                WHERE IdThongKe = 1; -- Giả sử IdThongKe = 1 là ID thống kê chung
            ELSIF INSERTING ON BinhLuan THEN
                UPDATE ThongKe
                SET SoBinhLuan = SoBinhLuan + 1
                WHERE IdThongKe = 1;
            END IF;
        END IF;
    END IF;
END;
/

-- Tạo Trigger phát hiện nội dung nhạy cảm hoặc không phù hợp
CREATE OR REPLACE TRIGGER trg_detect_sensitive_content
AFTER INSERT OR UPDATE ON BaiDang
FOR EACH ROW
DECLARE
    -- Danh sách từ khóa nhạy cảm
    v_sensitive_keywords VARCHAR2(4000) := 'xúc phạm|bạo lực|nsfw';
BEGIN
    -- Kiểm tra từ khóa nhạy cảm trong nội dung bài viết
    IF REGEXP_LIKE(:NEW.NoiDung, v_sensitive_keywords, 'i') THEN
        UPDATE BaiDang
        SET Tag = '[Trigger Warning]',
            ViPham = 1
        WHERE MaBaiDang = :NEW.MaBaiDang;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Log lỗi (nếu cần) hoặc xử lý sự cố
        DBMS_OUTPUT.PUT_LINE('Error detecting sensitive content: ' || SQLERRM);
END;
/

--1: Cap nhat tong luot binh chon
CREATE OR REPLACE TRIGGER trg_UpdatePostVotes
AFTER INSERT OR UPDATE ON TaiKhoan_TuongTac_BaiDang
FOR EACH ROW
BEGIN
    -- Cap nhat lai tong luot binh chon cho bai dang
    UPDATE BaiDang
    SET LuotXem = (
        SELECT SUM(Upvote) - SUM(Downvote)
        FROM TaiKhoan_TuongTac_BaiDang
        WHERE MaBaiDang = :NEW.MaBaiDang
    )
    WHERE MaBaiDang = :NEW.MaBaiDang;
END;

--3:  xoa bai dang tu dong khi tai khoan bi xoa (cascade)

CREATE OR REPLACE TRIGGER trg_delete_BaiDang_Cascade
AFTER DELETE ON TaiKhoan
FOR EACH ROW
BEGIN
    DELETE FROM BaiDang
    WHERE MaTaiKhoan = :OLD.MaTaiKhoan;
END;
/
--Tự động hủy báo cáo vi phạm nếu bài viết bị xóa
CREATE OR REPLACE TRIGGER trg_cascade_delete_violation_reports
AFTER DELETE ON BaiDang
FOR EACH ROW
BEGIN
    DELETE FROM BaoCaoViPham
    WHERE MaBaiDang = :OLD.MaBaiDang;
END;
/
-- Giới hạn số bài đăng hàng ngày
CREATE OR REPLACE TRIGGER trg_limit_daily_posts
BEFORE INSERT ON BaiDang
FOR EACH ROW
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM BaiDang
    WHERE MaTaiKhoan = :NEW.MaTaiKhoan
      AND TRUNC(NgayDang) = TRUNC(SYSDATE);

    IF v_count >= 10 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Tài khoản này đã đạt giới hạn 10 bài đăng trong ngày!');
    END IF;
END;
/
--Tự động xóa bình luận nếu tài khoản bị xóa
CREATE OR REPLACE TRIGGER trg_cascade_delete_comments
AFTER DELETE ON TaiKhoan
FOR EACH ROW
BEGIN
    DELETE FROM BinhLuan
    WHERE MaTaiKhoan = :OLD.MaTaiKhoan;
END;
/
--Giới hạn số lượt tương tác liên tục của một tài khoản trong một thời gian ngắn
CREATE OR REPLACE TRIGGER trg_limit_interactions
BEFORE INSERT ON TaiKhoan_TuongTac_BaiDang
FOR EACH ROW
DECLARE
    v_recent_interactions INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO v_recent_interactions
    FROM TaiKhoan_TuongTac_BaiDang
    WHERE MaTaiKhoan = :NEW.MaTaiKhoan
      AND MaBaiDang = :NEW.MaBaiDang
      AND ThoiGianTuongTac > SYSDATE - INTERVAL '1' MINUTE;

    IF v_recent_interactions >= 5 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Bạn không thể tương tác quá 5 lần trên cùng một bài viết trong vòng 1 phút!');
    END IF;
END;
/
--Ngăn trùng lặp báo cáo vi phạm
CREATE OR REPLACE TRIGGER trg_prevent_duplicate_reports
BEFORE INSERT ON BaoCaoViPham
FOR EACH ROW
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM BaoCaoViPham
    WHERE MaTaiKhoan = :NEW.MaTaiKhoan
      AND MaBaiDang = :NEW.MaBaiDang;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20008, 'Bạn đã báo cáo bài viết này trước đó!');
    END IF;
END;
/


-- --2:Kiem tra va cap nhat phieu bau cua nguoi dung doi voi 1 bai dang 

-- CREATE OR REPLACE TRIGGER trg_TaiKhoan_TuongTac_BaiDang_UpdateVote
-- BEFORE INSERT OR UPDATE ON TaiKhoan_TuongTac_BaiDang
-- FOR EACH ROW
-- BEGIN
--     --  Kiem tra xem nguoi dung da bo phieu cho bai dang chua
   
--     IF :NEW.MaTaiKhoan IS NOT NULL AND :NEW.MaBaiDang IS NOT NULL THEN
--         DECLARE
--             vote_exists NUMBER;
--         BEGIN
--             -- Kiem tra neu da co phieu bau cua nguoi dung cho bai dang
--             SELECT COUNT(*)
--             INTO vote_exists
--             FROM TaiKhoan_TuongTac_BaiDang
--             WHERE MaTaiKhoan = :NEW.MaTaiKhoan
--             AND MaBaiDang = :NEW.MaBaiDang;
            
--             IF vote_exists = 0 THEN
--              --Neu chua co phieu bau, thuc hine chen moi
--                 NULL;  -- Kh�ng c?n l�m g� th�m, v� ?� l� INSERT.
--             ELSE
--                 -- Neu da co phieu bau, chi can cap nhat phieu
--                 UPDATE TaiKhoan_TuongTac_BaiDang
--                 SET Upvote = :NEW.Upvote, Downvote = :NEW.Downvote, ThoiGianTuongTac = SYSDATE
--                 WHERE MaTaiKhoan = :NEW.MaTaiKhoan
--                 AND MaBaiDang = :NEW.MaBaiDang;
--             END IF;
--         END;
--     END IF;
-- END;

-- --7: Cap nhat trang thai tai khoan khi dat nguong diem dong gop 
-- CREATE OR REPLACE TRIGGER CapNhatHangTaiKhoan
-- AFTER UPDATE OF DiemDongGop ON TaiKhoan
-- FOR EACH ROW
-- BEGIN
    
--     IF :NEW.DiemDongGop >= 2 AND :OLD.DiemDongGop < 2 THEN
--         UPDATE TaiKhoan
--         SET HangTaiKhoan = HangTaiKhoan + 1  
--         WHERE MaTaiKhoan = :NEW.MaTaiKhoan;
    
--     END IF;
-- END;
-- /
