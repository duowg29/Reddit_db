-- USER CREATION

-- Liet ke cac PDB hien tai (neu khogn tao duoc user thi kiem tra xem minh dang ket noi toi PDB nao)
SELECT name, open_mode, con_id
FROM v$pdbs;
SELECT * FROM DBA_PDBS;

-- Chuyen ket noi sang PDB REDDITDBPDB1
ALTER SESSION SET CONTAINER = REDDITDBPDB1;

-- Tạo và gán profile cho DB Admin
CREATE USER db_admin IDENTIFIED BY dbadmin_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER db_admin PROFILE db_admin_profile;

-- Tạo và gán profile cho Database Developer
CREATE USER db_developer IDENTIFIED BY dbdeveloper_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER db_developer PROFILE db_developer_profile;

-- Tạo và gán profile cho Back-end Developer
CREATE USER backend_developer IDENTIFIED BY backenddeveloper_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER backend_developer PROFILE backend_developer_profile;

-- Tạo và gán profile cho Data Engineer
CREATE USER data_engineer IDENTIFIED BY dataengineer_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER data_engineer PROFILE data_engineer_profile;

-- Tạo và gán profile cho Data Analyst
CREATE USER data_analyst IDENTIFIED BY dataanalyst_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER data_analyst PROFILE data_analyst_profile;

-- Tạo và gán profile cho Supervisor
CREATE USER supervisor_user IDENTIFIED BY supervisor_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER supervisor_user PROFILE supervisor_profile;

-- Tạo và gán profile cho End User
CREATE USER end_user IDENTIFIED BY enduser_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;

ALTER USER end_user PROFILE end_user_profile;




-- ROLE CREATION

-- 1. Quản trị viên cơ sở dữ liệu (DB Admin)
-- Nhiệm vụ: Quản lý các cơ sở dữ liệu, bao gồm bảo trì và thay đổi cấu trúc.
-- Tạo vai trò Quản trị viên cơ sở dữ liệu
CREATE ROLE DBAdmin;
GRANT DBA TO DBAdmin;

-- Trao quyen ket noi
GRANT CREATE SESSION TO DBAdmin;
-- DBA đã bao gồm:
-- Quy�?n kết nối và quản lý phiên
-- Các quy�?n liên quan đến bảng
-- Các quy�?n liên quan đến thủ tục
-- Các quy�?n liên quan đến index
-- Các quy�?n liên quan đến tablespace

-- Các quy�?n liên quan đến sao lưu/phục hồi
GRANT BACKUP ANY TABLE TO DBAdmin;
GRANT FLASHBACK ANY TABLE TO DBAdmin;

-- 2. Nhà phát triển cơ sở dữ liệu (Database Developer)
-- Nhiệm vụ: Xây dựng, phát triển và thử nghiệm các chức năng mới trong cơ sở dữ liệu.
-- Tạo vai trò Nhà phát triển cơ sở dữ liệu
CREATE ROLE DatabaseDeveloper;

-- Quy�?n đăng nhập
GRANT CREATE SESSION TO DatabaseDeveloper;

-- Trao quyen tren mot so view chi dinh
--GRANT SELECT ON view_name TO BackendDeveloper;

---- C?p quy?n INSERT cho t?t c? c�c view trong schema
--GRANT INSERT ON view_name TO DatabaseDeveloper;
--
---- C?p quy?n UPDATE cho t?t c? c�c view trong schema
--GRANT UPDATE ON view_name TO DatabaseDeveloper;


-- Quản lý các bảng
GRANT CREATE TABLE TO DatabaseDeveloper;   -- Tạo bảng mới
GRANT INSERT ANY TABLE TO DatabaseDeveloper;  -- Chèn dữ liệu vào m�?i bảng
GRANT UPDATE ANY TABLE TO DatabaseDeveloper;  -- Cập nhật dữ liệu trong m�?i bảng
GRANT DELETE ANY TABLE TO DatabaseDeveloper;  -- Xóa dữ liệu từ m�?i bảng

-- Quản lý thủ tục
GRANT CREATE PROCEDURE TO DatabaseDeveloper; -- Tạo thủ tục
GRANT EXECUTE ANY PROCEDURE TO DatabaseDeveloper; -- Thực thi m�?i thủ tục trong cơ sở dữ liệu
GRANT ALTER ANY PROCEDURE TO DatabaseDeveloper;  -- Thay đổi m�?i thủ tục trong cơ sở dữ liệu

-- Quản lý trigger
GRANT CREATE TRIGGER TO DatabaseDeveloper;  -- Tạo trigger
GRANT ALTER ANY TRIGGER TO DatabaseDeveloper; -- Thay đổi m�?i trigger trong cơ sở dữ liệu

-- Cấp quy�?n truy cập vào các đối tượng khác nếu cần
GRANT SELECT ANY TABLE TO DatabaseDeveloper;  -- �?�?c dữ liệu từ m�?i bảng trong cơ sở dữ liệu

-- 3. Nhà phát triển ứng dụng (Back-end Developer)
-- Nhiệm vụ: Xây dựng và bảo trì các chức năng phía back-end của hệ thống, bao gồm tạo, sửa đổi và thực thi các thủ tục, trigger; xử lý dữ liệu trong các bảng chính.
CREATE ROLE BackendDeveloper;

-- Cấp quy�?n đăng nhập
GRANT CREATE SESSION TO BackendDeveloper;

-- Cấp quy�?n thao tác thủ tục
GRANT CREATE PROCEDURE TO BackendDeveloper;  -- C?p quy?n t?o th? t?c
GRANT ALTER ANY PROCEDURE TO BackendDeveloper;  -- C?p quy?n thay ??i b?t k? th? t?c n�o
GRANT EXECUTE ANY PROCEDURE TO BackendDeveloper;  -- C?p quy?n th?c thi th? t?c trong t?t c? c�c schema

