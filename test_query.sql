-- Xac nhan cac thay doi tren CSDL cua cac lenh DML (SELECT, INSERT, DELETE, MERGE)
COMMIT;
-- Quay lai phien ban truoc do
ROLLBACK;
-- -- Li�n quan ??n CDB v� PDB (?�y l� c�c l?nh ? b??c 2 trong instruction)
-- ALTER SESSION SET CONTAINER = CDB$ROOT; -- v? l?i cdb n?u c?n
-- ALTER SESSION SET CONTAINER = REDDITDBPDB1; -- chuy?n sang pdb

-- Kiem tra Container hien tai la PDB hay CDB
SELECT SYS_CONTEXT('USERENV', 'CON_NAME') AS CURRENT_CONTAINER FROM DUAL;

-- Liet ke cac PDB hien tai (neu khogn tao duoc user thi kiem tra xem minh dang ket noi toi PDB nao)
SELECT name, open_mode, con_id
FROM v$pdbs;
SELECT * FROM DBA_PDBS;

-- Liên quan đến Tablespace
SELECT tablespace_name 
FROM pdb_tablespaces;
SELECT tablespace_name
FROM cdb_tablespaces;

-- SET TABLESPACE v�? OFFLINE
ALTER TABLESPACE tb_internal OFFLINE;
ALTER TABLESPACE tb_index OFFLINE;
ALTER TABLESPACE tb_user_temp OFFLINE;

-- Trư�?ng hợp không drop được TABLESPACE do địa chỉ thì chỉnh địa chỉ của chúng v�? OFFLINE rồi DROP
ALTER DATABASE DATAFILE 'C:\BA\YEAR 3 SEMESTER 1\6 HE QUAN TRI CO SO DU LIEU\BAI TAP LON\REDDIT_DBMS_GITHUB\REDDIT_DB\TABLESPACE\TB_INTERNAL_DATAFILE.DBF' OFFLINE;
ALTER DATABASE DATAFILE 'C:\BA\YEAR 3 SEMESTER 1\6 HE QUAN TRI CO SO DU LIEU\BAI TAP LON\REDDIT_DBMS_GITHUB\REDDIT_DB\TABLESPACE\TB_INTERNAL_DATAFILE.DBF' OFFLINE;
ALTER DATABASE DATAFILE 'C:\BA\YEAR 3 SEMESTER 1\6 HE QUAN TRI CO SO DU LIEU\BAI TAP LON\REDDIT_DBMS_GITHUB\REDDIT_DB\TABLESPACE\TB_INTERNAL_DATAFILE.DBF' OFFLINE;

-- DROP TABLESPACE
DROP TABLESPACE tb_internal INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE tb_user_temp INCLUDING CONTENTS AND DATAFILES;

-- Lien quan den Profile

-- Liet ke Profile
SELECT * 
FROM dba_profiles

-- X�a profile db_admin_profile
DROP PROFILE db_admin_profile;

-- X�a profile db_developer_profile
DROP PROFILE db_developer_profile;

-- X�a profile backend_developer_profile
DROP PROFILE backend_developer_profile;

-- X�a profile data_engineer_profile
DROP PROFILE data_engineer_profile;

-- X�a profile data_analyst_profile
DROP PROFILE data_analyst_profile;

-- X�a profile supervisor_profile
DROP PROFILE supervisor_profile;

-- X�a profile end_user_profile
DROP PROFILE end_user_profile;

-- Lien quan den User
-- Kiem tra user dang chay
SELECT USER FROM dual;

--Liet ke cac user
SELECT USERNAME 
FROM ALL_USERS 
ORDER BY USERNAME;

-- Kiem tra trang thai User
SELECT USERNAME, ACCOUNT_STATUS, EXPIRY_DATE 
FROM DBA_USERS 
WHERE USERNAME = 'DB_ADMIN';


SELECT * FROM user_tab_privs;      -- Quy?n tr�n c�c ??i t??ng
SELECT * FROM user_role_privs;     -- Quy?n c?a roles
SELECT * FROM user_sys_privs;      -- Quy?n h? th?ng


-- X�a user db_admin
DROP USER db_admin CASCADE;

-- X�a user db_developer
DROP USER db_developer CASCADE;

-- X�a user backend_developer
DROP USER backend_developer CASCADE;

-- X�a user data_engineer
DROP USER data_engineer CASCADE;

-- X�a user data_analyst
DROP USER data_analyst CASCADE;

-- X�a user supervisor_user
DROP USER supervisor_user CASCADE;

-- X�a user end_user
DROP USER end_user CASCADE;

-- Lien quan den ROLE

-- Liet ke tat ca cac quyen cua cac user
SELECT * 
FROM dba_tab_privs WHERE Grantee = 'db_admin';

-- X�a vai tr� DBAdmin
DROP ROLE DBAdmin;

-- X�a vai tr� DatabaseDeveloper
DROP ROLE DatabaseDeveloper;

-- X�a vai tr� BackendDeveloper
DROP ROLE BackendDeveloper;

-- X�a vai tr� DataEngineer
DROP ROLE DataEngineer;

-- X�a vai tr� DataAnalyst
DROP ROLE DataAnalyst;

-- X�a vai tr� Supervisor
DROP ROLE Supervisor;

-- X�a vai tr� EndUser
DROP ROLE EndUser;


-- Liên quan đến tạo bảng
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
DROP TRIGGER check_NgayThamGia;
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