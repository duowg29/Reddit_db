--1. Tao Trigger phat hien noi dung nhay cam hoac khong phu hop
CREATE OR REPLACE TRIGGER trg_detect_sensitive_content
AFTER INSERT OR UPDATE ON BaiDang
FOR EACH ROW
DECLARE
    -- Danh sach tu khoa nhay cam
    v_sensitive_keywords VARCHAR2(4000) := 'xuc pham|bao luc|nsfw';
BEGIN
    -- Kiem tra tu khoa nhay cam trong noi dung bai viet
    IF REGEXP_LIKE(:NEW.NoiDung, v_sensitive_keywords, 'i') THEN
        UPDATE BaiDang
        SET Tag = '[Trigger Warning]',
            ViPham = 1
        WHERE MaBaiDang = :NEW.MaBaiDang;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error detecting sensitive content: ' || SQLERRM);
END;
/
--2. Cap nhat trang thai bai dang khi cap nhat trang thai tai khoan thanh khoa
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
--3. Cap nhap trang thai binh luan neu cap nhap trang thai tai khoan thanh khoa
CREATE OR REPLACE TRIGGER trg_update_comment_status_on_account_locked
AFTER UPDATE OF TrangThai ON TaiKhoan
FOR EACH ROW
BEGIN
    IF :NEW.TrangThai = 'Locked' THEN
        UPDATE TaiKhoan_BinhLuan_BaiDang
        SET TrangThai = 'Private'
        WHERE MaTaiKhoan = :OLD.MaTaiKhoan;
    END IF;
END;
/


--4. Cap nhat trang thai binh luan khi cap nhat trang thai bai viet thanh khoa
CREATE OR REPLACE TRIGGER trg_update_comment_status_on_post_locked
AFTER UPDATE OF TrangThai ON BaiDang
FOR EACH ROW
BEGIN
    IF :NEW.TrangThai = 'Locked' THEN
        UPDATE TaiKhoan_BinhLuan_BaiDang
        SET TrangThai = 'Private'
        WHERE MaBaiDang = :OLD.MaBaiDang;
    END IF;
END;
/

--5. Gioi han so bai dang hang ngay
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

    IF v_count >= 20 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Tai khoan nay da dat gioi han 20 bai dang trong ngay!');
    END IF;
END;
/

--6. Gioi han so luot tuong tac lien tuc cua mot tai khoan trong mot thoi gian ngan
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
        RAISE_APPLICATION_ERROR(-20006, 'Ban khong the tuong tac qua 50 lan tren cung mot bai viet trong vong 1 phut!');
    END IF;
END;
/
