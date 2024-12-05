--
CREATE TABLE TaiKhoan (
    MaTaiKhoan NUMBER PRIMARY KEY,
    AnhDaiDien VARCHAR2(100),
    TenTaiKhoan NVARCHAR2(30) NOT NULL,
    MatKhau NVARCHAR2(20) NOT NULL,
    Email VARCHAR2(50) NOT NULL UNIQUE,
    NgayThamGia DATE NOT NULL,
    QuocGia VARCHAR2(50),
    DiemDongGop NUMBER DEFAULT 0,
    Vang NUMBER DEFAULT 0,
    HangTaiKhoan NUMBER DEFAULT 0,
    ChucVu VARCHAR2(10) DEFAULT 'User' CHECK (ChucVu IN ('Admin', 'Moderator', 'User'))
) TABLESPACE tb_internal;

-- Tao SEQUENCE chung cho viec Insert ID
CREATE SEQUENCE seq_TaiKhoan_Id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- T?o trigger ?? t? ??ng t?ng MaBaiDang t? sequence
CREATE OR REPLACE TRIGGER trg_TaiKhoan_Id
BEFORE INSERT ON TaiKhoan
FOR EACH ROW
BEGIN
    SELECT seq_TaiKhoan_Id.NEXTVAL 
    INTO :NEW.MaTaiKhoan 
    FROM dual;
END;
/

-- Trigger to enforce NgayThamGia <= SYSDATE
CREATE OR REPLACE TRIGGER check_NgayThamGia
BEFORE INSERT OR UPDATE ON TaiKhoan
FOR EACH ROW
BEGIN
    IF :NEW.NgayThamGia > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'NgayThamGia must be less than or equal to today');
    END IF;
END;
/

--
CREATE TABLE BaiDang (
    MaBaiDang NUMBER PRIMARY KEY,
    MaTaiKhoan NUMBER NOT NULL,
    TieuDe NVARCHAR2(255),
    NoiDung NCLOB NOT NULL, 
    TepDinhKem VARCHAR2(100),
    The VARCHAR2(50),
    LuotXem NUMBER DEFAULT 0,
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
) TABLESPACE tb_internal;

-- Tao SEQUENCE chung cho viec Insert ID
CREATE SEQUENCE seq_BaiDang_Id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

--
CREATE OR REPLACE TRIGGER trg_BaiDang_Id
BEFORE INSERT ON BaiDang
FOR EACH ROW
BEGIN
    -- Lấy giá trị tiếp theo từ sequence và gán cho MaBaiDang
    SELECT seq_BaiDang_Id.NEXTVAL 
    INTO :NEW.MaBaiDang 
    FROM dual;
END;
/

--

CREATE TABLE HoiNhom (
    MaHoiNhom NUMBER PRIMARY KEY,
    TenNhom NVARCHAR2(50) NOT NULL,
    MoTa NCLOB, -- S? d?ng NCLOB thay v� NTEXT
    NgayThanhLap DATE NOT NULL
) TABLESPACE tb_internal;

-- Tao SEQUENCE chung cho viec Insert ID
CREATE SEQUENCE seq_HoiNhom_Id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- T?o trigger ?? t? ??ng t?ng MaHoiNhom t? sequence
CREATE OR REPLACE TRIGGER trg_HoiNhom_Id
BEFORE INSERT ON HoiNhom
FOR EACH ROW
BEGIN
    SELECT seq_HoiNhom_Id.NEXTVAL 
    INTO :NEW.MaHoiNhom 
    FROM dual;
END;
/

-- T?o trigger ?? ki?m tra r�ng bu?c cho NgayThanhLap
CREATE OR REPLACE TRIGGER trg_HoiNhom_NgayThanhLap
BEFORE INSERT OR UPDATE ON HoiNhom
FOR EACH ROW
BEGIN
    IF :NEW.NgayThanhLap > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'NgayThanhLap must be less than or equal to today');
    END IF;
END;
/

