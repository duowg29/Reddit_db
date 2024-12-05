-- USER CREATION
-- Tạo các user với tablespace và profile

-- Tạo và gán profile cho DB Admin
CREATE USER db_admin IDENTIFIED BY dbadmin_password
DEFAULT TABLESPACE tb_internal
TEMPORARY TABLESPACE tb_user_temp;
PROFILE db_admin_profile;

-- Tạo và gán profile cho Database Developer
CREATE USER db_developer IDENTIFIED BY dbdeveloper_password
DEFAULT TABLESPACE tb_user_data 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE db_developer_profile;

-- Tạo và gán profile cho Database Security Specialist
CREATE USER db_security IDENTIFIED BY dbsecurity_password
DEFAULT TABLESPACE tb_internal 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE db_security_profile;

-- Tạo và gán profile cho Database Performance Tuner
CREATE USER performance_tuner IDENTIFIED BY performancetuner_password
DEFAULT TABLESPACE tb_index 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE performance_tuner_profile;

-- Tạo và gán profile cho Back-end Developer
CREATE USER backend_developer IDENTIFIED BY backenddeveloper_password
DEFAULT TABLESPACE tb_user_data 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE backend_developer_profile;

-- Tạo và gán profile cho Data Engineer
CREATE USER data_engineer IDENTIFIED BY dataengineer_password
DEFAULT TABLESPACE tb_user_data 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE data_engineer_profile;

-- Tạo và gán profile cho Data Analyst
CREATE USER data_analyst IDENTIFIED BY dataanalyst_password
DEFAULT TABLESPACE tb_user_data 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE data_analyst_profile;

-- Tạo và gán profile cho Supervisor
CREATE USER supervisor_user IDENTIFIED BY supervisor_password
DEFAULT TABLESPACE tb_internal 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE supervisor_profile;

-- Tạo và gán profile cho Moderator
CREATE USER moderator_user IDENTIFIED BY moderator_password
DEFAULT TABLESPACE tb_user_data 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE moderator_profile;

-- Tạo và gán profile cho End User
CREATE USER end_user IDENTIFIED BY enduser_password
DEFAULT TABLESPACE tb_user_data 
TEMPORARY TABLESPACE tb_user_temp;
PROFILE end_user_profile;


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

-- 3. Chuyên viên bảo mật cơ sở dữ liệu (Database Security Specialist)
-- Nhiệm vụ: Quản lý bảo mật và phân quyền truy cập.
-- Tạo vai trò Chuyên viên bảo mật cơ sở dữ liệu
CREATE ROLE DatabaseSecuritySpecialist;

-- Quyền đăng nhập
GRANT CREATE SESSION TO BackendDeveloper;
-- Quản lý tài khoản người dùng
GRANT CREATE USER TO DatabaseSecuritySpecialist;  -- Cho phép tạo người dùng mới
GRANT ALTER USER TO DatabaseSecuritySpecialist;   -- Cho phép thay đổi thuộc tính của người dùng

-- Quản lý bảo mật và giám sát
GRANT SELECT ANY TABLE TO DatabaseSecuritySpecialist;  -- Đọc dữ liệu từ mọi bảng (dành cho kiểm tra bảo mật)
GRANT AUDIT SYSTEM TO DatabaseSecuritySpecialist;      -- Giám sát các sự kiện và hành vi hệ thống
GRANT AUDIT ANY TO DatabaseSecuritySpecialist;        -- Giám sát các sự kiện trên các đối tượng trong cơ sở dữ liệu

-- Quản lý phân tích và giám sát dữ liệu
GRANT ANALYZE ANY TO DatabaseSecuritySpecialist;  -- Phân tích dữ liệu và cấu trúc bảng
GRANT SELECT ANY DICTIONARY TO DatabaseSecuritySpecialist;  -- Đọc thông tin từ các từ điển hệ thống (cho kiểm tra bảo mật)

-- Cấp quyền truy cập cao vào các đối tượng hệ thống
GRANT SELECT ON dba_users TO DatabaseSecuritySpecialist;  -- Truy cập vào thông tin người dùng trong cơ sở dữ liệu
GRANT SELECT ON dba_roles TO DatabaseSecuritySpecialist;  -- Truy cập vào thông tin về vai trò của người dùng

-- Cấp quyền giám sát hệ thống
GRANT MONITOR SESSION TO DatabaseSecuritySpecialist;  -- Giám sát phiên làm việc của người dùng
GRANT ALTER SESSION TO DatabaseSecuritySpecialist;    -- Thay đổi các cài đặt của phiên làm việc

-- 4. Chuyên viên tối ưu hóa hiệu suất (Database Performance Tuner)
-- Nhiệm vụ: Tối ưu hóa truy vấn và hiệu suất cơ sở dữ liệu.
-- Tạo vai trò Chuyên viên tối ưu hóa hiệu suất
CREATE ROLE PerformanceTuner;

-- Quyền đăng nhập
GRANT CREATE SESSION TO BackendDeveloper;

-- Quản lý truy vấn và chỉ mục
GRANT SELECT ANY TABLE TO PerformanceTuner;                      -- Cho phép truy vấn bất kỳ bảng nào để phân tích dữ liệu
GRANT SELECT ON ANY VIEW TO PerformanceTuner;                     -- Cho phép truy vấn bất kỳ view nào để phân tích dữ liệu
GRANT CREATE INDEX TO PerformanceTuner;                           -- Cấp quyền tạo chỉ mục để tối ưu hóa truy vấn
GRANT ALTER INDEX TO PerformanceTuner;                            -- Cấp quyền thay đổi chỉ mục để điều chỉnh và tối ưu hóa chúng
GRANT DROP INDEX TO PerformanceTuner;                             -- Cấp quyền xóa chỉ mục khi không cần thiết nữa

