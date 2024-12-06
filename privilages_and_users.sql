-- USER CREATION

-- Liet ke cac PDB hien tai (neu khogn tao duoc user thi kiem tra xem minh dang ket noi toi PDB nao)
SELECT name, open_mode, con_id
FROM v$pdbs;
SELECT * FROM DBA_PDBS;

-- Chuyen ket noi sang PDB REDDITDBPDB1
ALTER SESSION SET CONTAINER = REDDITDBPDB1;

-- Tao va gan profile cho DB Admin
CREATE USER C##db_admin IDENTIFIED BY dbadmin_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER C##db_admin PROFILE db_admin_profile;

-- Tao va gan profile cho Database Developer
CREATE USER C##db_developer IDENTIFIED BY dbdeveloper_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER C##db_developer PROFILE db_developer_profile;

-- Tao va gan profile cho Back-end Developer
CREATE USER C##backend_developer IDENTIFIED BY backenddeveloper_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER C##backend_developer PROFILE backend_developer_profile;

-- Tao va gan profile cho Data Engineer
CREATE USER C##data_engineer IDENTIFIED BY dataengineer_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER C##data_engineer PROFILE data_engineer_profile;

-- Tao va gan profile cho Data Analyst
CREATE USER C##data_analyst IDENTIFIED BY dataanalyst_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER C##data_analyst PROFILE data_analyst_profile;

-- Tao va gan profile cho Supervisor
CREATE USER C##supervisor_user IDENTIFIED BY supervisor_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER C##supervisor_user PROFILE supervisor_profile;

-- Tao va gan profile cho End User
CREATE USER C##end_user IDENTIFIED BY enduser_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER C##end_user PROFILE end_user_profile;


-- ROLE CREATION

-- 1. Quan tri vien co so du lieu (DB Admin)
-- Nhiem vu: Quan ly cac co so du lieu, bao gom bao tri va thay doi cau truc.
-- Tao vai tro Quan tri vien co so du lieu
CREATE ROLE C##DBAdmin;
GRANT DBA TO C##DBAdmin;

-- Trao quyen ket noi
GRANT CREATE SESSION TO C##DBAdmin;
-- DBA da bao gom:
-- Quyen ket noi va quan ly phien
-- Cac quyen lien quan den bang
-- Cac quyen lien quan den thu tuc
-- Cac quyen lien quan den index
-- Cac quyen lien quan den tablespace

-- Cac quyen lien quan den sao luu/phuc hoi
GRANT BACKUP ANY TABLE TO C##DBAdmin;
GRANT FLASHBACK ANY TABLE TO C##DBAdmin;

-- 2. Nha phat trien co so du lieu (Database Developer)
-- Nhiem vu: Xay dung, phat trien va thu nghiem cac chuc nang moi trong co so du lieu.
-- Tao vai tro Nha phat trien co so du lieu
CREATE ROLE C##DatabaseDeveloper;

-- Quyen dang nhap
GRANT CREATE SESSION TO C##DatabaseDeveloper;

-- Trao quyen tren mot so view chi dinh
--GRANT SELECT ON view_name TO C##BackendDeveloper;

---- Cap quyen INSERT cho tat ca cac view trong schema
--GRANT INSERT ON view_name TO C##DatabaseDeveloper;
-- 
---- Cap quyen UPDATE cho tat ca cac view trong schema
--GRANT UPDATE ON view_name TO C##DatabaseDeveloper;

-- Quan ly cac bang
GRANT CREATE TABLE TO C##DatabaseDeveloper; -- Tao bang moi
GRANT INSERT ANY TABLE TO C##DatabaseDeveloper; -- Chen du lieu vao moi bang
GRANT UPDATE ANY TABLE TO C##DatabaseDeveloper; -- Cap nhat du lieu trong moi bang
GRANT DELETE ANY TABLE TO C##DatabaseDeveloper; -- Xoa du lieu tu moi bang

