CREATE TABLE IF NOT EXISTS tbl_categories (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    tenant_id UUID NOT NULL,

    code VARCHAR(100) NOT NULL,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_categories_tenant
        FOREIGN KEY (tenant_id)
        REFERENCES tbl_tenants(id)
);

CREATE UNIQUE INDEX IF NOT EXISTS tbl_categories_un
ON tbl_categories (tenant_id, code)
WHERE deleted_at IS NULL
  AND deleted_by IS NULL;