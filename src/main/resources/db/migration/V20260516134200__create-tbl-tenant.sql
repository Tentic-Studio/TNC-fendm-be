CREATE TABLE IF NOT EXISTS tbl_tenants (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
    code VARCHAR(100) NOT NULL,
    business_name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    phone VARCHAR(25) NOT NULL,
    email TEXT NOT NULL,
    invoice_footer TEXT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL
);

CREATE UNIQUE INDEX tbl_tenant_un
ON tbl_tenants (code)
WHERE deleted_at IS NULL
  AND deleted_by IS NULL;