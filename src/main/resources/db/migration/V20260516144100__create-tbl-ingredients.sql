CREATE TABLE IF NOT EXISTS tbl_ingredients (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    tenant_id UUID NOT NULL,
    code VARCHAR(25) NOT NULL,

    category_id UUID NOT NULL,
    unit_id UUID NOT NULL,

    name VARCHAR(255) NOT NULL,

    stock_quantity NUMERIC NOT NULL,
    minimum_stock NUMERIC NOT NULL,

    price_per_units NUMERIC NULL,
    purchase_price NUMERIC NOT NULL,
    average_price NUMERIC NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_ingredients_tenant
        FOREIGN KEY (tenant_id)
        REFERENCES tbl_tenants(id),

    CONSTRAINT fk_tbl_ingredients_category
        FOREIGN KEY (category_id)
        REFERENCES tbl_categories(id),

    CONSTRAINT fk_tbl_ingredients_unit
        FOREIGN KEY (unit_id)
        REFERENCES tbl_units(id)
);

CREATE UNIQUE INDEX IF NOT EXISTS tbl_ingredients_un
ON tbl_ingredients (tenant_id, code)
WHERE deleted_at IS NULL
  AND deleted_by IS NULL;
