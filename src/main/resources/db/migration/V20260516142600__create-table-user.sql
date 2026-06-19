CREATE TABLE IF NOT EXISTS tbl_users (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    tenant_id UUID NOT NULL,
    tenant_role VARCHAR(255) NOT NULL,

    username VARCHAR(50) NOT NULL,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    role VARCHAR(255) NOT NULL,

    must_change_password BOOLEAN NOT NULL DEFAULT TRUE,
    duration_expired_pass INT4 NOT NULL DEFAULT 1,
    temp_password_expires_at TIMESTAMPTZ NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_users_tenant
        FOREIGN KEY (tenant_id)
        REFERENCES tbl_tenants(id)
);

CREATE UNIQUE INDEX IF NOT EXISTS tbl_users_un
ON tbl_users (tenant_id, username)
WHERE deleted_at IS NULL
  AND deleted_by IS NULL;