-- Liên quan ??n CDB và PDB (?ây là các l?nh ? b??c 2 trong instruction)
ALTER SESSION SET CONTAINER = CDB$ROOT; -- v? l?i cdb n?u c?n
ALTER SESSION SET CONTAINER = REDDITDBPDB1; -- chuy?n sang pdb

-- LiÃªn quan Ä‘áº¿n Tablespace
SELECT tablespace_name 
FROM pdb_tablespaces;
SELECT tablespace_name
FROM cdb_tablespaces;

-- SET TABLESPACE vá»? OFFLINE
ALTER TABLESPACE tb_internal OFFLINE;
ALTER TABLESPACE tb_index OFFLINE;
ALTER TABLESPACE tb_user_temp OFFLINE;

-- TrÆ°á»?ng há»£p khÃ´ng drop Ä‘Æ°á»£c TABLESPACE do Ä‘á»‹a chá»‰ thÃ¬ chá»‰nh Ä‘á»‹a chá»‰ cá»§a chÃºng vá»? OFFLINE rá»“i DROP
ALTER DATABASE DATAFILE 'C:\BA\YEAR 3 SEMESTER 1\6 HE QUAN TRI CO SO DU LIEU\BAI TAP LON\REDDIT_DBMS_GITHUB\REDDIT_DB\TABLESPACE\TB_INTERNAL_DATAFILE.DBF' OFFLINE;
ALTER DATABASE DATAFILE 'C:\BA\YEAR 3 SEMESTER 1\6 HE QUAN TRI CO SO DU LIEU\BAI TAP LON\REDDIT_DBMS_GITHUB\REDDIT_DB\TABLESPACE\TB_INTERNAL_DATAFILE.DBF' OFFLINE;
ALTER DATABASE DATAFILE 'C:\BA\YEAR 3 SEMESTER 1\6 HE QUAN TRI CO SO DU LIEU\BAI TAP LON\REDDIT_DBMS_GITHUB\REDDIT_DB\TABLESPACE\TB_INTERNAL_DATAFILE.DBF' OFFLINE;

-- DROP TABLESPACE
DROP TABLESPACE tb_internal INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE tb_index INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE tb_user_temp INCLUDING CONTENTS AND DATAFILES;

-- Lien quan den Profile
-- Xóa profile db_admin_profile
DROP PROFILE db_admin_profile;

-- Xóa profile db_developer_profile
DROP PROFILE db_developer_profile;

-- Xóa profile backend_developer_profile
DROP PROFILE backend_developer_profile;

-- Xóa profile data_engineer_profile
DROP PROFILE data_engineer_profile;

-- Xóa profile data_analyst_profile
DROP PROFILE data_analyst_profile;

-- Xóa profile supervisor_profile
DROP PROFILE supervisor_profile;

-- Xóa profile end_user_profile
DROP PROFILE end_user_profile;


-- LiÃªn quan Ä‘áº¿n táº¡o báº£ng
SELECT * FROM TaiKhoan;
SELECT * FROM BaiDang;
SELECT * FROM HoiNhom;
SELECT * FROM PhongNhanTin;
SELECT * FROM BaoCao;
SELECT * FROM TaiKhoanQuangCao;
SELECT * FROM ChienDich;
SELECT * FROM MucTieu;
SELECT * FROM QuangCao;

SELECT * FROM TaiKhoan_Dang_BaiDang;
SELECT * FROM TaiKhoan_TuongTac_BaiDang;
SELECT * FROM TaiKhoan_BinhLuan_BaiDang;
SELECT * FROM TaiKhoan_QuanLy_BaiDang;
SELECT * FROM TaiKhoan_Lap_HoiNhom;
SELECT * FROM TaiKhoan_ThamGia_HoiNhom;
SELECT * FROM TaiKhoan_Lap_PhongNhanTin;
SELECT * FROM TaiKhoan_NhanTin_PhongNhanTin;
SELECT * FROM TaiKhoan_NapTien_TaiKhoan;
SELECT * FROM TaiKhoan_Lap_TaiKhoanQuangCao;
SELECT * FROM TaiKhoanQuangCao_DangKy_ChienDich;
SELECT * FROM ChienDich_Co_MucTieu;
SELECT * FROM ChienDich_Co_QuangCao;
SELECT * FROM BaiDang_Thuoc_HoiNhom;
SELECT * FROM TaiKhoan_Gui_BaoCao;

DROP TABLE TaiKhoan;
DROP TABLE BaiDang;
DROP TABLE HoiNhom;
DROP TABLE PhongNhanTin;
DROP TABLE BaoCao;
DROP TABLE TaiKhoanQuangCao;
DROP TABLE ChienDich;
DROP TABLE MucTieu;
DROP TABLE QuangCao;

DROP TABLE TaiKhoan_Dang_BaiDang;
DROP TABLE TaiKhoan_TuongTac_BaiDang;
DROP TABLE TaiKhoan_BinhLuan_BaiDang;
DROP TABLE TaiKhoan_QuanLy_BaiDang;
DROP TABLE TaiKhoan_Lap_HoiNhom;
DROP TABLE TaiKhoan_ThamGia_HoiNhom;
DROP TABLE TaiKhoan_Lap_PhongNhanTin;
DROP TABLE TaiKhoan_NhanTin_PhongNhanTin;
DROP TABLE TaiKhoan_NapTien_TaiKhoan;
DROP TABLE TaiKhoan_Lap_TaiKhoanQuangCao;
DROP TABLE TaiKhoanQuangCao_DangKy_ChienDich;
DROP TABLE ChienDich_Co_MucTieu;
DROP TABLE ChienDich_Co_QuangCao;
DROP TABLE BaiDang_Thuoc_HoiNhom;
DROP TABLE TaiKhoan_Gui_BaoCao;

DROP SEQUENCE seq_TaiKhoan_Id;
DROP SEQUENCE seq_BaiDang_Id;
DROP SEQUENCE seq_HoiNhom_Id;
DROP SEQUENCE seq_PhongNhanTin_Id;
DROP SEQUENCE seq_BaoCao_Id;
DROP SEQUENCE seq_TaiKhoanQuangCao_Id;
DROP SEQUENCE seq_ChienDich_Id;
DROP SEQUENCE seq_MucTieu_Id;
DROP SEQUENCE seq_QuangCao_Id;

DROP TRIGGER trg_TaiKhoan_Id;
DROP TRIGGER trg_BaiDang_Id;
DROP TRIGGER trg_HoiNhom_Id;
DROP TRIGGER trg_HoiNhom_NgayThanhLap;
DROP TRIGGER trg_PhongNhanTin_Id;
DROP TRIGGER trg_BaoCao_Id;
DROP TRIGGER trg_BaoCao_ThoiGianBaoCao;
DROP TRIGGER trg_TaiKhoanQuangCao_Id;
DROP TRIGGER trg_ChienDich_Id;
DROP TRIGGER trg_MucTieu_Id;
DROP TRIGGER trg_QuangCao_Id;
DROP TRIGGER trg_TaiKhoan_Dang_BaiDang_ThoiGianDangBai;
DROP TRIGGER trg_TaiKhoan_TuongTac_BaiDang_ThoiGianTuongTac;
DROP TRIGGER trg_TaiKhoan_BinhLuan_BaiDang_ThoiGianBinhLuan;
DROP TRIGGER trg_TaiKhoan_NhanTin_PhongNhanTin_ThoiGianNhanTin;

DELETE FROM TaiKhoan