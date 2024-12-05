-- USER CREATION
-- Tạo các user với tablespace và profile

-- Tạo và gán profile cho DB Admin
CREATE USER db_admin IDENTIFIED BY dbadmin_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;
PROFILE C##db_admin_profile;

-- Tạo và gán profile cho Database Developer
CREATE USER db_developer IDENTIFIED BY dbdeveloper_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;
PROFILE C##db_developer_profile;

-- Tạo và gán profile cho Back-end Developer
CREATE USER backend_developer IDENTIFIED BY backenddeveloper_password
DEFAULT TABLESPACE tb_user_data 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE C##backend_developer_profile;

-- Tạo và gán profile cho Data Engineer
CREATE USER data_engineer IDENTIFIED BY dataengineer_password
DEFAULT TABLESPACE tb_user_data
TEMPORARY TABLESPACE tb_user_temp;
PROFILE C##data_engineer_profile;

-- Tạo và gán profile cho Data Analyst
CREATE USER data_analyst IDENTIFIED BY dataanalyst_password
DEFAULT TABLESPACE tb_user_data 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE C##data_analyst_profile;

-- Tạo và gán profile cho Supervisor
CREATE USER supervisor_user IDENTIFIED BY supervisor_password
DEFAULT TABLESPACE tb_internal 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE C##supervisor_profile;

-- Tạo và gán profile cho End User
CREATE USER end_user IDENTIFIED BY enduser_password
DEFAULT TABLESPACE tb_user_data 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE C##end_user_profile;


-- ROLE CREATION

-- 1. Quản trị viên cơ sở dữ liệu (DB Admin)
-- Nhiệm vụ: Quản lý các cơ sở dữ liệu, bao gồm bảo trì và thay đổi cấu trúc.
-- Tạo vai trò Quản trị viên cơ sở dữ liệu
CREATE ROLE DBAdmin;
GRANT DBA TO DBAdmin;
-- DBA đã bao gồm:
-- Quyền kết nối và quản lý phiên
-- Các quyền liên quan đến bảng
-- Các quyền liên quan đến thủ tục
-- Các quyền liên quan đến index
-- Các quyền liên quan đến tablespace

-- Các quyền liên quan đến sao lưu/phục hồi
GRANT BACKUP ANY TABLE TO DBAdmin;
GRANT FLASHBACK ANY TABLE TO DBAdmin;

-- 2. Nhà phát triển cơ sở dữ liệu (Database Developer)
-- Nhiệm vụ: Xây dựng, phát triển và thử nghiệm các chức năng mới trong cơ sở dữ liệu.
-- Tạo vai trò Nhà phát triển cơ sở dữ liệu
CREATE ROLE DatabaseDeveloper;

-- Quyền đăng nhập
GRANT CREATE SESSION TO BackendDeveloper;
-- Quản lý các bảng
GRANT CREATE TABLE TO DatabaseDeveloper;   -- Tạo bảng mới
GRANT INSERT ANY TABLE TO DatabaseDeveloper;  -- Chèn dữ liệu vào mọi bảng
GRANT UPDATE ANY TABLE TO DatabaseDeveloper;  -- Cập nhật dữ liệu trong mọi bảng
GRANT DELETE ANY TABLE TO DatabaseDeveloper;  -- Xóa dữ liệu từ mọi bảng

-- Quản lý thủ tục
GRANT CREATE PROCEDURE TO DatabaseDeveloper; -- Tạo thủ tục
GRANT EXECUTE ANY PROCEDURE TO DatabaseDeveloper; -- Thực thi mọi thủ tục trong cơ sở dữ liệu
GRANT ALTER ANY PROCEDURE TO DatabaseDeveloper;  -- Thay đổi mọi thủ tục trong cơ sở dữ liệu

-- Quản lý trigger
GRANT CREATE TRIGGER TO DatabaseDeveloper;  -- Tạo trigger
GRANT ALTER ANY TRIGGER TO DatabaseDeveloper; -- Thay đổi mọi trigger trong cơ sở dữ liệu

-- Quản lý views
GRANT INSERT ANY VIEW TO DatabaseDeveloper;  -- Chèn dữ liệu vào mọi view
GRANT UPDATE ANY VIEW TO DatabaseDeveloper;  -- Cập nhật dữ liệu vào mọi view

-- Cấp quyền truy cập vào các đối tượng khác nếu cần
GRANT SELECT ANY TABLE TO DatabaseDeveloper;  -- Đọc dữ liệu từ mọi bảng trong cơ sở dữ liệu

-- 3. Nhà phát triển ứng dụng (Back-end Developer)
-- Nhiệm vụ: Xây dựng và bảo trì các chức năng phía back-end của hệ thống, bao gồm tạo, sửa đổi và thực thi các thủ tục, trigger; xử lý dữ liệu trong các bảng chính.
CREATE ROLE BackendDeveloper;

-- Cấp quyền đăng nhập
GRANT CREATE SESSION TO BackendDeveloper;

