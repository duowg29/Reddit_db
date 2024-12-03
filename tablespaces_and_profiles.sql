-- Tạo Tablespace chính
-- Lưu ý: vị trí datafile tự tạo nhé :)
CREATE TABLESPACE user_data 
DATAFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/Reddit_db/tablespace/tempt_ts.dbf' 
SIZE 100M 
AUTOEXTEND ON 
NEXT 10M 
MAXSIZE 500M;

-- Tạo Temporary Tablespace
-- Lưu ý: vị trí datafile tự tạo nhé :)
CREATE TEMPORARY TABLESPACE user_temp 
TEMPFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/Reddit_db/tablespace/tempt_ts.dbf' 
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

