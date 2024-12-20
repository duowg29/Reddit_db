-- USER CREATION

-- Tao va gan profile cho DB Admin
-- Tạo user db_admin và gán profile
CREATE USER db_admin IDENTIFIED BY dbadmin_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER db_admin PROFILE db_admin_profile;

-- Cấp quota cho db_admin
ALTER USER db_admin QUOTA UNLIMITED ON tb_internal;

-- Tạo user db_developer và gán profile
CREATE USER db_developer IDENTIFIED BY dbdeveloper_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER db_developer PROFILE db_developer_profile;

-- Cấp quota cho db_developer
ALTER USER db_developer QUOTA 200M ON tb_internal;

-- Tạo user backend_developer và gán profile
CREATE USER backend_developer IDENTIFIED BY backenddeveloper_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER backend_developer PROFILE backend_developer_profile;

-- Cấp quota cho backend_developer
ALTER USER backend_developer QUOTA 200M ON tb_internal;

-- Tạo user data_engineer và gán profile
CREATE USER data_engineer IDENTIFIED BY dataengineer_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER data_engineer PROFILE data_engineer_profile;

-- Cấp quota cho data_engineer
ALTER USER data_engineer QUOTA 500M ON tb_internal;

-- Tạo user data_analyst và gán profile
CREATE USER data_analyst IDENTIFIED BY dataanalyst_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER data_analyst PROFILE data_analyst_profile;

-- Cấp quota cho data_analyst
ALTER USER data_analyst QUOTA 300M ON tb_internal;

-- Tạo user supervisor_user và gán profile
CREATE USER supervisor_user IDENTIFIED BY supervisor_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER supervisor_user PROFILE supervisor_profile;

-- Cấp quota cho supervisor_user
ALTER USER supervisor_user QUOTA 100M ON tb_internal;

-- Tạo user end_user và gán profile
CREATE USER end_user IDENTIFIED BY enduser_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER end_user PROFILE end_user_profile;

-- Cấp quota cho end_user
ALTER USER end_user QUOTA 50M ON tb_internal;



-- ROLE CREATION

-- 1. Quan tri vien co so du lieu (DB Admin)
-- Nhiem vu: Quan ly cac co so du lieu, bao gom bao tri va thay doi cau truc.
-- Tao vai tro Quan tri vien co so du lieu
CREATE ROLE DBAdmin;

-- Trao quyen ket noi
GRANT CREATE SESSION TO DBAdmin;

-- Trao quyen quan ly DB
GRANT DBA TO DBAdmin;

-- Cac quyen lien quan den sao luu/phuc hoi (Can dung quyen SYSDBA)
GRANT SYSBACKUP TO db_admin;

-- DBA da bao gom:
-- Quyen ket noi va quan ly phien
-- Cac quyen lien quan den bang
-- Cac quyen lien quan den thu tuc
-- Cac quyen lien quan den index
-- Cac quyen lien quan den tablespace

-- 2. Nha phat trien co so du lieu (Database Developer)
-- Nhiem vu: Xay dung, phat trien va thu nghiem cac chuc nang moi trong co so du lieu.
-- Tao vai tro Nha phat trien co so du lieu
CREATE ROLE DatabaseDeveloper;

-- Quyen dang nhap
GRANT CREATE SESSION TO DatabaseDeveloper;
GRANT CREATE SEQUENCE TO DatabaseDeveloper;

-- Quan ly cac bang
GRANT CREATE TABLE TO DatabaseDeveloper; -- Tao bang moi
GRANT SELECT ANY TABLE TO DatabaseDeveloper; -- Doc du lieu tu moi bang trong co so du lieu
GRANT INSERT ANY TABLE TO DatabaseDeveloper; -- Chen du lieu vao moi bang
GRANT UPDATE ANY TABLE TO DatabaseDeveloper; -- Cap nhat du lieu trong moi bang
GRANT DELETE ANY TABLE TO DatabaseDeveloper; -- Xoa du lieu tu moi bang

-- Quan ly thu tuc
GRANT CREATE PROCEDURE TO DatabaseDeveloper; -- Tao thu tuc
GRANT EXECUTE ANY PROCEDURE TO DatabaseDeveloper; -- Thuc thi moi thu tuc trong co so du lieu
GRANT ALTER ANY PROCEDURE TO DatabaseDeveloper; -- Thay doi moi thu tuc trong co so du lieu