-- Cấp quyền thao tác thủ tục
GRANT CREATE PROCEDURE, ALTER PROCEDURE, EXECUTE ANY PROCEDURE TO BackendDeveloper;

-- Cấp quyền thao tác trigger
GRANT CREATE TRIGGER, ALTER TRIGGER TO BackendDeveloper;

-- Cấp quyền thao tác trên các bảng chính
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoan TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON BaiDang TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON PhongNhanTin TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON BaoCao TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoanQuangCao TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChienDich TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON MucTieu TO BackendDeveloper;
GRANT SELECT, INSERT, UPDATE, DELETE ON QuangCao TO BackendDeveloper;

-- 4. Kỹ sư dữ liệu (Data Engineer)
-- Nhiệm vụ: Thiết kế, xây dựng, và duy trì cơ sở dữ liệu; xử lý dữ liệu từ nhiều nguồn.
CREATE ROLE DataEngineer;

-- Cấp quyền đăng nhập
GRANT CREATE SESSION TO DataEngineer;

-- Cấp quyền thao tác trên dữ liệu
GRANT SELECT ANY TABLE TO DataEngineer;
GRANT INSERT, UPDATE, DELETE ANY TABLE TO DataEngineer;

-- Cấp quyền thao tác cấu trúc cơ sở dữ liệu
GRANT CREATE TABLE TO DataEngineer;
GRANT ALTER ANY TABLE TO DataEngineer;
GRANT CREATE SEQUENCE TO DataEngineer;
GRANT CREATE VIEW TO DataEngineer;

-- Cấp quyền truy cập bảng hệ thống
GRANT SELECT ON DBA_TABLES TO DataEngineer;
GRANT SELECT ON DBA_TAB_COLUMNS TO DataEngineer;
GRANT SELECT ON DBA_INDEXES TO DataEngineer;

-- Cấp quyền thao tác với thủ tục và chỉ mục
GRANT CREATE PROCEDURE TO DataEngineer;
GRANT CREATE FUNCTION TO DataEngineer;
GRANT CREATE INDEX, DROP INDEX TO DataEngineer;

-- Cấp quyền thực thi thủ tục tối ưu hóa
GRANT EXECUTE ON DBMS_STATS TO DataEngineer;


-- 5. Nhà phân tích dữ liệu (Data Analyst)
-- Nhiệm vụ: Phân tích và trực quan hóa dữ liệu, tạo view để hỗ trợ báo cáo.
CREATE ROLE DataAnalyst;

-- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT CREATE SESSION TO DataAnalyst; 

-- Cho phép đọc dữ liệu từ tất cả các bảng
GRANT SELECT ANY TABLE TO DataAnalyst;

-- Cho phép tạo view
GRANT CREATE VIEW TO DataAnalyst; 

-- 6. Giám sát viên (Supervisor)
-- Nhiệm vụ: Theo dõi hoạt động chung của hệ thống, không thực hiện các thay đổi lớn.
-- Tạo vai trò Giám sát viên
CREATE ROLE Supervisor;

-- Các quyền cơ bản
GRANT CREATE SESSION TO Supervisor;
GRANT RESTRICTED SESSION TO Supervisor;

-- Quyền truy cập
GRANT SELECT ANY TABLE TO Supervisor;

-- Quyền phân tích
GRANT ANALYZE ANY TO Supervisor;

-- Quyền theo dõi phiên
GRANT MONITOR SESSION TO Supervisor;


-- 7. Người dùng (End-User)
-- Nhiệm vụ: Sử dụng các tính năng cơ bản của hệ thống như xem và tương tác với dữ liệu.
CREATE ROLE EndUser;
GRANT CONNECT TO EndUser;

GRANT CREATE SESSION TO EndUser; -- Cho phép đăng nhập vào cơ sở dữ liệu

-- Cấp quyền xem và thêm dữ liệu trên các bảng
GRANT SELECT, INSERT, UPDATE ON TaiKhoan TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng TaiKhoan
GRANT SELECT, INSERT, UPDATE ON BaiDang TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng BaiDang
GRANT SELECT, INSERT, UPDATE ON PhongNhanTin TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng PhongNhanTin
GRANT SELECT, INSERT, UPDATE ON BaoCao TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng BaoCao
GRANT SELECT, INSERT, UPDATE ON TaiKhoanQuangCao TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng TaiKhoanQuangCao
GRANT SELECT, INSERT, UPDATE ON ChienDich TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng ChienDich
GRANT SELECT, INSERT, UPDATE ON MucTieu TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng MucTieu
GRANT SELECT, INSERT, UPDATE ON QuangCao TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng QuangCao


-- Gán các vai trò cho người dùng tương ứng
GRANT Supervisor TO supervisor_user;
GRANT DBAdmin TO db_admin;
GRANT DatabaseDeveloper TO db_developer;
GRANT BackendDeveloper TO backend_developer;
GRANT DataEngineer TO data_engineer;
GRANT DataAnalyst TO data_analyst;
GRANT EndUser TO end_user;