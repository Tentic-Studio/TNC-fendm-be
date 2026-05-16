CREATE TABLE IF NOT EXISTS tbl_units (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    code VARCHAR(100) NOT NULL,
    name VARCHAR(255) NOT NULL,
    symbol VARCHAR(100) NOT NULL,

    have_convertion BOOLEAN NOT NULL DEFAULT FALSE,
    base_unit VARCHAR(25) NULL,
    conversion_factor NUMERIC NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS tbl_units_un
ON tbl_units (code)
WHERE deleted_at IS NULL
  AND deleted_by IS NULL;