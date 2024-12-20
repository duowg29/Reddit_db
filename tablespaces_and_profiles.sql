-- Chuyen ket noi sang PDB REDDITDBPDB1
ALTER SESSION SET CONTAINER = REDDITDBPDB1;

--DATAFILE 'E:/Subjects/HQTCSDL/BTL/tablespace/tb_internal_datafile.dbf' 
--DATAFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/tablespace/tb_internal_datafile.dbf' 

-- Tao Tablespace chinh
-- Luu y: vi tri datafile tu tao nhe :)
CREATE TABLESPACE tb_internal
DATAFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/tablespace/tb_internal_datafile.dbf' 
SIZE 100M 
AUTOEXTEND ON 
NEXT 10M 
MAXSIZE UNLIMITED;

-- Tao Temporary Tablespace
-- Luu y: vi tri datafile tu tao nhe :)
CREATE TEMPORARY TABLESPACE tb_user_temp 
TEMPFILE 'C:/BA/Year 3 Semester 1/6 He quan tri co so du lieu/Bai tap lon/reddit_dbms_github/tablespace/tb_user_temp_datafile.dbf' 
SIZE 50M 
AUTOEXTEND ON 
NEXT 5M 
MAXSIZE UNLIMITED;

-- Tao Profile

-- Tao profile cho db_admin
CREATE PROFILE db_admin_profile LIMIT
  SESSIONS_PER_USER        UNLIMITED
  CONNECT_TIME             UNLIMITED
  IDLE_TIME                120
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      365
  PASSWORD_REUSE_MAX       5;

-- Tao profile cho db_developer
CREATE PROFILE db_developer_profile LIMIT
  SESSIONS_PER_USER        5
  CONNECT_TIME             180
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      180
  PASSWORD_REUSE_MAX       5;

-- Tao profile cho backend_developer
CREATE PROFILE backend_developer_profile LIMIT
  SESSIONS_PER_USER        3
  CONNECT_TIME             180
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      180
  PASSWORD_REUSE_MAX       5;

-- Tao profile cho data_engineer
CREATE PROFILE data_engineer_profile LIMIT
  SESSIONS_PER_USER        5
  CONNECT_TIME             240
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      180
  PASSWORD_REUSE_MAX       5;

-- Tao profile cho data_analyst
CREATE PROFILE data_analyst_profile LIMIT
  SESSIONS_PER_USER        3
  CONNECT_TIME             180
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    5
  PASSWORD_LIFE_TIME       90
  PASSWORD_REUSE_TIME      180
  PASSWORD_REUSE_MAX       5;

-- Tao profile cho supervisor
CREATE PROFILE supervisor_profile LIMIT
  SESSIONS_PER_USER        5
  CONNECT_TIME             240
  IDLE_TIME                60
  FAILED_LOGIN_ATTEMPTS    3
  PASSWORD_LIFE_TIME       60
  PASSWORD_REUSE_TIME      365
  PASSWORD_REUSE_MAX       10;

-- Tao profile cho end_user
CREATE PROFILE end_user_profile LIMIT
  SESSIONS_PER_USER        1
  CONNECT_TIME             60
  IDLE_TIME                15
  FAILED_LOGIN_ATTEMPTS    3
  PASSWORD_LIFE_TIME       UNLIMITED
  PASSWORD_REUSE_TIME      365
  PASSWORD_REUSE_MAX       10;
