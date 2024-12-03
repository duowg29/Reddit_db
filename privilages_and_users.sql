-- USER CREATION
-- Tạo các user với tablespace và profile
CREATE USER supervisor_user IDENTIFIED BY supervisor_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER db_admin IDENTIFIED BY dbadmin_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER sys_admin IDENTIFIED BY sysadmin_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER db_developer IDENTIFIED BY dbdeveloper_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER db_security IDENTIFIED BY dbsecurity_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER backup_recovery IDENTIFIED BY backuprecovery_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER performance_tuner IDENTIFIED BY performancetuner_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER backend_developer IDENTIFIED BY backenddeveloper_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER log_manager IDENTIFIED BY logmanager_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER data_engineer IDENTIFIED BY dataengineer_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER data_analyst IDENTIFIED BY dataanalyst_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER third_party_developer IDENTIFIED BY thirdpartydeveloper_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER moderator_user IDENTIFIED BY moderator_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;

CREATE USER end_user IDENTIFIED BY enduser_password
DEFAULT TABLESPACE user_data
TEMPORARY TABLESPACE user_temp
PROFILE user_profile;


-- ROLE CREATION
-- 1. Giám sát viên (Supervisor)
-- Nhiệm vụ: Theo dõi hoạt động chung của hệ thống, không thực hiện các thay đổi lớn.
-- Tạo vai trò Giám sát viên
CREATE ROLE Supervisor;
GRANT SELECT ANY TABLE TO Supervisor;
-- Các quyền cơ bản
GRANT CREATE SESSION TO Supervisor;
GRANT RESTRICTED SESSION TO Supervisor;

-- Quyền truy cập
GRANT SELECT ANY TABLE TO Supervisor;


-- Quyền phân tích
GRANT ANALYZE ANY TO Supervisor;

-- Quyền theo dõi phiên
GRANT MONITOR SESSION TO Supervisor;

-- 2. Quản trị viên cơ sở dữ liệu (DB Admin)
-- Nhiệm vụ: Quản lý các cơ sở dữ liệu, bao gồm bảo trì và thay đổi cấu trúc.
-- Tạo vai trò Quản trị viên cơ sở dữ liệu
CREATE ROLE DBAdmin;

-- Các quyền liên quan đến bảng
GRANT CREATE ANY TABLE TO DBAdmin;
GRANT ALTER ANY TABLE TO DBAdmin;
GRANT DELETE ANY TABLE TO DBAdmin;
GRANT SELECT ON schema_name.* TO DBAdmin;
GRANT UPDATE ANY TABLE TO DBAdmin;

-- Các quyền liên quan đến thủ tục
GRANT CREATE PROCEDURE TO DBAdmin;
GRANT ALTER ANY PROCEDURE TO DBAdmin;
GRANT DROP ANY PROCEDURE TO DBAdmin;
GRANT EXECUTE ANY PROCEDURE TO DBAdmin;

-- Các quyền liên quan đến chỉ số
GRANT CREATE ANY INDEX TO DBAdmin;
GRANT DROP ANY INDEX TO DBAdmin;

-- Các quyền liên quan đến tablespace
GRANT CREATE TABLESPACE TO DBAdmin;
GRANT ALTER TABLESPACE TO DBAdmin;

-- Các quyền liên quan đến sao lưu/phục hồi
GRANT BACKUP ANY TABLE TO DBAdmin;
GRANT FLASHBACK ANY TABLE TO DBAdmin;
GRANT ALTER SYSTEM TO DBAdmin;

-- Quyền giám sát
GRANT ANALYZE ANY TO DBAdmin;
GRANT MONITOR SESSION TO DBAdmin;

-- Quyền kết nối và quản lý phiên
GRANT CREATE SESSION TO DBAdmin;
GRANT ALTER SESSION TO DBAdmin;

-- 3. Quản trị viên hệ thống (SysAdmin)
-- Nhiệm vụ: Quản lý cấp cao liên quan đến hệ thống, tài nguyên và bảo mật tổng quát.
-- Tạo vai trò Quản trị viên hệ thống
CREATE ROLE SysAdmin;

-- Quản lý cơ sở dữ liệu
GRANT ALTER DATABASE TO SysAdmin;
GRANT ALTER SYSTEM TO SysAdmin;
GRANT AUDIT SYSTEM TO SysAdmin;

-- Quản lý vai trò
GRANT CREATE ROLE TO SysAdmin;
GRANT ALTER ANY ROLE TO SysAdmin;
GRANT GRANT ANY ROLE TO SysAdmin;

-- Quản lý tài nguyên
GRANT MANAGE TABLESPACE TO SysAdmin;
GRANT UNLIMITED TABLESPACE TO SysAdmin;
GRANT ALTER RESOURCE COST TO SysAdmin;

