CREATE TABLE IF NOT EXISTS tbl_products (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    tenant_id UUID NOT NULL,

    code VARCHAR(100) NOT NULL,

    category_id UUID NOT NULL,
    unit_id UUID NOT NULL,

    name VARCHAR(255) NOT NULL,
    type VARCHAR(100) NOT NULL,

    default_price NUMERIC NULL,
    stock_quantity NUMERIC NULL,
    estimated_cost NUMERIC NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_products_tenant
        FOREIGN KEY (tenant_id)
        REFERENCES tbl_tenants(id),

    CONSTRAINT fk_tbl_products_category
        FOREIGN KEY (category_id)
        REFERENCES tbl_categories(id),

    CONSTRAINT fk_tbl_products_unit
        FOREIGN KEY (unit_id)
        REFERENCES tbl_units(id)
);

CREATE UNIQUE INDEX IF NOT EXISTS tbl_products_un
ON tbl_products (tenant_id, code)
WHERE deleted_at IS NULL
  AND deleted_by IS NULL;


CREATE TABLE IF NOT EXISTS tbl_product_recipes (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    product_id UUID NOT NULL,

    version_number INT4 NOT NULL,

    notes TEXT NULL,

    estimated_yield NUMERIC NULL,
    unit_id UUID NULL,

    ingredient_cost NUMERIC NOT NULL,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_product_recipes_product
        FOREIGN KEY (product_id)
        REFERENCES tbl_products(id),

    CONSTRAINT fk_tbl_product_recipes_unit
        FOREIGN KEY (unit_id)
        REFERENCES tbl_units(id)
);

CREATE TABLE IF NOT EXISTS tbl_product_recipe_items (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    recipe_id UUID NOT NULL,

    ingredient_id UUID NOT NULL,

    quantity NUMERIC NOT NULL,
    unit_id UUID NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_product_recipe_items_recipe
        FOREIGN KEY (recipe_id)
        REFERENCES tbl_product_recipes(id),

    CONSTRAINT fk_tbl_product_recipe_items_ingredient
        FOREIGN KEY (ingredient_id)
        REFERENCES tbl_ingredients(id),

    CONSTRAINT fk_tbl_product_recipe_items_unit
        FOREIGN KEY (unit_id)
        REFERENCES tbl_units(id)
);