-- Quan ly thu tuc
GRANT CREATE PROCEDURE TO C##DatabaseDeveloper; -- Tao thu tuc
GRANT EXECUTE ANY PROCEDURE TO C##DatabaseDeveloper; -- Thuc thi moi thu tuc trong co so du lieu
GRANT ALTER ANY PROCEDURE TO C##DatabaseDeveloper; -- Thay doi moi thu tuc trong co so du lieu

-- Quan ly trigger
GRANT CREATE TRIGGER TO C##DatabaseDeveloper; -- Tao trigger
GRANT ALTER ANY TRIGGER TO C##DatabaseDeveloper; -- Thay doi moi trigger trong co so du lieu

-- Cap quyen truy cap vao cac doi tuong khac neu can
GRANT SELECT ANY TABLE TO C##DatabaseDeveloper; -- Doc du lieu tu moi bang trong co so du lieu

-- 3. Nha phat trien ung dung (Back-end Developer)
-- Nhiem vu: Xay dung va bao tri cac chuc nang phia back-end cua he thong, bao gom tao, sua doi va thuc thi cac thu tuc, trigger; xu ly du lieu trong cac bang chinh.
CREATE ROLE C##BackendDeveloper;

-- Cap quyen dang nhap
GRANT CREATE SESSION TO C##BackendDeveloper;

-- Cap quyen thao tac thu tuc
GRANT CREATE PROCEDURE TO C##BackendDeveloper; -- Cap quyen tao thu tuc
GRANT ALTER ANY PROCEDURE TO C##BackendDeveloper; -- Cap quyen thay doi bat ky thu tuc nao
GRANT EXECUTE ANY PROCEDURE TO C##BackendDeveloper; -- Cap quyen thuc thi thu tuc trong tat ca cac schema

-- Cap quyen thao tac trigger
GRANT CREATE TRIGGER TO C##BackendDeveloper; -- Cap quyen tao trigger
GRANT ALTER ANY TRIGGER TO C##BackendDeveloper; -- Cap quyen thay doi bat ky trigger nao trong he thong

-- Cap quyen thao tac tren cac bang chinh (CAN TAO BANG TRUOC KHI CHAY)
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoan TO C##BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON BaiDang TO C##BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON PhongNhanTin TO C##BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON BaoCao TO C##BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoanQuangCao TO C##BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChienDich TO C##BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON MucTieu TO C##BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON QuangCao TO C##BackendDeveloper;

-- 4. Ky su du lieu (Data Engineer)
-- Nhiem vu: Thiet ke, xay dung, va duy tri co so du lieu; xu ly du lieu tu nhieu nguon.
CREATE ROLE C##DataEngineer;

-- Cap quyen dang nhap
GRANT CREATE SESSION TO C##DataEngineer;

-- Cap quyen thao tac tren du lieu (Can tao bang truoc)
GRANT SELECT ANY TABLE TO C##DataEngineer;
GRANT INSERT, UPDATE, DELETE ON TaiKhoan TO C##BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON BaiDang TO C##BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON PhongNhanTin TO C##BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON BaoCao TO C##BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON TaiKhoanQuangCao TO C##BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON ChienDich TO C##BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON MucTieu TO C##BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON QuangCao TO C##BackendDeveloper;

-- Cap quyen thao tac cau truc co so du lieu
GRANT CREATE TABLE TO C##DataEngineer;
GRANT ALTER ANY TABLE TO C##DataEngineer;
GRANT CREATE SEQUENCE TO C##DataEngineer;
GRANT CREATE VIEW TO C##DataEngineer;

-- Cap quyen truy cap bang he thong (can DBA trao quyen)
GRANT SELECT ON DBA_TABLES TO C##DataEngineer;
GRANT SELECT ON DBA_TAB_COLUMNS TO C##DataEngineer;
GRANT SELECT ON DBA_INDEXES TO C##DataEngineer;