--
CREATE TABLE PhongNhanTin (
    MaPhongNhanTin NUMBER PRIMARY KEY,
    TenPhong NVARCHAR2(255) DEFAULT 'CHATROOM' NOT NULL,
    ChuDePhong NVARCHAR2(255)
) TABLESPACE tb_internal;

-- Tao SEQUENCE chung cho viec Insert ID
CREATE SEQUENCE seq_PhongNhanTin_Id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- Create a trigger to use the sequence for auto-increment
CREATE OR REPLACE TRIGGER trg_PhongNhanTin_Id
BEFORE INSERT ON PhongNhanTin
FOR EACH ROW
BEGIN
    SELECT seq_PhongNhanTin_Id.NEXTVAL 
    INTO :NEW.MaPhongNhanTin 
    FROM dual;
END;
/

--
CREATE TABLE BaoCao (
    MaBaoCao NUMBER PRIMARY KEY,
    TieuDe NVARCHAR2(255) NOT NULL,
    ChuDe NVARCHAR2(255) NOT NULL,
    NoiDung CLOB NOT NULL,
    MinhChung VARCHAR2(100),
    ThoiGianBaoCao TIMESTAMP NOT NULL 
) TABLESPACE tb_internal;

-- Tao SEQUENCE chung cho viec Insert ID
CREATE SEQUENCE seq_BaoCao_Id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- Create a trigger to use the sequence for auto-increment
CREATE OR REPLACE TRIGGER trg_BaoCao_Id
BEFORE INSERT ON BaoCao
FOR EACH ROW
BEGIN
    SELECT seq_BaoCao_Id.NEXTVAL 
    INTO :NEW.MaBaoCao 
    FROM dual;
END;
/

-- T?o trigger ?? ki?m tra r�ng bu?c cho ThoiGianBaoCao
CREATE OR REPLACE TRIGGER trg_BaoCao_ThoiGianBaoCao
BEFORE INSERT OR UPDATE ON BaoCao
FOR EACH ROW
BEGIN
    IF :NEW.ThoiGianBaoCao > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'ThoiGianBaoCao must be less than or equal to today');
    END IF;
END;
/

--
CREATE TABLE TaiKhoanQuangCao (
    MaTaiKhoanQuangCao NUMBER PRIMARY KEY,
    TenDoanhNghiep NVARCHAR2(255) UNIQUE NOT NULL,
    LinhVuc NVARCHAR2(255) NOT NULL
) TABLESPACE tb_internal;

-- Tao SEQUENCE chung cho viec Insert ID
CREATE SEQUENCE seq_TaiKhoanQuangCao_Id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- Create a trigger to use the sequence for auto-increment
CREATE OR REPLACE TRIGGER trg_TaiKhoanQuangCao_Id
BEFORE INSERT ON TaiKhoanQuangCao
FOR EACH ROW
BEGIN
    SELECT seq_TaiKhoanQuangCao_Id.NEXTVAL 
    INTO :NEW.MaTaiKhoanQuangCao 
    FROM dual;
END;
/

--
CREATE TABLE ChienDich (
    MaChienDich NUMBER PRIMARY KEY,
    TieuDe NVARCHAR2(255) NOT NULL,
    NoiDung NCLOB NOT NULL,
    PhuongThucThanhToan NVARCHAR2(50) NOT NULL
) TABLESPACE tb_internal;

-- Tao SEQUENCE chung cho viec Insert ID
CREATE SEQUENCE seq_ChienDich_Id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- Create a trigger to use the sequence for auto-increment
CREATE OR REPLACE TRIGGER trg_ChienDich_Id
BEFORE INSERT ON ChienDich
FOR EACH ROW
BEGIN
    SELECT seq_ChienDich_Id.NEXTVAL 
    INTO :NEW.MaChienDich 
    FROM dual;
END;
/

--
CREATE TABLE MucTieu (
    MaMucTieu NUMBER PRIMARY KEY,
    TenMucTieu NVARCHAR2(255) NOT NULL,
    TepDinhKem VARCHAR2(100),
    ChiPhi NUMBER DEFAULT 0,
    MaChienDich NUMBER NOT NULL,
    FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich)
) TABLESPACE tb_internal;

