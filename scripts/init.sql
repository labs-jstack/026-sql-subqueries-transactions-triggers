-- Create DB
DROP DATABASE IF EXISTS live026;
CREATE DATABASE live026;

\c live026

-- Create Tables
DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(60),
    email VARCHAR(256) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    amount NUMERIC(7,2)
);

--Seed DB
DO $$
DECLARE
    i INT := 1;
    customer_id INT;
    created_customers INT := 0;
BEGIN
    WHILE i <= 20 LOOP
        INSERT INTO customers(first_name, last_name, email)
        VALUES ('Customer-' || i, 'Doe-' || i, 'customer.' || i || '@email.com')
        RETURNING id INTO customer_id;

        INSERT INTO orders(amount, customer_id)
        VALUES (RANDOM() * 1000, customer_id);

        i := i + 1;
        created_customers := created_customers + 1;
    END LOOP;

    RAISE NOTICE '% customers succesfully created', created_customers;
END $$;