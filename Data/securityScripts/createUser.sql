--Creates two users: dmluser and dashboard
DROP USER dmluser CASCADE;

DROP USER dashboard CASCADE;

CREATE USER dmluser IDENTIFIED BY group5
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON users;

CREATE USER dashboard IDENTIFIED BY group5
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON users;