-- Cap quyen thao tac voi thu tuc va chi muc
GRANT CREATE PROCEDURE TO C##DataEngineer;

-- Trao quyen exec proc, func, package (can chi dinh)
--GRANT EXECUTE ON <FUNCTION_NAME> TO <USER>;

-- Trao quyen tao va huy index (can dba trao quyen)
GRANT CREATE ANY INDEX, DROP ANY INDEX TO C##DataEngineer;

-- Cap quyen thuc thi thu tuc toi uu hoa (Can DBA trao quyen)
GRANT EXECUTE ON DBMS_STATS TO C##DataEngineer;

-- 5. Nha phan tich du lieu (Data Analyst)
-- Nhiem vu: Phan tich va truc quan hoa du lieu, tao view de ho tro bao cao.
CREATE ROLE C##DataAnalyst;

-- Cho phep dang nhap vao co so du lieu
GRANT CREATE SESSION TO C##DataAnalyst; 

-- Cho phep doc du lieu tu tat ca cac bang
GRANT SELECT ANY TABLE TO C##DataAnalyst;

-- Cho phep tao view
GRANT CREATE VIEW TO C##DataAnalyst; 

-- 6. Giam sat vien (Supervisor)
-- Nhiem vu: Theo doi hoat dong chung cua he thong, khong thuc hien cac thay doi lon.
-- Tao vai tro Giam sat vien
CREATE ROLE C##Supervisor;

-- Cac quyen co ban
GRANT CREATE SESSION TO C##Supervisor;
GRANT RESTRICTED SESSION TO C##Supervisor;

-- Quyen truy cap
GRANT SELECT ANY TABLE TO C##Supervisor;

-- Quyen phan tich
GRANT ANALYZE ANY TO C##Supervisor;

-- 7. Nguoi dung (End-User)
-- Nhiem vu: Su dung cac tinh nang co ban cua he thong nhu xem va tuong tac voi du lieu.
CREATE ROLE C##EndUser;
GRANT CONNECT TO C##EndUser;

GRANT CREATE SESSION TO C##EndUser; -- Cho phep dang nhap vao co so du lieu

-- Cap quyen xem va them du lieu tren cac bang (can tao bang truoc)
GRANT SELECT, INSERT, UPDATE ON TaiKhoan TO C##EndUser; -- Cho phep xem va them du lieu trong bang TaiKhoan
GRANT SELECT, INSERT, UPDATE ON BaiDang TO C##EndUser; -- Cho phep xem va them du lieu trong bang BaiDang
GRANT SELECT, INSERT, UPDATE ON PhongNhanTin TO C##EndUser; -- Cho phep xem va them du lieu trong bang PhongNhanTin
GRANT SELECT, INSERT, UPDATE ON BaoCao TO C##EndUser; -- Cho phep xem va them du lieu trong bang BaoCao
GRANT SELECT, INSERT, UPDATE ON TaiKhoanQuangCao TO C##EndUser; -- Cho phep xem va them du lieu trong bang TaiKhoanQuangCao
GRANT SELECT, INSERT, UPDATE ON ChienDich TO C##EndUser; -- Cho phep xem va them du lieu trong bang ChienDich
GRANT SELECT, INSERT, UPDATE ON MucTieu TO C##EndUser; -- Cho phep xem va them du lieu trong bang MucTieu
GRANT SELECT, INSERT, UPDATE ON QuangCao TO C##EndUser; -- Cho phep xem va them du lieu trong bang QuangCao

-- Gan cac vai tro cho nguoi dung tuong ung
GRANT C##Supervisor TO supervisor_user;
GRANT C##DBAdmin TO db_admin;
GRANT C##DatabaseDeveloper TO db_developer;
GRANT C##BackendDeveloper TO backend_developer;
GRANT C##DataEngineer TO data_engineer;
GRANT C##DataAnalyst TO data_analyst;
GRANT C##EndUser TO end_user;
