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

-- Cấp quyền cho Supervisor
GRANT CREATE SESSION TO Supervisor;
GRANT RESTRICTED SESSION TO Supervisor;
GRANT SELECT ANY TABLE TO Supervisor;
GRANT ALTER SESSION TO Supervisor;


-- 2. Quản trị viên cơ sở dữ liệu (DB Admin)
-- Nhiệm vụ: Quản lý các cơ sở dữ liệu, bao gồm bảo trì và thay đổi cấu trúc.
-- Tạo vai trò Quản trị viên cơ sở dữ liệu
CREATE ROLE DB_Admin;

-- Cấp quyền cho DB Admin
GRANT CREATE ANY TABLE TO DB_Admin;
GRANT ALTER ANY TABLE TO DB_Admin;
GRANT DELETE ANY TABLE TO DB_Admin;
GRANT SELECT ANY TABLE TO DB_Admin;
GRANT UPDATE ANY TABLE TO DB_Admin;
GRANT CREATE PROCEDURE TO DB_Admin;
GRANT ALTER ANY PROCEDURE TO DB_Admin;
GRANT DROP ANY PROCEDURE TO DB_Admin;
GRANT EXECUTE ANY PROCEDURE TO DB_Admin;
GRANT CREATE TABLESPACE TO DB_Admin;
GRANT ALTER TABLESPACE TO DB_Admin;
GRANT CREATE USER TO DB_Admin;
GRANT ALTER USER TO DB_Admin;
GRANT CREATE SESSION TO DB_Admin;
GRANT ALTER SESSION TO DB_Admin;


-- 3. Quản trị viên hệ thống (SysAdmin)
-- Nhiệm vụ: Quản lý cấp cao liên quan đến hệ thống, tài nguyên và bảo mật tổng quát.
-- Tạo vai trò Quản trị viên hệ thống
CREATE ROLE SysAdmin;

-- Cấp quyền cho SysAdmin
GRANT ALTER DATABASE TO SysAdmin;
GRANT ALTER SYSTEM TO SysAdmin;
GRANT AUDIT SYSTEM TO SysAdmin;
GRANT CREATE ROLE TO SysAdmin;
GRANT ALTER ANY ROLE TO SysAdmin;
GRANT GRANT ANY ROLE TO SysAdmin;
GRANT MANAGE TABLESPACE TO SysAdmin;
GRANT UNLIMITED TABLESPACE TO SysAdmin;
GRANT ALTER RESOURCE COST TO SysAdmin;
GRANT CREATE SESSION TO SysAdmin;
GRANT RESTRICTED SESSION TO SysAdmin;
GRANT DROP USER TO SysAdmin;

-- 4. Nhà phát triển cơ sở dữ liệu (Database Developer)
-- Nhiệm vụ: Xây dựng, phát triển và thử nghiệm các chức năng mới trong cơ sở dữ liệu.
-- Tạo vai trò Nhà phát triển cơ sở dữ liệu
CREATE ROLE DatabaseDeveloper;

-- Cấp quyền cho DatabaseDeveloper
GRANT CREATE TABLE TO DatabaseDeveloper;
GRANT INSERT ANY TABLE TO DatabaseDeveloper;
GRANT UPDATE ANY TABLE TO DatabaseDeveloper;
GRANT DELETE ANY TABLE TO DatabaseDeveloper;
GRANT CREATE PROCEDURE TO DatabaseDeveloper;
GRANT EXECUTE ANY PROCEDURE TO DatabaseDeveloper;
GRANT CREATE TRIGGER TO DatabaseDeveloper;
GRANT ALTER ANY TRIGGER TO DatabaseDeveloper;
GRANT SELECT ON ANY VIEW TO DatabaseDeveloper;
GRANT INSERT ON ANY VIEW TO DatabaseDeveloper;
GRANT UPDATE ON ANY VIEW TO DatabaseDeveloper;

-- 5. Chuyên viên bảo mật cơ sở dữ liệu (Database Security Specialist)
-- Nhiệm vụ: Quản lý bảo mật và phân quyền truy cập.
-- Tạo vai trò Chuyên viên bảo mật cơ sở dữ liệu
CREATE ROLE DatabaseSecuritySpecialist;

-- Cấp quyền cho DatabaseSecuritySpecialist
GRANT CREATE USER TO DatabaseSecuritySpecialist;
GRANT ALTER USER TO DatabaseSecuritySpecialist;
GRANT DROP USER TO DatabaseSecuritySpecialist;
GRANT GRANT ANY ROLE TO DatabaseSecuritySpecialist;
GRANT SELECT ANY TABLE TO DatabaseSecuritySpecialist;
GRANT AUDIT SYSTEM TO DatabaseSecuritySpecialist;
GRANT ANALYZE ANY TO DatabaseSecuritySpecialist;


-- 6. Chuyên viên quản lý sao lưu và khôi phục (Backup & Recovery Specialist)
-- Nhiệm vụ: Đảm bảo sao lưu và khôi phục dữ liệu khi cần.
-- Tạo vai trò Chuyên viên quản lý sao lưu và khôi phục
CREATE ROLE BackupRecoverySpecialist;

-- Cấp quyền cho BackupRecoverySpecialist
GRANT BACKUP ANY TABLE TO BackupRecoverySpecialist;
GRANT FLASHBACK ANY TABLE TO BackupRecoverySpecialist;
GRANT ALTER SYSTEM TO BackupRecoverySpecialist;
GRANT SYSBACKUP TO BackupRecoverySpecialist;



-- 7. Chuyên viên tối ưu hóa hiệu suất (Database Performance Tuner)
-- Nhiệm vụ: Tối ưu hóa truy vấn và hiệu suất cơ sở dữ liệu.
-- Tạo vai trò Chuyên viên tối ưu hóa hiệu suất
CREATE ROLE PerformanceTuner;

-- Cấp quyền cho PerformanceTuner
GRANT SELECT ANY TABLE TO PerformanceTuner;
GRANT INDEX TO PerformanceTuner;
GRANT SELECT ON ANY VIEW TO PerformanceTuner;
GRANT ALTER SESSION TO PerformanceTuner;
GRANT ANALYZE ANY TO PerformanceTuner;
GRANT FORCE TRANSACTION TO PerformanceTuner;


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
