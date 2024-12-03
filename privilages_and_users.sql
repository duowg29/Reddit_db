-- Tạo Tablespace chính
CREATE TABLESPACE user_data 
DATAFILE 'D:/app/oracle/ora/data/tempt_ts.dbf' 
SIZE 100M 
AUTOEXTEND ON 
NEXT 10M 
MAXSIZE 500M;

-- Tạo Temporary Tablespace
CREATE TEMPORARY TABLESPACE user_temp 
TEMPFILE 'D:/app/oracle/ora/data/tempt_ts.dbf' 
SIZE 50M 
AUTOEXTEND ON 
NEXT 5M 
MAXSIZE 100M;

CREATE PROFILE user_profile LIMIT
    SESSIONS_PER_USER 5               -- Giới hạn tối đa 5 phiên đăng nhập đồng thời.
    CPU_PER_SESSION 10000             -- Giới hạn CPU sử dụng cho mỗi phiên.
    CONNECT_TIME 60                   -- Giới hạn thời gian kết nối tối đa 60 phút.
    IDLE_TIME 30                      -- Ngắt kết nối nếu người dùng không hoạt động trong 30 phút.
    PASSWORD_LIFE_TIME 30             -- Mật khẩu hết hạn sau 30 ngày.
    PASSWORD_REUSE_TIME 180           -- Không cho phép sử dụng lại mật khẩu cũ trong 180 ngày.
    PASSWORD_REUSE_MAX 5              -- Không cho phép sử dụng lại 5 mật khẩu gần nhất.
    FAILED_LOGIN_ATTEMPTS 5           -- Khóa tài khoản sau 5 lần đăng nhập thất bại.
    PASSWORD_LOCK_TIME 1              -- Tài khoản bị khóa trong 1 ngày nếu đăng nhập thất bại.
    PASSWORD_VERIFY_FUNCTION verify_function; -- Hàm xác minh độ mạnh của mật khẩu (nếu đã triển khai).


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
CREATE ROLE DB_Admin;

-- Các quyền liên quan đến bảng
GRANT CREATE ANY TABLE TO DB_Admin;
GRANT ALTER ANY TABLE TO DB_Admin;
GRANT DELETE ANY TABLE TO DB_Admin;
GRANT SELECT ON schema_name.* TO DB_Admin;
GRANT UPDATE ANY TABLE TO DB_Admin;

-- Các quyền liên quan đến thủ tục
GRANT CREATE PROCEDURE TO DB_Admin;
GRANT ALTER ANY PROCEDURE TO DB_Admin;
GRANT DROP ANY PROCEDURE TO DB_Admin;
GRANT EXECUTE ANY PROCEDURE TO DB_Admin;

-- Các quyền liên quan đến chỉ số
GRANT CREATE ANY INDEX TO DB_Admin;
GRANT DROP ANY INDEX TO DB_Admin;

-- Các quyền liên quan đến tablespace
GRANT CREATE TABLESPACE TO DB_Admin;
GRANT ALTER TABLESPACE TO DB_Admin;

-- Các quyền liên quan đến sao lưu/phục hồi
GRANT BACKUP ANY TABLE TO DB_Admin;
GRANT FLASHBACK ANY TABLE TO DB_Admin;
GRANT ALTER SYSTEM TO DB_Admin;

-- Quyền giám sát
GRANT ANALYZE ANY TO DB_Admin;
GRANT MONITOR SESSION TO DB_Admin;

-- Quyền kết nối và quản lý phiên
GRANT CREATE SESSION TO DB_Admin;
GRANT ALTER SESSION TO DB_Admin;



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
CREATE ROLE BackendDeveloper;

GRANT CREATE SESSION TO BackendDeveloper;
GRANT CREATE PROCEDURE, ALTER PROCEDURE, EXECUTE ANY PROCEDURE TO BackendDeveloper;
GRANT CREATE TRIGGER, ALTER TRIGGER TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON BaiDang TO BackendDeveloper;
GRANT INSERT, UPDATE, DELETE ON HoiNhom TO BackendDeveloper;
GRANT SELECT ON ALL TABLES TO BackendDeveloper;