-- Quan ly trigger
GRANT CREATE TRIGGER TO DatabaseDeveloper; -- Tao trigger
GRANT ALTER ANY TRIGGER TO DatabaseDeveloper; -- Thay doi moi trigger trong co so du lieu


-- Trao quyen tren mot so view chi dinh
--GRANT SELECT ON view_name TO BackendDeveloper;

---- Cap quyen INSERT cho tat ca cac view trong schema
--GRANT INSERT ON view_name TO DatabaseDeveloper;
-- 
---- Cap quyen UPDATE cho tat ca cac view trong schema
--GRANT UPDATE ON view_name TO DatabaseDeveloper;
-- 3. Nha phat trien ung dung (Back-end Developer)
-- Nhiem vu: Xay dung va bao tri cac chuc nang phia back-end cua he thong, bao gom tao, sua doi va thuc thi cac thu tuc, trigger; xu ly du lieu trong cac bang chinh.
CREATE ROLE BackendDeveloper;

-- Cap quyen dang nhap
GRANT CREATE SESSION TO BackendDeveloper;

-- Cap quyen thao tac thu tuc
GRANT CREATE PROCEDURE TO BackendDeveloper; -- Cap quyen tao thu tuc
GRANT ALTER ANY PROCEDURE TO BackendDeveloper; -- Cap quyen thay doi bat ky thu tuc nao
GRANT EXECUTE ANY PROCEDURE TO BackendDeveloper; -- Cap quyen thuc thi thu tuc trong tat ca cac schema
GRANT CREATE SEQUENCE TO BackendDeveloper;

-- Cap quyen thao tac trigger
GRANT CREATE TRIGGER TO BackendDeveloper; -- Cap quyen tao trigger
GRANT ALTER ANY TRIGGER TO BackendDeveloper; -- Cap quyen thay doi bat ky trigger nao trong he thong

-- Cap quyen thao tac tren cac bang chinh (CAN TAO BANG TRUOC KHI CHAY)
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.BaiDang TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.PhongNhanTin TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.BaoCao TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoanQuangCao TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.ChienDich TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.MucTieu TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.QuangCao TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Dang_BaiDang TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_TuongTac_BaiDang TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_BinhLuan_BaiDang TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_QuanLy_BaiDang TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Lap_HoiNhom TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_ThamGia_HoiNhom TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Lap_PhongNhanTin TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_NhanTin_PhongNhanTin TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_NapTien_TaiKhoan TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Lap_TaiKhoanQuangCao TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoanQuangCao_DangKy_ChienDich TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.ChienDich_Co_MucTieu TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.ChienDich_Co_QuangCao TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.BaiDang_Thuoc_HoiNhom TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Gui_BaoCao TO BackendDeveloper;

-- 4. Ky su du lieu (Data Engineer)
-- Nhiem vu: Thiet ke, xay dung, va duy tri co so du lieu; xu ly du lieu tu nhieu nguon.
CREATE ROLE DataEngineer;

-- Cap quyen dang nhap
GRANT CREATE SESSION TO DataEngineer;

-- Cap quyen thao tac cau truc co so du lieu
GRANT CREATE TABLE TO DataEngineer; -- Tao bang moi
GRANT SELECT ANY TABLE TO DataEngineer;
GRANT INSERT ANY TABLE TO DataEngineer; -- Chen du lieu vao moi bang
GRANT UPDATE ANY TABLE TO DataEngineer; -- Cap nhat du lieu trong moi bang
GRANT DELETE ANY TABLE TO DataEngineer; -- Xoa du lieu tu moi bang
GRANT ALTER ANY TABLE TO DataEngineer;
GRANT CREATE SEQUENCE TO DataEngineer;
GRANT CREATE VIEW TO DataEngineer;

-- Cap quyen thao tac voi thu tuc va chi muc
GRANT CREATE PROCEDURE TO DataEngineer;

-- Trao quyen tao va huy index (can sysdba trao quyen)
GRANT CREATE ANY INDEX, DROP ANY INDEX TO DataEngineer;