-- Quản lý phiên làm việc và tối ưu hóa truy vấn
GRANT ALTER SESSION TO PerformanceTuner;                         -- Cho phép thay đổi các tham số phiên làm việc để tối ưu hóa
GRANT FORCE TRANSACTION TO PerformanceTuner;                      -- Cho phép ép buộc một giao dịch, có thể giúp giải quyết các vấn đề tắc nghẽn

-- Phân tích và tối ưu hóa cơ sở dữ liệu
GRANT ANALYZE ANY TO PerformanceTuner;                           -- Cấp quyền phân tích bất kỳ đối tượng nào trong cơ sở dữ liệu
GRANT MONITOR ANY TO PerformanceTuner;                           -- Cấp quyền giám sát và theo dõi hiệu suất cơ sở dữ liệu
GRANT EXECUTE ON DBMS_STATS TO PerformanceTuner;                 -- Cho phép thực thi gói DBMS_STATS để thu thập thống kê và tối ưu hóa cơ sở dữ liệu

-- Quản lý hiệu suất truy vấn
GRANT EXECUTE ON DBMS_SQL TO PerformanceTuner;                   -- Cấp quyền thực thi các thủ tục trong gói DBMS_SQL để phân tích và tối ưu hóa truy vấn
GRANT EXECUTE ON DBMS_SESSION TO PerformanceTuner;               -- Cho phép sử dụng các thủ tục của gói DBMS_SESSION để theo dõi và điều chỉnh phiên làm việc
GRANT EXECUTE ON DBMS_MONITOR TO PerformanceTuner;               -- Cấp quyền thực thi các thủ tục trong gói DBMS_MONITOR để theo dõi và tối ưu hóa hiệu suất

-- Quản lý tài nguyên và tham số
GRANT SELECT ON V_$PARAMETER TO PerformanceTuner;                -- Cấp quyền truy vấn các tham số hệ thống để tối ưu hóa

-- Giám sát và đánh giá hiệu suất
GRANT SELECT ON V_$SESSION TO PerformanceTuner;                  -- Truy vấn thông tin về các phiên làm việc để đánh giá hiệu suất
GRANT SELECT ON V_$SQL_PLAN TO PerformanceTuner;                 -- Truy vấn kế hoạch thực thi SQL để phân tích các truy vấn chậm
GRANT SELECT ON V_$SQLSTATS TO PerformanceTuner;                 -- Truy vấn thông tin thống kê về các truy vấn SQL để tối ưu hóa

-- 5. Nhà phát triển ứng dụng (Back-end Developer)
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

-- 6. Kỹ sư dữ liệu (Data Engineer)
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


-- 7. Nhà phân tích dữ liệu (Data Analyst)
-- Nhiệm vụ: Phân tích và trực quan hóa dữ liệu, tạo view để hỗ trợ báo cáo.
CREATE ROLE DataAnalyst;

-- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT CREATE SESSION TO DataAnalyst; 

-- Cho phép đọc dữ liệu từ tất cả các bảng
GRANT SELECT ANY TABLE TO DataAnalyst;

-- Cho phép tạo view
GRANT CREATE VIEW TO DataAnalyst; 

-- 8. Quản lý (Moderator)
-- Nhiệm vụ: Quản lý nội dung và các hoạt động của người dùng trên hệ thống.
CREATE ROLE Moderator;

-- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT CREATE SESSION TO Moderator; 

-- Cấp quyền quản lý dữ liệu trong các bảng nội dung và người dùng
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoan TO Moderator; -- Cho phép thao tác trên bảng TaiKhoan
GRANT SELECT, INSERT, UPDATE, DELETE ON BaiDang TO Moderator; -- Cho phép thao tác trên bảng BaiDang
GRANT SELECT, INSERT, UPDATE, DELETE ON PhongNhanTin TO Moderator; -- Cho phép thao tác trên bảng PhongNhanTin
GRANT SELECT, INSERT, UPDATE, DELETE ON BaoCao TO Moderator; -- Cho phép thao tác trên bảng BaoCao
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoanQuangCao TO Moderator; -- Cho phép thao tác trên bảng TaiKhoanQuangCao
GRANT SELECT, INSERT, UPDATE, DELETE ON ChienDich TO Moderator; -- Cho phép thao tác trên bảng ChienDich
GRANT SELECT, INSERT, UPDATE, DELETE ON MucTieu TO Moderator; -- Cho phép thao tác trên bảng MucTieu
GRANT SELECT, INSERT, UPDATE, DELETE ON QuangCao TO Moderator; -- Cho phép thao tác trên bảng QuangCao

-- Cấp quyền xem báo cáo và các hoạt động liên quan
GRANT SELECT ON TaiKhoan_Gui_BaoCao TO Moderator; -- Cho phép xem dữ liệu trong bảng TaiKhoan_Gui_BaoCao


-- 9. Người dùng (End-User)
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

-- 10. Giám sát viên (Supervisor)
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

-- Gán các vai trò cho người dùng tương ứng
GRANT Supervisor TO supervisor_user;
GRANT DBAdmin TO db_admin;
GRANT DatabaseDeveloper TO db_developer;
GRANT DatabaseSecuritySpecialist TO db_security;
GRANT PerformanceTuner TO perf_tuner;

GRANT BackendDeveloper TO backend_developer;
GRANT DataEngineer TO data_engineer;
GRANT DataAnalyst TO data_analyst;
GRANT Moderator TO moderator_user;
GRANT EndUser TO end_user;