CREATE TABLE IF NOT EXISTS tbl_orders (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    order_number BIGSERIAL NOT NULL,

    customer_name VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(25) NOT NULL,
    customer_address TEXT NOT NULL,

    order_date TIMESTAMP NOT NULL,
    required_date TIMESTAMP NOT NULL,

    status VARCHAR(20) NOT NULL,

    total_amount NUMERIC NOT NULL,
    paid_amount NUMERIC NOT NULL DEFAULT 0,

    payment_status VARCHAR(20) NOT NULL,

    notes TEXT NULL,
    system_notes TEXT NULL,

    tenant_id UUID NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_orders_tenant
        FOREIGN KEY (tenant_id)
        REFERENCES tbl_tenants(id)
);

CREATE UNIQUE INDEX IF NOT EXISTS tbl_orders_un
ON tbl_orders (tenant_id, order_number)
WHERE deleted_at IS NULL
  AND deleted_by IS NULL;


CREATE TABLE IF NOT EXISTS tbl_order_items (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    order_id UUID NOT NULL,

    quantity NUMERIC NOT NULL,
    unit_price NUMERIC NOT NULL,

    subtotal_quantity INTEGER NULL,
    subtotal NUMERIC NOT NULL,

    notes TEXT NULL,

    product_id UUID NULL,
    production_id UUID NULL,
    production_detail_id UUID NULL,

    cogs_per_unit NUMERIC NULL,
    total_cogs NUMERIC NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES tbl_orders(id),

    CONSTRAINT fk_tbl_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES tbl_products(id),

    CONSTRAINT fk_tbl_order_items_production
        FOREIGN KEY (production_id)
        REFERENCES tbl_productions(id),

    CONSTRAINT fk_tbl_order_items_production_detail
        FOREIGN KEY (production_detail_id)
        REFERENCES tbl_production_details(id)
);

CREATE TABLE IF NOT EXISTS tbl_order_payments (
    id UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),

    order_id UUID NOT NULL,

    amount NUMERIC NOT NULL,

    payment_type VARCHAR(50) NOT NULL,

    payment_date TIMESTAMP NOT NULL,

    notes TEXT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by VARCHAR(50) NOT NULL,

    updated_at TIMESTAMPTZ NULL,
    updated_by VARCHAR(50) NULL,

    deleted_at TIMESTAMPTZ NULL,
    deleted_by VARCHAR(50) NULL,

    CONSTRAINT fk_tbl_order_payments_order
        FOREIGN KEY (order_id)
        REFERENCES tbl_orders(id)
);
