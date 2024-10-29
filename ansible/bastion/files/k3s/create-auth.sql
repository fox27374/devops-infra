CREATE ROLE anon nologin;
CREATE ROLE authenticator noinherit login password 'authenticator';
GRANT anon TO authenticator;

GRANT ALL on guacamole_connection TO anon;
GRANT ALL on guacamole_connection_attribute TO anon;
GRANT ALL on guacamole_connection_group TO anon;
GRANT ALL on guacamole_connection_group_attribute TO anon;
GRANT ALL on guacamole_connection_group_permission TO anon;
GRANT ALL on guacamole_connection_history TO anon;
GRANT ALL on guacamole_connection_parameter TO anon;
GRANT ALL on guacamole_connection_permission TO anon;
GRANT ALL on guacamole_entity TO anon;
GRANT ALL on guacamole_sharing_profile TO anon;
GRANT ALL on guacamole_sharing_profile_attribute TO anon;
GRANT ALL on guacamole_sharing_profile_parameter TO anon;
GRANT ALL on guacamole_sharing_profile_permission TO anon;
GRANT ALL on guacamole_system_permission TO anon;
GRANT ALL on guacamole_user TO anon;
GRANT ALL on guacamole_user_attribute TO anon;
GRANT ALL on guacamole_user_group TO anon;
GRANT ALL on guacamole_user_group_attribute TO anon;
GRANT ALL on guacamole_user_group_member TO anon;
GRANT ALL on guacamole_user_group_permission TO anon;
GRANT ALL on guacamole_user_history TO anon;
GRANT ALL on guacamole_user_password_history TO anon;
GRANT ALL on guacamole_user_permission TO anon;