-- Quản lý phiên làm việc
GRANT CREATE SESSION TO SysAdmin;
GRANT RESTRICTED SESSION TO SysAdmin;

-- Quản lý tài khoản
GRANT DROP USER TO SysAdmin;
GRANT SELECT ON dba_users TO SysAdmin;
GRANT SELECT ON dba_roles TO SysAdmin;

-- Giám sát
GRANT MONITOR SESSION TO SysAdmin;
GRANT SELECT ANY DICTIONARY TO SysAdmin;
GRANT ANALYZE ANY TO SysAdmin;

-- Kích hoạt Audit cho các hành động quan trọng
AUDIT DROP USER;
AUDIT ALTER SYSTEM;

-- 4. Nhà phát triển cơ sở dữ liệu (Database Developer)
-- Nhiệm vụ: Xây dựng, phát triển và thử nghiệm các chức năng mới trong cơ sở dữ liệu.
-- Tạo vai trò Nhà phát triển cơ sở dữ liệu
CREATE ROLE DatabaseDeveloper;

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
GRANT SELECT ANY VIEW TO DatabaseDeveloper;  -- Đọc dữ liệu từ mọi view
GRANT INSERT ANY VIEW TO DatabaseDeveloper;  -- Chèn dữ liệu vào mọi view
GRANT UPDATE ANY VIEW TO DatabaseDeveloper;  -- Cập nhật dữ liệu vào mọi view

-- Cấp quyền truy cập vào các đối tượng khác nếu cần
GRANT SELECT ANY TABLE TO DatabaseDeveloper;  -- Đọc dữ liệu từ mọi bảng trong cơ sở dữ liệu

-- 5. Chuyên viên bảo mật cơ sở dữ liệu (Database Security Specialist)
-- Nhiệm vụ: Quản lý bảo mật và phân quyền truy cập.
-- Tạo vai trò Chuyên viên bảo mật cơ sở dữ liệu
CREATE ROLE DatabaseSecuritySpecialist;

-- Quản lý tài khoản người dùng
GRANT CREATE USER TO DatabaseSecuritySpecialist;  -- Cho phép tạo người dùng mới
GRANT ALTER USER TO DatabaseSecuritySpecialist;   -- Cho phép thay đổi thuộc tính của người dùng
GRANT DROP USER TO DatabaseSecuritySpecialist;    -- Cho phép xóa người dùng

-- Quản lý vai trò
GRANT GRANT ANY ROLE TO DatabaseSecuritySpecialist; -- Cấp quyền cấp vai trò cho người khác
GRANT CREATE ROLE TO DatabaseSecuritySpecialist;   -- Cấp quyền tạo vai trò mới
GRANT ALTER ANY ROLE TO DatabaseSecuritySpecialist; -- Cấp quyền thay đổi vai trò của người dùng

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

-- 6. Chuyên viên quản lý sao lưu và khôi phục (Backup & Recovery Specialist) 
-- Nhiệm vụ: Đảm bảo sao lưu và khôi phục dữ liệu khi cần.
-- Tạo vai trò Chuyên viên quản lý sao lưu và khôi phục
CREATE ROLE BackupRecoverySpecialist;

-- Quản lý sao lưu và khôi phục
GRANT BACKUP ANY TABLE TO BackupRecoverySpecialist;           -- Cho phép sao lưu bất kỳ bảng nào trong cơ sở dữ liệu
GRANT FLASHBACK ANY TABLE TO BackupRecoverySpecialist;        -- Cho phép sử dụng tính năng Flashback để khôi phục dữ liệu
GRANT SYSBACKUP TO BackupRecoverySpecialist;                  -- Quyền truy cập vào các lệnh sao lưu và khôi phục của hệ thống

-- Quản lý hệ thống sao lưu và khôi phục
GRANT ALTER SYSTEM TO BackupRecoverySpecialist;              -- Cho phép thay đổi các cài đặt của hệ thống liên quan đến sao lưu và khôi phục

-- Quản lý quản lý tài nguyên sao lưu
GRANT CREATE TABLESPACE TO BackupRecoverySpecialist;          -- Cho phép tạo và quản lý các không gian bảng (tablespace) cho sao lưu và khôi phục
GRANT ALTER TABLESPACE TO BackupRecoverySpecialist;           -- Cấp quyền thay đổi không gian bảng (tablespace) cho sao lưu và khôi phục

-- Quản lý lịch sử sao lưu và khôi phục
GRANT SELECT ON DBA_BACKUP_SET TO BackupRecoverySpecialist;   -- Cho phép truy vấn thông tin sao lưu từ bảng DBA_BACKUP_SET
GRANT SELECT ON DBA_RECOVERY_FILE_DEST TO BackupRecoverySpecialist; -- Cho phép truy vấn thông tin về thư mục khôi phục
GRANT SELECT ON V_$BACKUP_REDOLOG TO BackupRecoverySpecialist; -- Truy vấn thông tin sao lưu các redo log

