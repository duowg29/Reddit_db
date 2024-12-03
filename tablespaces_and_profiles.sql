-- Tạo Tablespace chính
-- Lưu ý: vị trí datafile tự tạo nhé :)
CREATE TABLESPACE tb_internal
DATAFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/Reddit_db/tablespace/tb_internal_datafile.dbf' 
SIZE 100M 
AUTOEXTEND ON 
NEXT 10M 
MAXSIZE UNLIMITED;

-- Tạo Tablespace index
-- Lưu ý: vị trí datafile tự tạo nhé :)
CREATE TABLESPACE tb_index
DATAFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/Reddit_db/tablespace/index_ts.dbf' 
SIZE 100M 
AUTOEXTEND ON 
NEXT 10M 
MAXSIZE UNLIMITED;

-- Tạo Tablespace user
-- Lưu ý: vị trí datafile tự tạo nhé :)
CREATE TABLESPACE tb_user_data
DATAFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/Reddit_db/tablespace/tempt_ts.dbf' 
SIZE 100M 
AUTOEXTEND ON 
NEXT 10M 
MAXSIZE UNLIMITED;

-- Tạo Temporary Tablespace
-- Lưu ý: vị trí datafile tự tạo nhé :)
CREATE TEMPORARY TABLESPACE tb_user_temp 
TEMPFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/Reddit_db/tablespace/tempt_ts.dbf' 
SIZE 50M 
AUTOEXTEND ON 
NEXT 5M 
MAXSIZE UNLIMITED;

CREATE PROFILE user_profile LIMIT
    SESSIONS_PER_USER 10              -- Giới hạn tối đa 10 phiên đăng nhập đồng thời. (Đa hệ điều hành, đa thiết bị)
    CPU_PER_SESSION 10000             -- Giới hạn CPU sử dụng cho mỗi phiên.
    CONNECT_TIME 60                   -- Giới hạn thời gian kết nối tối đa 60 phút.
    IDLE_TIME 30                      -- Ngắt kết nối nếu người dùng không hoạt động trong 30 phút.
    PASSWORD_LIFE_TIME 30             -- Mật khẩu hết hạn sau 30 ngày.
    PASSWORD_REUSE_TIME 180           -- Không cho phép sử dụng lại mật khẩu cũ trong 180 ngày.
    PASSWORD_REUSE_MAX 5              -- Không cho phép sử dụng lại 5 mật khẩu gần nhất.
    FAILED_LOGIN_ATTEMPTS 10          -- Khóa tài khoản sau 10 lần đăng nhập thất bại.
    PASSWORD_LOCK_TIME 1              -- Tài khoản bị khóa trong 1 ngày nếu đăng nhập thất bại.
    PASSWORD_VERIFY_FUNCTION verify_function; -- Hàm xác minh độ mạnh của mật khẩu (nếu đã triển khai).

/*
CREATE TABLESPACE tb_internal
DATAFILE 'C:/database/tablespace/tb_internal_datafile.dbf'
SIZE 100M 
AUTOEXTEND ON 
NEXT 10M 
MAXSIZE UNLIMITED;

CREATE TABLESPACE tb_index
DATAFILE 'C:/database/tablespace/tb_index_datafile.dbf'
SIZE 100M 
AUTOEXTEND ON 
NEXT 10M 
MAXSIZE UNLIMITED;

CREATE TABLESPACE tb_user
DATAFILE 'C:/database/tablespace/tb_user_datafile.dbf'
SIZE 100M 
AUTOEXTEND ON 
NEXT 10M 
MAXSIZE UNLIMITED;

CREATE TEMPORARY TABLESPACE tb_temp 
TEMPFILE 'C:/database/tablespace/tb_temp_datafile.dbf'
SIZE 50M 
AUTOEXTEND ON 
NEXT 5M 
MAXSIZE UNLIMITED;

CREATE PROFILE user_profile LIMIT
    SESSIONS_PER_USER 10
    CPU_PER_SESSION 10000
    CONNECT_TIME 60
    IDLE_TIME 30
    PASSWORD_LIFE_TIME 30
    FAILED_LOGIN_ATTEMPTS 5
    PASSWORD_LOCK_TIME 1;

CREATE PROFILE internal_profile LIMIT
    SESSIONS_PER_USER UNLIMITED
    CPU_PER_SESSION UNLIMITED
    CONNECT_TIME UNLIMITED
    IDLE_TIME UNLIMITED
    PASSWORD_LIFE_TIME 180;

CREATE PROFILE temp_profile LIMIT
    SESSIONS_PER_USER 2
    CPU_PER_SESSION 3000
    CONNECT_TIME 30
    IDLE_TIME 10
    PASSWORD_LIFE_TIME 7;