-- Tao SEQUENCE chung cho viec Insert ID
CREATE SEQUENCE seq_MucTieu_Id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- Create a trigger to use the sequence for auto-increment
CREATE OR REPLACE TRIGGER trg_MucTieu_Id
BEFORE INSERT ON MucTieu
FOR EACH ROW
BEGIN
    SELECT seq_MucTieu_Id.NEXTVAL 
    INTO :NEW.MaMucTieu 
    FROM dual;
END;
/

--
CREATE TABLE QuangCao (
    MaQuangCao NUMBER PRIMARY KEY,
    TieuDe NVARCHAR2(255) NOT NULL,
    TepDinhKem VARCHAR2(100),
	ChiPhi NUMBER NOT NULL,
    MaChienDich NUMBER NOT NULL,
    FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich)
) TABLESPACE tb_internal;

-- Tao SEQUENCE chung cho viec Insert ID
CREATE SEQUENCE seq_QuangCao_Id
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- Create a trigger to use the sequence for auto-increment
CREATE OR REPLACE TRIGGER trg_QuangCao_Id
BEFORE INSERT ON QuangCao
FOR EACH ROW
BEGIN
    SELECT seq_QuangCao_Id.NEXTVAL 
    INTO :NEW.MaQuangCao 
    FROM dual;
END;
/

--
CREATE TABLE TaiKhoan_Dang_BaiDang (
    MaTaiKhoan NUMBER NOT NULL,
    MaBaiDang NUMBER NOT NULL,
    ThoiGianDangBai DATE NOT NULL,
    PRIMARY KEY (MaTaiKhoan, MaBaiDang),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaBaiDang) REFERENCES BaiDang(MaBaiDang)
) TABLESPACE tb_index;
-- T?o trigger ?? ki?m tra r�ng bu?c cho ThoiGianDangBai
CREATE OR REPLACE TRIGGER trg_TaiKhoan_Dang_BaiDang_ThoiGianDangBai
BEFORE INSERT OR UPDATE ON TaiKhoan_Dang_BaiDang
FOR EACH ROW
BEGIN
    IF :NEW.ThoiGianDangBai > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'ThoiGianDangBai must be less than or equal to today');
    END IF;
END;
/

--
CREATE TABLE TaiKhoan_TuongTac_BaiDang (
    MaTaiKhoan NUMBER NOT NULL,
    MaBaiDang NUMBER NOT NULL,
    Upvote NUMBER DEFAULT 0,
	Downvote NUMBER DEFAULT 0,
    ThoiGianTuongTac DATE NOT NULL,
    PRIMARY KEY (MaTaiKhoan, MaBaiDang),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaBaiDang) REFERENCES BaiDang(MaBaiDang)
) TABLESPACE tb_index;
-- T?o trigger ?? ki?m tra r�ng bu?c cho ThoiGianDangBai
CREATE OR REPLACE TRIGGER trg_TaiKhoan_TuongTac_BaiDang_ThoiGianTuongTac
BEFORE INSERT OR UPDATE ON TaiKhoan_TuongTac_BaiDang
FOR EACH ROW
BEGIN
    IF :NEW.ThoiGianTuongTac > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'ThoiGianTuongTac must be less than or equal to today');
    END IF;
END;
/

--
CREATE TABLE TaiKhoan_BinhLuan_BaiDang (
    MaTaiKhoan NUMBER NOT NULL,
    MaBaiDang NUMBER NOT NULL,
    ThoiGianBinhLuan DATE NOT NULL,
    NoiDungBinhLuan NCLOB NOT NULL,
    TepDinhKem VARCHAR2(100),
    PRIMARY KEY (MaTaiKhoan, MaBaiDang, ThoiGianBinhLuan),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaBaiDang) REFERENCES BaiDang(MaBaiDang)
) TABLESPACE tb_index;

-- T?o trigger ?? ki?m tra r�ng bu?c cho ThoiGianBinhLuan
CREATE OR REPLACE TRIGGER trg_TaiKhoan_BinhLuan_BaiDang_ThoiGianBinhLuan
BEFORE INSERT OR UPDATE ON TaiKhoan_BinhLuan_BaiDang
FOR EACH ROW
BEGIN
    IF :NEW.ThoiGianBinhLuan > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'ThoiGianBinhLuan must be less than or equal to today');
    END IF;
