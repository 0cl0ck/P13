-- Your Car Your Way – PostgreSQL schema (V1)
-- Creates base tables for: customer, vehicle, reservation, support_ticket

BEGIN;

CREATE TABLE IF NOT EXISTS customer (
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name      VARCHAR(100)      NOT NULL,
    last_name       VARCHAR(100)      NOT NULL,
    email           VARCHAR(255)      NOT NULL UNIQUE,
    password_hash   VARCHAR(255)      NOT NULL,
    created_at      TIMESTAMPTZ       NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ       NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS vehicle (
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    model           VARCHAR(120)      NOT NULL,
    acriss_code     CHAR(4)           NOT NULL,
    daily_rate      NUMERIC(10,2)     NOT NULL CHECK (daily_rate >= 0)
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_vehicle_acriss_model ON vehicle (acriss_code, model);

CREATE TABLE IF NOT EXISTS reservation (
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id     BIGINT            NOT NULL REFERENCES customer(id) ON DELETE CASCADE,
    vehicle_id      BIGINT            NOT NULL REFERENCES vehicle(id),
    start_date      TIMESTAMPTZ       NOT NULL,
    end_date        TIMESTAMPTZ       NOT NULL,
    status          VARCHAR(16)       NOT NULL,
    CONSTRAINT reservation_dates_ck CHECK (end_date > start_date),
    CONSTRAINT reservation_status_ck CHECK (status IN ('PENDING','CONFIRMED','CANCELLED','COMPLETED'))
);

CREATE INDEX IF NOT EXISTS idx_reservation_customer ON reservation(customer_id);
CREATE INDEX IF NOT EXISTS idx_reservation_vehicle  ON reservation(vehicle_id);

CREATE TABLE IF NOT EXISTS support_ticket (
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id     BIGINT            NOT NULL REFERENCES customer(id) ON DELETE CASCADE,
    subject         VARCHAR(200)      NOT NULL,
    description     TEXT              NOT NULL,
    status          VARCHAR(16)       NOT NULL,
    created_at      TIMESTAMPTZ       NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ       NOT NULL DEFAULT now(),
    CONSTRAINT support_ticket_status_ck CHECK (status IN ('OPEN','IN_PROGRESS','RESOLVED','CLOSED'))
);

CREATE INDEX IF NOT EXISTS idx_ticket_customer ON support_ticket(customer_id);
CREATE INDEX IF NOT EXISTS idx_ticket_status   ON support_ticket(status);

COMMIT;
