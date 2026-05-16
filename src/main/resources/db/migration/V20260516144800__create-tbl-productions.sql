CREATE TABLE IF NOT EXISTS tbl_productions (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    product_id UUID NOT NULL,
    tenant_id UUID NOT NULL,

    status VARCHAR(20) NULL,
    notes TEXT NULL,

    total_quantity INTEGER NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_productions_product
        FOREIGN KEY (product_id)
        REFERENCES tbl_products(id),

    CONSTRAINT fk_tbl_productions_tenant
        FOREIGN KEY (tenant_id)
        REFERENCES tbl_tenants(id)
);

CREATE TABLE IF NOT EXISTS tbl_production_details (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    production_id UUID NOT NULL,
    recipe_id UUID NOT NULL,

    quantity_produced NUMERIC NOT NULL,

    production_date DATE NOT NULL,

    status VARCHAR(20) NULL,

    notes TEXT NULL,

    expired_date TIMESTAMP NOT NULL,

    actual_yield NUMERIC NOT NULL,

    actual_cost_per_unit NUMERIC NULL,
    total_actual_cost NUMERIC NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_production_details_production
        FOREIGN KEY (production_id)
        REFERENCES tbl_productions(id),

    CONSTRAINT fk_tbl_production_details_recipe
        FOREIGN KEY (recipe_id)
        REFERENCES tbl_product_recipes(id)
);