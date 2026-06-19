CREATE TABLE IF NOT EXISTS tbl_refresh_tokens (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    user_id UUID NOT NULL,
    token VARCHAR(255) NOT NULL,

    expires_at TIMESTAMPTZ NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_refresh_tokens_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(id)
);