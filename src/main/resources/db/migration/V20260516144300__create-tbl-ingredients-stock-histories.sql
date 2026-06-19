CREATE TABLE IF NOT EXISTS tbl_ingredients_stock_histories (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    ingredient_id UUID NOT NULL,

    type VARCHAR(25) NOT NULL,
    quantity NUMERIC NOT NULL,
    purchase_price NUMERIC NOT NULL,

    notes VARCHAR(255) NULL,

    reference_id VARCHAR(255) NULL,
    reference_type VARCHAR(100) NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_ingredients_stock_histories_ingredient
        FOREIGN KEY (ingredient_id)
        REFERENCES tbl_ingredients(id)
);