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

-- Tạo Temporary Tablespace
-- Lưu ý: vị trí datafile tự tạo nhé :)
CREATE TEMPORARY TABLESPACE tb_user_temp 
TEMPFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/Reddit_db/tablespace/tempt_ts.dbf' 
SIZE 50M 
AUTOEXTEND ON 
NEXT 5M 
MAXSIZE UNLIMITED;

-- Tạo Profile

-- Tạo profile cho db_admin
CREATE PROFILE db_admin_profile LIMIT
  SESSIONS_PER_USER        UNLIMITED
  CPU_PER_SESSION          UNLIMITED
  CONNECT_TIME             UNLIMITED
  IDLE_TIME                120
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      365
  PASSWORD_REUSE_MAX       5;

-- Tạo profile cho db_developer
CREATE PROFILE db_developer_profile LIMIT
  SESSIONS_PER_USER        3
  CPU_PER_SESSION          10000
  CONNECT_TIME             180
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      180
  PASSWORD_REUSE_MAX       5;

-- Tạo profile cho backend_developer
CREATE PROFILE backend_developer_profile LIMIT
  SESSIONS_PER_USER        3
  CPU_PER_SESSION          10000
  CONNECT_TIME             180
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      180
  PASSWORD_REUSE_MAX       5;

-- Tạo profile cho data_engineer
CREATE PROFILE data_engineer_profile LIMIT
  SESSIONS_PER_USER        4
  CPU_PER_SESSION          20000
  CONNECT_TIME             240
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      180
  PASSWORD_REUSE_MAX       5;

-- Tạo profile cho data_analyst
CREATE PROFILE data_analyst_profile LIMIT
  SESSIONS_PER_USER        3
  CPU_PER_SESSION          10000
  CONNECT_TIME             180
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      180
  PASSWORD_REUSE_MAX       5;

-- Tạo profile cho supervisor
CREATE PROFILE supervisor_profile LIMIT
  SESSIONS_PER_USER        5
  CPU_PER_SESSION          20000
  CPU_PER_CALL             2000
  CONNECT_TIME             240
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    3
  PASSWORD_LIFE_TIME       60
  PASSWORD_REUSE_TIME      365
  PASSWORD_REUSE_MAX       10;

-- Tạo profile cho end_user
CREATE PROFILE end_user_profile LIMIT
  SESSIONS_PER_USER        1
  CPU_PER_SESSION          5000
  CONNECT_TIME             60
  IDLE_TIME                15
  FAILED_LOGIN_ATTEMPTS    3;