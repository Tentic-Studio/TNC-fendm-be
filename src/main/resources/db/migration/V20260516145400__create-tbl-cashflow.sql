CREATE TABLE IF NOT EXISTS tbl_cashflow (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    type VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,

    amount NUMERIC NOT NULL,

    description TEXT NULL,

    reference_type VARCHAR(100) NOT NULL,
    reference_id UUID NULL,

    transaction_date TIMESTAMP NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL
);