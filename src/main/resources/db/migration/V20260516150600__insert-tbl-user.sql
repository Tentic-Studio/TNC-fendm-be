INSERT INTO tbl_users (id, tenant_id, tenant_role, username, email, "password", "role", must_change_password, 
duration_expired_pass, temp_password_expires_at, is_active, created_at, created_by, updated_at, 
updated_by, deleted_at, deleted_by)
VALUES ('4c92ea96-fd7c-4894-a203-e9c43ee86ac3', '447f9513-2a81-425d-bfa9-38efa9f29bf9', 'OWNER', 'superadmin','email@gmail.com',
'$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHHi', 'SUPER ADMIN', TRUE, 1, now(), TRUE, now(), 'SYSTEM', 
NULL, NULL, NULL, NULL);