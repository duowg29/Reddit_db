--1: Tang diem dong gop khi dang bai
CREATE OR REPLACE TRIGGER TangDiemDongGop
AFTER INSERT ON BaiDang
FOR EACH ROW
BEGIN
    UPDATE TaiKhoan
    SET DiemDongGop = DiemDongGop + 1
    WHERE MaTaiKhoan = :NEW.MaTaiKhoan;
END;
/
--5: giam diem dong gop khi xoa bai
CREATE OR REPLACE TRIGGER GiamDiemDongGop
AFTER DELETE ON TaiKhoan_Dang_BaiDang
FOR EACH ROW
BEGIN
    UPDATE TaiKhoan
    SET DiemDongGop = DiemDongGop - 1
    WHERE MaTaiKhoan = :OLD.MaTaiKhoan;
END;
/




--6: Cap nhat vang sau khi nap tien
CREATE OR REPLACE TRIGGER CapNhatSoVangTaiKhoan
AFTER INSERT ON TaiKhoan_NapTien_TaiKhoan
FOR EACH ROW
BEGIN
    UPDATE TaiKhoan
    SET Vang = Vang + :NEW.SoVangNhanDuoc
    WHERE MaTaiKhoan = :NEW.MaTaiKhoan;
END;
/
--7: Cap nhat trang thai tai khoan khi dat nguong diem dong gop 
CREATE OR REPLACE TRIGGER CapNhatHangTaiKhoan
AFTER UPDATE OF DiemDongGop ON TaiKhoan
FOR EACH ROW
BEGIN
    
    IF :NEW.DiemDongGop >= 2 AND :OLD.DiemDongGop < 2 THEN
        UPDATE TaiKhoan
        SET HangTaiKhoan = HangTaiKhoan + 1  
        WHERE MaTaiKhoan = :NEW.MaTaiKhoan;
    
    END IF;
END;
/