-- Cap quyen truy cap bang he thong (can SYSDBA trao quyen va chi dinh cu the)
GRANT SELECT ON DBA_TABLES TO DataEngineer;
GRANT SELECT ON DBA_TAB_COLUMNS TO DataEngineer;
GRANT SELECT ON DBA_INDEXES TO DataEngineer;

-- Trao quyen exec proc, func, package (can chi dinh)
--GRANT EXECUTE ON <FUNCTION_NAME> TO <USER>;

-- Cap quyen thuc thi thu tuc toi uu hoa (Can SYSDBA trao quyen chi dinh cu the)
GRANT EXECUTE ON DBMS_STATS TO DataEngineer;

-- Cap quyen tao View
GRANT CREATE VIEW TO DataEngineer; 
--GRANT ALTER ON schema_name.view_name TO DataAnalyst;

-- 5. Nha phan tich du lieu (Data Analyst)
-- Nhiem vu: Phan tich va truc quan hoa du lieu, tao view de ho tro bao cao.
CREATE ROLE DataAnalyst;

-- Cho phep dang nhap vao co so du lieu
GRANT CREATE SESSION TO DataAnalyst; 

-- Cho phep doc du lieu
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.BaiDang TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.PhongNhanTin TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.BaoCao TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoanQuangCao TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.ChienDich TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.MucTieu TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.QuangCao TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Dang_BaiDang TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_TuongTac_BaiDang TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_BinhLuan_BaiDang TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_QuanLy_BaiDang TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Lap_HoiNhom TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_ThamGia_HoiNhom TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Lap_PhongNhanTin TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_NhanTin_PhongNhanTin TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_NapTien_TaiKhoan TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Lap_TaiKhoanQuangCao TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoanQuangCao_DangKy_ChienDich TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.ChienDich_Co_MucTieu TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.ChienDich_Co_QuangCao TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.BaiDang_Thuoc_HoiNhom TO DataAnalyst;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Gui_BaoCao TO DataAnalyst;

-- Cho phep tao view
GRANT CREATE VIEW TO DataAnalyst; 
--GRANT ALTER ON schema_name.view_name TO DataAnalyst;

-- 6. Giam sat vien (Supervisor)
-- Nhiem vu: Theo doi hoat dong chung cua he thong, khong thuc hien cac thay doi lon.
-- Tao vai tro Giam sat vien
CREATE ROLE Supervisor;

-- Cac quyen co ban
GRANT CREATE SESSION TO Supervisor;
GRANT RESTRICTED SESSION TO Supervisor;

-- Quyen truy cap
GRANT SELECT ANY TABLE TO Supervisor;

-- Quyen phan tich
GRANT ANALYZE ANY TO Supervisor;

-- 7. Nguoi dung (End-User)
-- Nhiem vu: Su dung cac tinh nang co ban cua he thong nhu xem va tuong tac voi du lieu.
CREATE ROLE EndUser;

GRANT CREATE SESSION TO EndUser; -- Cho phep dang nhap vao co so du lieu

GRANT CREATE SEQUENCE TO EndUser;

GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.BaiDang TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.PhongNhanTin TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.BaoCao TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoanQuangCao TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.ChienDich TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.MucTieu TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.QuangCao TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Dang_BaiDang TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_TuongTac_BaiDang TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_BinhLuan_BaiDang TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_QuanLy_BaiDang TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Lap_HoiNhom TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_ThamGia_HoiNhom TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Lap_PhongNhanTin TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_NhanTin_PhongNhanTin TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_NapTien_TaiKhoan TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Lap_TaiKhoanQuangCao TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoanQuangCao_DangKy_ChienDich TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.ChienDich_Co_MucTieu TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.ChienDich_Co_QuangCao TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.BaiDang_Thuoc_HoiNhom TO EndUser;
GRANT SELECT, INSERT, UPDATE ON db_admin.TaiKhoan_Gui_BaoCao TO EndUser;


-- Gan cac vai tro cho nguoi dung tuong ung
GRANT Supervisor TO supervisor_user;
GRANT DBAdmin TO db_admin;
GRANT DatabaseDeveloper TO db_developer;
GRANT BackendDeveloper TO backend_developer;
GRANT DataEngineer TO data_engineer;
GRANT DataAnalyst TO data_analyst;
GRANT EndUser TO end_user;