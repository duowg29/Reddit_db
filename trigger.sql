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