-- 9. Nhà quản lý nhật ký hoạt động (Log Manager)
CREATE ROLE LogManager;

GRANT CREATE SESSION TO LogManager;
GRANT SELECT ON BaoCao TO LogManager;
GRANT SELECT ON TaiKhoan TO LogManager;
GRANT SELECT ON TaiKhoan_Gui_BaoCao TO LogManager;
GRANT SELECT ON TaiKhoan_TuongTac_BaiDang TO LogManager;

GRANT LogManager TO LogManager_user;

-- 10. Kỹ sư dữ liệu (Data Engineer)
CREATE ROLE DataEngineer;

GRANT CREATE SESSION TO DataEngineer;
GRANT SELECT ANY TABLE TO DataEngineer;
GRANT INSERT, UPDATE, DELETE ON BaiDang TO DataEngineer;
GRANT INSERT, UPDATE, DELETE ON HoiNhom TO DataEngineer;
GRANT CREATE TABLE, ALTER ANY TABLE TO DataEngineer;
GRANT CREATE VIEW, DROP VIEW TO DataEngineer;

GRANT  TO backend_developer_user;

-- 11. Nhà phân tích dữ liệu (Data Analyst)
CREATE ROLE DataAnalyst;

GRANT CREATE SESSION TO DataAnalyst;
GRANT SELECT ANY TABLE TO DataAnalyst;
GRANT CREATE VIEW TO DataAnalyst;
GRANT SELECT ON BaiDang TO DataAnalyst;
GRANT SELECT ON HoiNhom TO DataAnalyst;
GRANT SELECT ON TaiKhoan TO DataAnalyst;

-- 12. Nhà phát triển bên thứ ba (Third-party Tool Developer)
CREATE ROLE ThirdPartyDeveloper;

GRANT CREATE SESSION TO ThirdPartyDeveloper;
GRANT SELECT ON BaiDang TO ThirdPartyDeveloper;
GRANT EXECUTE ON ALL PROCEDURES TO ThirdPartyDeveloper;
GRANT SELECT ON ALL TABLES TO ThirdPartyDeveloper;

-- 13. Quản lý (Moderator)
CREATE ROLE Moderator;

GRANT CREATE SESSION TO Moderator;
GRANT SELECT, INSERT, UPDATE, DELETE ON BaiDang TO Moderator;
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoan TO Moderator;
GRANT SELECT, INSERT, UPDATE, DELETE ON BaoCao TO Moderator;
GRANT SELECT ON HoiNhom TO Moderator;
GRANT SELECT ON TaiKhoan_Gui_BaoCao TO Moderator;

-- 14. Người dùng (End-User)
CREATE ROLE EndUser;

GRANT CREATE SESSION TO EndUser;
GRANT SELECT ON BaiDang TO EndUser;
GRANT INSERT ON TaiKhoan_TuongTac_BaiDang TO EndUser;
GRANT INSERT ON TaiKhoan_BinhLuan_BaiDang TO EndUser;
GRANT SELECT ON HoiNhom TO EndUser;
GRANT INSERT ON TaiKhoan_ThamGia_HoiNhom TO EndUser;
GRANT SELECT ON BaoCao TO EndUser;

-- Gán các vai trò cho người dùng tương ứng
GRANT Supervisor TO supervisor_user;
GRANT DB_Admin TO db_admin_user;
GRANT SysAdmin TO sys_admin_user;
GRANT DatabaseDeveloper TO db_developer_user;
GRANT DatabaseSecuritySpecialist TO db_security_user;
GRANT BackupRecoverySpecialist TO db_backup_user;
GRANT PerformanceTuner TO perf_tuner_user;

GRANT Backend_Developer TO backend_dev_user;
GRANT LogManager TO log_manager_user;
GRANT DataEngineer TO data_engineer_user;
GRANT DataAnalyst TO data_analyst_user;
GRANT ThirdPartyDeveloper TO third_party_dev_user;
GRANT Moderator TO moderator_user;
GRANT EndUser TO end_user_user;
