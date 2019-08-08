--Revoke any privileges granted before
REVOKE CREATE SESSION FROM DMLUser;
REVOKE CREATE SESSION FROM Dashboard;

REVOKE ALL ON sys.address FROM DMLUser;
REVOKE ALL ON sys.donation FROM DMLUser;
REVOKE ALL ON sys.volunteer FROM DMLUser;

REVOKE SELECT ON sys.time_sum_avg FROM dashboard;
REVOKE SELECT ON sys.address_sum_avg FROM dashboard;
REVOKE SELECT ON sys.volunteer_sum_avg FROM dashboard;

--Grant permissions to allow new users to connect
GRANT CREATE SESSION TO DMLUser;
GRANT CREATE SESSION TO Dashboard;

--Grant DML privileges on address, donation, and volunteer tables to DMLUser
GRANT SELECT, INSERT, UPDATE, DELETE ON sys.address TO DMLUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON sys.donation TO DMLUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON sys.volunteer TO DMLUser;

--Grant read permissions on Views to Dashboard
GRANT SELECT ON sys.time_sum_avg TO Dashboard;
GRANT SELECT ON sys.address_sum_avg TO Dashboard;
GRANT SELECT ON sys.volunteer_sum_avg TO Dashboard;
