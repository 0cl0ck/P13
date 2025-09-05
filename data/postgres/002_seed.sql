-- Your Car Your Way – Seed data (PostgreSQL)
-- Minimal dataset for demo/testing

BEGIN;

-- Customers
INSERT INTO customer (first_name, last_name, email, password_hash)
VALUES
  ('Alice', 'Martin', 'alice.martin@example.com', '$2b$10$abcdefghijkhashsamplealice'),
  ('Bob', 'Durand', 'bob.durand@example.com', '$2b$10$lmnopqrstuvwhashsamplebob')
ON CONFLICT (email) DO NOTHING;

-- Vehicles (ACRISS examples)
INSERT INTO vehicle (model, acriss_code, daily_rate)
VALUES
  ('Volkswagen Golf', 'CDMR', 45.00),
  ('Toyota Yaris',    'ECMN', 30.00),
  ('Peugeot 3008',    'IFAR', 65.00)
ON CONFLICT DO NOTHING;

-- Reservations
-- Pick existing ids to avoid FK issues
WITH c AS (
  SELECT id FROM customer WHERE email = 'alice.martin@example.com'
), v AS (
  SELECT id FROM vehicle WHERE model = 'Volkswagen Golf'
)
INSERT INTO reservation (customer_id, vehicle_id, start_date, end_date, status)
SELECT c.id, v.id, now() + interval '2 days', now() + interval '5 days', 'CONFIRMED'
FROM c, v
ON CONFLICT DO NOTHING;

-- Support tickets
WITH c AS (
  SELECT id FROM customer WHERE email = 'bob.durand@example.com'
)
INSERT INTO support_ticket (customer_id, subject, description, status)
SELECT c.id, 'Problème de réservation', 'Je souhaite modifier les dates de ma réservation.', 'OPEN'
FROM c
ON CONFLICT DO NOTHING;

COMMIT;
