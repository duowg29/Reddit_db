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
-- Nhiệm vụ: Xây dựng và bảo trì các chức năng phía back-end của hệ thống, bao gồm tạo, sửa đổi và thực thi các thủ tục, trigger; xử lý dữ liệu trong các bảng chính.
CREATE ROLE BackendDeveloper;

GRANT CREATE SESSION TO BackendDeveloper; -- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT CREATE PROCEDURE, ALTER PROCEDURE, EXECUTE ANY PROCEDURE TO BackendDeveloper; -- Cho phép tạo, sửa đổi và thực thi các thủ tục
GRANT CREATE TRIGGER, ALTER TRIGGER TO BackendDeveloper; -- Cho phép tạo và sửa đổi trigger
GRANT INSERT, UPDATE, DELETE ON BaiDang TO BackendDeveloper; -- Cho phép thao tác thêm, sửa, xóa dữ liệu trong bảng BaiDang
GRANT INSERT, UPDATE, DELETE ON HoiNhom TO BackendDeveloper; -- Cho phép thao tác thêm, sửa, xóa dữ liệu trong bảng HoiNhom
GRANT SELECT ON ALL TABLES TO BackendDeveloper; -- Cho phép đọc dữ liệu từ tất cả các bảng

-- 9. Nhà quản lý nhật ký hoạt động (Log Manager)
-- Nhiệm vụ: Theo dõi và quản lý nhật ký hoạt động của hệ thống.
CREATE ROLE LogManager;

GRANT CREATE SESSION TO LogManager; -- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT SELECT ON BaoCao TO LogManager; -- Cho phép xem dữ liệu trong bảng BaoCao
GRANT SELECT ON TaiKhoan TO LogManager; -- Cho phép xem dữ liệu trong bảng TaiKhoan
GRANT SELECT ON TaiKhoan_Gui_BaoCao TO LogManager; -- Cho phép xem dữ liệu trong bảng TaiKhoan_Gui_BaoCao
GRANT SELECT ON TaiKhoan_TuongTac_BaiDang TO LogManager; -- Cho phép xem dữ liệu trong bảng TaiKhoan_TuongTac_BaiDang

GRANT LogManager TO LogManager_user; -- Gán vai trò LogManager cho người dùng LogManager_user

-- 10. Kỹ sư dữ liệu (Data Engineer)
-- Nhiệm vụ: Thiết kế, xây dựng, và duy trì cơ sở dữ liệu; xử lý dữ liệu từ nhiều nguồn.
CREATE ROLE DataEngineer;

GRANT CREATE SESSION TO DataEngineer; -- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT SELECT ANY TABLE TO DataEngineer; -- Cho phép đọc dữ liệu từ tất cả các bảng
GRANT INSERT, UPDATE, DELETE ON BaiDang TO DataEngineer; -- Cho phép thao tác thêm, sửa, xóa dữ liệu trong bảng BaiDang
GRANT INSERT, UPDATE, DELETE ON HoiNhom TO DataEngineer; -- Cho phép thao tác thêm, sửa, xóa dữ liệu trong bảng HoiNhom
GRANT CREATE TABLE, ALTER ANY TABLE TO DataEngineer; -- Cho phép tạo và sửa đổi bảng
GRANT CREATE VIEW, DROP VIEW TO DataEngineer; -- Cho phép tạo và xóa view

GRANT DataEngineer TO backend_developer_user; -- Gán vai trò DataEngineer cho người dùng backend_developer_user

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

GRANT CREATE SESSION TO ThirdPartyDeveloper; -- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT SELECT ON BaiDang TO ThirdPartyDeveloper; -- Cho phép xem dữ liệu trong bảng BaiDang
GRANT EXECUTE ON ALL PROCEDURES TO ThirdPartyDeveloper; -- Cho phép thực thi tất cả các thủ tục
GRANT SELECT ON ALL TABLES TO ThirdPartyDeveloper; -- Cho phép đọc dữ liệu từ tất cả các bảng

-- 13. Quản lý (Moderator)
-- Nhiệm vụ: Quản lý nội dung và các hoạt động của người dùng trên hệ thống.
CREATE ROLE Moderator;

GRANT CREATE SESSION TO Moderator; -- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT SELECT, INSERT, UPDATE, DELETE ON BaiDang TO Moderator; -- Cho phép thao tác trên bảng BaiDang
GRANT SELECT, INSERT, UPDATE, DELETE ON TaiKhoan TO Moderator; -- Cho phép thao tác trên bảng TaiKhoan
GRANT SELECT, INSERT, UPDATE, DELETE ON BaoCao TO Moderator; -- Cho phép thao tác trên bảng BaoCao
GRANT SELECT ON HoiNhom TO Moderator; -- Cho phép xem dữ liệu trong bảng HoiNhom
GRANT SELECT ON TaiKhoan_Gui_BaoCao TO Moderator; -- Cho phép xem dữ liệu trong bảng TaiKhoan_Gui_BaoCao

-- 14. Người dùng (End-User)
-- Nhiệm vụ: Sử dụng các tính năng cơ bản của hệ thống như xem và tương tác với dữ liệu.
CREATE ROLE EndUser;

GRANT CREATE SESSION TO EndUser; -- Cho phép đăng nhập vào cơ sở dữ liệu
GRANT SELECT ON BaiDang TO EndUser; -- Cho phép xem dữ liệu trong bảng BaiDang
GRANT INSERT ON TaiKhoan_TuongTac_BaiDang TO EndUser; -- Cho phép thêm dữ liệu vào bảng TaiKhoan_TuongTac_BaiDang
GRANT INSERT ON TaiKhoan_BinhLuan_BaiDang TO EndUser; -- Cho phép thêm dữ liệu vào bảng TaiKhoan_BinhLuan_BaiDang
GRANT SELECT ON HoiNhom TO EndUser; -- Cho phép xem dữ liệu trong bảng HoiNhom
GRANT INSERT ON TaiKhoan_ThamGia_HoiNhom TO EndUser; -- Cho phép thêm dữ liệu vào bảng TaiKhoan_ThamGia_HoiNhom
GRANT SELECT ON BaoCao TO EndUser; -- Cho phép xem dữ liệu trong bảng BaoCao

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