END;
/

--
CREATE TABLE TaiKhoan_QuanLy_BaiDang (
    MaTaiKhoan NUMBER NOT NULL,
    MaBaiDang NUMBER NOT NULL,
    PRIMARY KEY (MaTaiKhoan, MaBaiDang),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaBaiDang) REFERENCES BaiDang(MaBaiDang)
) TABLESPACE tb_index;

--
CREATE TABLE TaiKhoan_Lap_HoiNhom (
    MaTaiKhoan NUMBER NOT NULL,
    MaHoiNhom NUMBER NOT NULL,
    PRIMARY KEY (MaTaiKhoan, MaHoiNhom),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaHoiNhom) REFERENCES HoiNhom(MaHoiNhom)
) TABLESPACE tb_index;

--
CREATE TABLE TaiKhoan_ThamGia_HoiNhom (
    MaTaiKhoan NUMBER NOT NULL,
    MaHoiNhom NUMBER NOT NULL,
    PRIMARY KEY (MaTaiKhoan, MaHoiNhom),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaHoiNhom) REFERENCES HoiNhom(MaHoiNhom)
) TABLESPACE tb_index;

--
CREATE TABLE TaiKhoan_Lap_PhongNhanTin (
    MaTaiKhoan NUMBER NOT NULL,
    MaPhongNhanTin NUMBER NOT NULL,
    PRIMARY KEY (MaTaiKhoan, MaPhongNhanTin),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaPhongNhanTin) REFERENCES PhongNhanTin(MaPhongNhanTin)
) TABLESPACE tb_index;

--
CREATE TABLE TaiKhoan_NhanTin_PhongNhanTin (
    MaTaiKhoan NUMBER NOT NULL,
    MaPhongNhanTin NUMBER NOT NULL,
	NoiDungNhanTin NCLOB NOT NULL,
	ThoiGianNhanTin DATE DEFAULT SYSDATE NOT NULL ,
	TepDinhKem VARCHAR2(100),
    PRIMARY KEY (MaTaiKhoan, MaPhongNhanTin),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaPhongNhanTin) REFERENCES PhongNhanTin(MaPhongNhanTin)
) TABLESPACE tb_index;
-- T?o trigger ?? ki?m tra r�ng bu?c cho ThoiGianNhanTin
CREATE OR REPLACE TRIGGER trg_TaiKhoan_NhanTin_PhongNhanTin_ThoiGianNhanTin
BEFORE INSERT OR UPDATE ON TaiKhoan_NhanTin_PhongNhanTin
FOR EACH ROW
BEGIN
    IF :NEW.ThoiGianNhanTin > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'ThoiGianNhanTin must be less than or equal to today');
    END IF;
END;
/

--
CREATE TABLE TaiKhoan_NapTien_TaiKhoan (
    MaGiaoDich NUMBER NOT NULL,
	MaTaiKhoan NUMBER NOT NULL,
    ThoiDiemThanhToan DATE NOT NULL,
    PhuongThucThanhToan NVARCHAR2(50) NOT NULL,
    SoTien NUMBER NOT NULL,
    SoVangNhanDuoc NUMBER NOT NULL,
    PRIMARY KEY (MaTaiKhoan, MaGiaoDich),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
) TABLESPACE tb_index;

--
CREATE TABLE TaiKhoan_Lap_TaiKhoanQuangCao (
    MaTaiKhoan NUMBER NOT NULL,
    MaTaiKhoanQuangCao NUMBER NOT NULL,
    PRIMARY KEY (MaTaiKhoan, MaTaiKhoanQuangCao),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaTaiKhoanQuangCao) REFERENCES TaiKhoanQuangCao(MaTaiKhoanQuangCao)
) TABLESPACE tb_index;