-- Quản lý các nhiệm vụ sao lưu và khôi phục
GRANT EXECUTE ON DBMS_BACKUP_RESTORE TO BackupRecoverySpecialist; -- Cấp quyền thực thi các thủ tục trong gói DBMS_BACKUP_RESTORE
GRANT EXECUTE ON DBMS_FLASHBACK TO BackupRecoverySpecialist;      -- Cấp quyền thực thi các thủ tục trong gói DBMS_FLASHBACK

-- Quản lý kiểm tra tính toàn vẹn sao lưu
GRANT SELECT ON DBA_BACKUP_ARCHIVE_DEST TO BackupRecoverySpecialist; -- Truy vấn thông tin về sao lưu lưu trữ
GRANT SELECT ON DBA_DATA_FILES TO BackupRecoverySpecialist;         -- Truy vấn thông tin về các file dữ liệu đã sao lưu

-- Giám sát sao lưu và khôi phục
GRANT MONITOR BACKUP TO BackupRecoverySpecialist;                -- Giám sát các quá trình sao lưu và khôi phục
GRANT AUDIT BACKUP TO BackupRecoverySpecialist;                  -- Giám sát và ghi nhận các sự kiện liên quan đến sao lưu và khôi phục
-- 7. Chuyên viên tối ưu hóa hiệu suất (Database Performance Tuner)
-- Nhiệm vụ: Tối ưu hóa truy vấn và hiệu suất cơ sở dữ liệu.
-- Tạo vai trò Chuyên viên tối ưu hóa hiệu suất
CREATE ROLE PerformanceTuner;

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
GRANT ALTER SYSTEM TO PerformanceTuner;                          -- Cho phép thay đổi tham số hệ thống liên quan đến hiệu suất
GRANT SELECT ON V_$PARAMETER TO PerformanceTuner;                -- Cấp quyền truy vấn các tham số hệ thống để tối ưu hóa

-- Giám sát và đánh giá hiệu suất
GRANT SELECT ON V_$SESSION TO PerformanceTuner;                  -- Truy vấn thông tin về các phiên làm việc để đánh giá hiệu suất
GRANT SELECT ON V_$SQL_PLAN TO PerformanceTuner;                 -- Truy vấn kế hoạch thực thi SQL để phân tích các truy vấn chậm
GRANT SELECT ON V_$SQLSTATS TO PerformanceTuner;                 -- Truy vấn thông tin thống kê về các truy vấn SQL để tối ưu hóa

-- 8. Nhà phát triển ứng dụng (Back-end Developer)
-- Nhiệm vụ: Xây dựng và bảo trì các chức năng phía back-end của hệ thống, bao gồm tạo, sửa đổi và thực thi các thủ tục, trigger; xử lý dữ liệu trong các bảng chính.
CREATE ROLE BackendDeveloper;

-- Cấp quyền đăng nhập
GRANT CREATE SESSION TO BackendDeveloper;

-- Cấp quyền thao tác thủ tục
GRANT CREATE PROCEDURE, ALTER PROCEDURE, EXECUTE ANY PROCEDURE TO BackendDeveloper;

-- Cấp quyền thao tác trigger
GRANT CREATE TRIGGER, ALTER TRIGGER TO BackendDeveloper;

-- Cấp quyền thao tác trên các bảng chính
GRANT INSERT, UPDATE, DELETE ON TaiKhoan TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON BaiDang TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON PhongNhanTin TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON BaoCao TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON TaiKhoanQuangCao TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON ChienDich TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON MucTieu TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON QuangCao TO BackendDeveloper;

-- Cấp quyền SELECT trên tất cả các bảng
GRANT SELECT ANY TABLE TO BackendDeveloper;

-- Cấp quyền đăng nhập
GRANT CREATE SESSION TO LogManager;

-- Cấp quyền truy vấn các bảng nhật ký hệ thống
GRANT SELECT ANY TABLE TO LogManager;  -- Có thể thay bằng các quyền cụ thể
GRANT SELECT ON DBA_AUDIT_TRAIL TO LogManager;
GRANT SELECT ON V_$LOG TO LogManager;
GRANT SELECT ON V_$LOGFILE TO LogManager;
GRANT SELECT ON DBA_LOGS TO LogManager;

-- 10. Kỹ sư dữ liệu (Data Engineer)
-- Nhiệm vụ: Thiết kế, xây dựng, và duy trì cơ sở dữ liệu; xử lý dữ liệu từ nhiều nguồn.
CREATE ROLE DataEngineer;

-- Cấp quyền đăng nhập
GRANT CREATE SESSION TO DataEngineer;

