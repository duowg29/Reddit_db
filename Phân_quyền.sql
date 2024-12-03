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

-- Gán vai trò Supervisor cho người dùng john_doe
GRANT Supervisor TO john_doe;

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

-- Gán vai trò DB_Admin cho người dùng admin_user
GRANT DB_Admin TO admin_user;

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

-- Gán vai trò SysAdmin cho người dùng sys_admin_user
GRANT SysAdmin TO sys_admin_user;

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

-- Gán vai trò cho người dùng security_user
GRANT DatabaseSecuritySpecialist TO security_user;

-- Cấp quyền cho DatabaseDeveloper (có thể tối ưu theo từng trường hợp)
GRANT CREATE TRIGGER TO DatabaseDeveloper;
GRANT ALTER ANY TRIGGER TO DatabaseDeveloper;
GRANT SELECT ON ANY VIEW TO DatabaseDeveloper;
GRANT INSERT ON ANY VIEW TO DatabaseDeveloper;
GRANT UPDATE ON ANY VIEW TO DatabaseDeveloper;

-- Gán vai trò DatabaseDeveloper cho người dùng db_dev_user
GRANT DatabaseDeveloper TO db_dev_user;

-- 6. Chuyên viên quản lý sao lưu và khôi phục (Backup & Recovery Specialist)
-- Nhiệm vụ: Đảm bảo sao lưu và khôi phục dữ liệu khi cần.
-- Tạo vai trò Chuyên viên quản lý sao lưu và khôi phục
CREATE ROLE BackupRecoverySpecialist;

-- Cấp quyền cho BackupRecoverySpecialist
GRANT BACKUP ANY TABLE TO BackupRecoverySpecialist;
GRANT FLASHBACK ANY TABLE TO BackupRecoverySpecialist;
GRANT ALTER SYSTEM TO BackupRecoverySpecialist;
GRANT SYSBACKUP TO BackupRecoverySpecialist;

-- Gán vai trò BackupRecoverySpecialist cho người dùng backup_user
GRANT BackupRecoverySpecialist TO backup_user;


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

-- Gán vai trò PerformanceTuner cho người dùng perf_tuner_user
GRANT PerformanceTuner TO perf_tuner_user;
