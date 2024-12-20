--1 Cap nhat trang thai bai dang khi cap nhat trang thai tai khoan thanh khoa
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
--2. Cap nhap trang thai binh luan neu cap nhap trang thai tai khoan thanh khoa
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

--3. Cap nhat trang thai binh luan khi cap nhat trang thai bai viet thanh khoa
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

--4. Gioi han so bai dang hang ngay
CREATE OR REPLACE TRIGGER trg_limit_daily_posts
BEFORE INSERT ON BaiDang
FOR EACH ROW
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM TaiKhoan_Dang_BaiDang
    WHERE MaTaiKhoan = :NEW.MaTaiKhoan
      AND TRUNC(ThoiGianDangBai) = TRUNC(SYSDATE);

    IF v_count >= 20 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Tai khoan nay vuot qua gioi han 20 bai dang 1 ngay!');
    END IF;
END;
/

--5. Gioi han so luot tuong tac lien tuc cua mot tai khoan trong mot thoi gian ngan
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