-- Cấp quyền thao tác trên dữ liệu
GRANT SELECT ANY TABLE TO DataEngineer;
GRANT INSERT, UPDATE, DELETE ANY TABLE TO DataEngineer;

-- Cấp quyền thao tác cấu trúc cơ sở dữ liệu
GRANT CREATE TABLE, ALTER ANY TABLE TO DataEngineer;
GRANT CREATE VIEW, DROP VIEW TO DataEngineer;
GRANT CREATE SEQUENCE, DROP SEQUENCE TO DataEngineer;

-- Cấp quyền truy cập bảng hệ thống
GRANT SELECT ON DBA_TABLES TO DataEngineer;
GRANT SELECT ON DBA_TAB_COLUMNS TO DataEngineer;
GRANT SELECT ON DBA_INDEXES TO DataEngineer;

-- Cấp quyền tạo thủ tục, hàm, chỉ mục
GRANT CREATE PROCEDURE, CREATE FUNCTION TO DataEngineer;
GRANT CREATE INDEX, DROP INDEX TO DataEngineer;

-- Cấp quyền thực thi thủ tục tối ưu hóa
GRANT EXECUTE ON DBMS_STATS TO DataEngineer;

-- Cấp quyền tạo và thay đổi sequence
GRANT CREATE SEQUENCE, ALTER SEQUENCE TO DataEngineer;

-- 11. Nhà phân tích dữ liệu (Data Analyst)
-- Nhiệm vụ: Phân tích và trực quan hóa dữ liệu, tạo view để hỗ trợ báo cáo.
CREATE ROLE DataAnalyst;

GRANT CREATE SESSION TO DataAnalyst; -- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT SELECT ANY TABLE TO DataAnalyst; -- Cho phép đọc dữ liệu từ tất cả các bảng
GRANT CREATE VIEW TO DataAnalyst; -- Cho phép tạo view
GRANT SELECT ON BaiDang TO DataAnalyst; -- Cho phép xem dữ liệu trong bảng BaiDang
GRANT SELECT ON HoiNhom TO DataAnalyst; -- Cho phép xem dữ liệu trong bảng HoiNhom
GRANT SELECT ON TaiKhoan TO DataAnalyst; -- Cho phép xem dữ liệu trong bảng TaiKhoan

-- 12. Nhà phát triển bên thứ ba (Third-party Tool Developer)
-- Nhiệm vụ: Tích hợp công cụ bên thứ ba với hệ thống cơ sở dữ liệu.
CREATE ROLE ThirdPartyDeveloper;

-- Cấp quyền đăng nhập
GRANT CREATE SESSION TO ThirdPartyDeveloper;

-- Cấp quyền SELECT
GRANT SELECT ON ANY TABLES TO ThirdPartyDeveloper;

-- Cấp quyền thực thi cho các thủ tục cần thiết (nếu có)
GRANT EXECUTE ON procedure_name TO ThirdPartyDeveloper;

-- 13. Quản lý (Moderator)
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


-- 14. Người dùng (End-User)
-- Nhiệm vụ: Sử dụng các tính năng cơ bản của hệ thống như xem và tương tác với dữ liệu.
CREATE ROLE EndUser;

GRANT CREATE SESSION TO EndUser; -- Cho phép đăng nhập vào cơ sở dữ liệu

-- Cấp quyền xem và thêm dữ liệu trên các bảng
GRANT SELECT, INSERT ON TaiKhoan TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng TaiKhoan
GRANT SELECT, INSERT ON BaiDang TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng BaiDang
GRANT SELECT, INSERT ON PhongNhanTin TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng PhongNhanTin
GRANT SELECT, INSERT ON BaoCao TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng BaoCao
GRANT SELECT, INSERT ON TaiKhoanQuangCao TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng TaiKhoanQuangCao
GRANT SELECT, INSERT ON ChienDich TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng ChienDich
GRANT SELECT, INSERT ON MucTieu TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng MucTieu
GRANT SELECT, INSERT ON QuangCao TO EndUser; -- Cho phép xem và thêm dữ liệu trong bảng QuangCao

-- Gán các vai trò cho người dùng tương ứng
GRANT Supervisor TO supervisor_user;
GRANT DBAdmin TO db_admin;
GRANT SysAdmin TO sys_admin;
GRANT DatabaseDeveloper TO db_developer;
GRANT DatabaseSecuritySpecialist TO db_security;
GRANT BackupRecoverySpecialist TO db_backup_recovery_specialist;
GRANT PerformanceTuner TO perf_tuner;

GRANT BackendDeveloper TO backend_developer;
GRANT LogManager TO log_manager;
GRANT DataEngineer TO data_engineer;
GRANT DataAnalyst TO data_analyst;
GRANT ThirdPartyDeveloper TO third_party_developer;
GRANT Moderator TO moderator_user;
GRANT EndUser TO end_user;