-- Cấp quy�?n thao tác trigger
GRANT CREATE TRIGGER TO BackendDeveloper;  -- C?p quy?n t?o trigger
GRANT ALTER ANY TRIGGER TO BackendDeveloper;  -- C?p quy?n thay ??i b?t k? trigger n�o trong h? th?ng

-- Cấp quy�?n thao tác trên các bảng chính (CAN TAO BANG TRUOC KHI CHAY)
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoan TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON BaiDang TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON PhongNhanTin TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON BaoCao TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoanQuangCao TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChienDich TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON MucTieu TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON QuangCao TO BackendDeveloper;

-- 4. Kỹ sư dữ liệu (Data Engineer)
-- Nhiệm vụ: Thiết kế, xây dựng, và duy trì cơ sở dữ liệu; xử lý dữ liệu từ nhi�?u nguồn.
CREATE ROLE DataEngineer;

-- Cấp quy�?n đăng nhập
GRANT CREATE SESSION TO DataEngineer;

-- Cấp quy�?n thao tác trên dữ liệu (Can tao bang truoc)
GRANT SELECT ANY TABLE TO DataEngineer;
GRANT INSERT, UPDATE, DELETE ON TaiKhoan TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON BaiDang TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON PhongNhanTin TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON BaoCao TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON TaiKhoanQuangCao TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON ChienDich TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON MucTieu TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON QuangCao TO BackendDeveloper;

-- Cấp quy�?n thao tác cấu trúc cơ sở dữ liệu
GRANT CREATE TABLE TO DataEngineer;
GRANT ALTER ANY TABLE TO DataEngineer;
GRANT CREATE SEQUENCE TO DataEngineer;
GRANT CREATE VIEW TO DataEngineer;

-- Cấp quy�?n truy cập bảng hệ thống (can DBA trao quyen)
GRANT SELECT ON DBA_TABLES TO DataEngineer;
GRANT SELECT ON DBA_TAB_COLUMNS TO DataEngineer;
GRANT SELECT ON DBA_INDEXES TO DataEngineer;

-- Cấp quy�?n thao tác với thủ tục và chỉ mục
GRANT CREATE PROCEDURE TO DataEngineer;

-- Trao quyen exec proc, func, package (can chi dinh)
--GRANT EXECUTE ON <FUNCTION_NAME> TO <USER>;

-- Trao quyen tao va huy index (can dba trao quyen)
GRANT CREATE ANY INDEX, DROP ANY INDEX TO DataEngineer;


-- Cấp quy�?n thực thi thủ tục tối ưu hóa (Can DBA trao quyen)
GRANT EXECUTE ON DBMS_STATS TO DataEngineer;


-- 5. Nhà phân tích dữ liệu (Data Analyst)
-- Nhiệm vụ: Phân tích và trực quan hóa dữ liệu, tạo view để hỗ trợ báo cáo.
CREATE ROLE DataAnalyst;

-- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT CREATE SESSION TO DataAnalyst; 

-- Cho phép đ�?c dữ liệu từ tất cả các bảng
GRANT SELECT ANY TABLE TO DataAnalyst;

-- Cho phép tạo view
GRANT CREATE VIEW TO DataAnalyst; 

-- 6. Giám sát viên (Supervisor)
-- Nhiệm vụ: Theo dõi hoạt động chung của hệ thống, không thực hiện các thay đổi lớn.
-- Tạo vai trò Giám sát viên
CREATE ROLE Supervisor;

-- Các quy�?n cơ bản
GRANT CREATE SESSION TO Supervisor;
GRANT RESTRICTED SESSION TO Supervisor;

-- Quy�?n truy cập
GRANT SELECT ANY TABLE TO Supervisor;

-- Quy�?n phân tích
GRANT ANALYZE ANY TO Supervisor;

-- 7. Ngư�?i dùng (End-User)
-- Nhiệm vụ: Sử dụng các tính năng cơ bản của hệ thống như xem và tương tác với dữ liệu.
CREATE ROLE EndUser;
GRANT CONNECT TO EndUser;

GRANT CREATE SESSION TO EndUser; -- Cho phép đăng nhập vào cơ sở dữ liệu

-- Cấp quy�?n xem và thêm dữ liệu trên các bảng
GRANT SELECT, INSERT, UPDATE ON TaiKhoan TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng TaiKhoan
GRANT SELECT, INSERT, UPDATE ON BaiDang TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng BaiDang
GRANT SELECT, INSERT, UPDATE ON PhongNhanTin TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng PhongNhanTin
GRANT SELECT, INSERT, UPDATE ON BaoCao TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng BaoCao
GRANT SELECT, INSERT, UPDATE ON TaiKhoanQuangCao TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng TaiKhoanQuangCao
GRANT SELECT, INSERT, UPDATE ON ChienDich TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng ChienDich
GRANT SELECT, INSERT, UPDATE ON MucTieu TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng MucTieu
GRANT SELECT, INSERT, UPDATE ON QuangCao TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng QuangCao


-- Gán các vai trò cho ngư�?i dùng tương ứng
GRANT Supervisor TO supervisor_user;
GRANT DBAdmin TO db_admin;
GRANT DatabaseDeveloper TO db_developer;
GRANT BackendDeveloper TO backend_developer;
GRANT DataEngineer TO data_engineer;
GRANT DataAnalyst TO data_analyst;
GRANT EndUser TO end_user;