--
CREATE TABLE TaiKhoanQuangCao_DangKy_ChienDich (
    MaTaiKhoanQuangCao NUMBER NOT NULL,
    MaChienDich NUMBER NOT NULL,
    MaGiaoDich NUMBER NOT NULL,
    ThoiDiemThanhToan DATE NOT NULL,
    PhuongThucThanhToan NVARCHAR2(50) NOT NULL,
    SoTien NUMBER DEFAULT 0 NOT NULL,
    PRIMARY KEY (MaTaiKhoanQuangCao, MaChienDich, MaGiaoDich),
    FOREIGN KEY (MaTaiKhoanQuangCao) REFERENCES TaiKhoanQuangCao(MaTaiKhoanQuangCao),
    FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich)
) TABLESPACE tb_index;

--
CREATE TABLE ChienDich_Co_MucTieu (
    MaChienDich NUMBER NOT NULL,
    MaMucTieu NUMBER NOT NULL,
    PRIMARY KEY (MaChienDich, MaMucTieu),
    FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich),
    FOREIGN KEY (MaMucTieu) REFERENCES MucTieu(MaMucTieu)
) TABLESPACE tb_index;

--
CREATE TABLE ChienDich_Co_QuangCao (
    MaChienDich NUMBER NOT NULL,
    MaQuangCao NUMBER NOT NULL,
    PRIMARY KEY (MaChienDich, MaQuangCao),
    FOREIGN KEY (MaChienDich) REFERENCES ChienDich(MaChienDich),
    FOREIGN KEY (MaQuangCao) REFERENCES QuangCao(MaQuangCao)
) TABLESPACE tb_index;

--
CREATE TABLE BaiDang_Thuoc_HoiNhom (
    MaBaiDang NUMBER NOT NULL,
    MaHoiNhom NUMBER NOT NULL,
    PRIMARY KEY (MaBaiDang, MaHoiNhom),
    FOREIGN KEY (MaBaiDang) REFERENCES BaiDang(MaBaiDang),
    FOREIGN KEY (MaHoiNhom) REFERENCES HoiNhom(MaHoiNhom)
) TABLESPACE tb_index;

--
CREATE TABLE TaiKhoan_Gui_BaoCao (
    MaTaiKhoan NUMBER NOT NULL,
    MaBaoCao NUMBER NOT NULL,
    PRIMARY KEY (MaTaiKhoan, MaBaoCao),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
    FOREIGN KEY (MaBaoCao) REFERENCES BaoCao(MaBaoCao) 
) TABLESPACE tb_index;

-- Thủ tục tăng điểm đóng góp và cập nhật hạng tài khoản 
CREATE OR REPLACE PROCEDURE CapNhatDiemDongGop IS
BEGIN
    -- Tăng điểm đóng góp dựa trên bảng  TaiKhoan_Dang_BaiDang
    UPDATE TaiKhoan T
    SET T.DiemDongGop = T.DiemDongGop + 
        (SELECT COUNT(*)
         FROM TaiKhoan_Dang_BaiDang D
         WHERE D.MaTaiKhoan = T.MaTaiKhoan);
         
    -- Cập nhật hạng tài khoản 
    UPDATE TaiKhoan
    SET HangTaiKhoan = HangTaiKhoan + 1
    WHERE DiemDongGop >= 2;
    
    commit;
END;
/



----6: Cap nhat vang sau khi nap tien
CREATE OR REPLACE TRIGGER CapNhatSoVangTaiKhoan
AFTER INSERT ON TaiKhoan_NapTien_TaiKhoan
FOR EACH ROW
BEGIN
    UPDATE TaiKhoan
    SET Vang = Vang + :NEW.SoVangNhanDuoc
    WHERE MaTaiKhoan = :NEW.MaTaiKhoan;
END;
/

exec CapNhatDiemDongGop;
-----
--
/*
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
CREATE OR REPLACE TRIGGER TangDiemDongGop
AFTER INSERT ON TaiKhoan_Dang_BaiDang
FOR EACH ROW
BEGIN
    UPDATE TaiKhoan
    SET DiemDongGop = DiemDongGop + 1
    WHERE MaTaiKhoan = :NEW.MaTaiKhoan;
END;
/
*/