-- 1. Tạo Trigger phát hiện nội dung nhạy cảm hoặc không phù hợp
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
--2.  Cap nhat trang thai bai dang va binh luan khi cap nhat trang thai tai khoan
CREATE OR REPLACE TRIGGER trg_update_BaiDang_TrangThai
AFTER UPDATE OF TrangThai ON TaiKhoan
FOR EACH ROW
BEGIN
    IF :NEW.TrangThai = 'Locked' THEN
        UPDATE BaiDang
        SET TrangThai = 'Locked'
        WHERE MaTaiKhoan = :OLD.MaTaiKhoan;

    ELSIF :NEW.TrangThai = 'Private' THEN
        UPDATE BaiDang
        SET TrangThai = 'Private'
        WHERE MaTaiKhoan = :OLD.MaTaiKhoan;

    ELSIF :NEW.TrangThai = 'Public' THEN
        UPDATE BaiDang
        SET TrangThai = 'Public'
        WHERE MaTaiKhoan = :OLD.MaTaiKhoan;
    END IF;
END;
/
--Cap nhap trang thai binh luan khi cap nhap trang thai bai

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
/*--Tự động xóa bình luận nếu tài khoản bị xóa
CREATE OR REPLACE TRIGGER trg_cascade_delete_comments
AFTER DELETE ON TaiKhoan
FOR EACH ROW
BEGIN
    DELETE FROM BinhLuan
    WHERE MaTaiKhoan = :OLD.MaTaiKhoan;
END;
*/
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

    IF v_recent_interactions >= 50 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Bạn không thể tương tác quá 50 lần trên cùng một bài viết trong vòng 1 phút!');
    END IF;
END;
/



