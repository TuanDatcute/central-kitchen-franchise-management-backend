-- CenFra mock data seed for PostgreSQL/RDS dev or test databases.
-- Run this manually against a non-production database.
-- Mock user password for all inserted users: password

BEGIN;

INSERT INTO role (role_name) VALUES
  ('ADMIN'),
  ('MANAGER'),
  ('SUPPLY_COORDINATOR'),
  ('CENTRAL_KITCHEN_STAFF'),
  ('FRANCHISE_STORE_STAFF')
ON CONFLICT (role_name) DO NOTHING;

INSERT INTO stores (store_id, store_name, address, phone, status) VALUES
  (9001, 'CenFra District 1', '12 Nguyen Hue, District 1, Ho Chi Minh City', '0901000001', 'ACTIVE'),
  (9002, 'CenFra District 7', '45 Nguyen Thi Thap, District 7, Ho Chi Minh City', '0901000002', 'ACTIVE'),
  (9003, 'CenFra Thu Duc', '88 Vo Van Ngan, Thu Duc City, Ho Chi Minh City', '0901000003', 'INACTIVE')
ON CONFLICT (store_id) DO UPDATE
SET store_name = EXCLUDED.store_name,
    address = EXCLUDED.address,
    phone = EXCLUDED.phone,
    status = EXCLUDED.status;

INSERT INTO users (user_id, user_name, password, full_name, email, store_id, role_id, status) VALUES
  (9001, 'admin.mock', '$2a$10$lZ/bYeM2ag0Svsszq5cTX.bCEOyPBvBJCmkxz0BNqIiFjhsFFe59i', 'Mock Admin', 'admin.mock@cenfra.test', NULL, (SELECT role_id FROM role WHERE role_name = 'ADMIN'), 'ACTIVE'),
  (9002, 'manager.mock', '$2a$10$lZ/bYeM2ag0Svsszq5cTX.bCEOyPBvBJCmkxz0BNqIiFjhsFFe59i', 'Mock Manager', 'manager.mock@cenfra.test', NULL, (SELECT role_id FROM role WHERE role_name = 'MANAGER'), 'ACTIVE'),
  (9003, 'kitchen.mock', '$2a$10$lZ/bYeM2ag0Svsszq5cTX.bCEOyPBvBJCmkxz0BNqIiFjhsFFe59i', 'Central Kitchen Staff', 'kitchen.mock@cenfra.test', NULL, (SELECT role_id FROM role WHERE role_name = 'CENTRAL_KITCHEN_STAFF'), 'ACTIVE'),
  (9004, 'store.d1.mock', '$2a$10$lZ/bYeM2ag0Svsszq5cTX.bCEOyPBvBJCmkxz0BNqIiFjhsFFe59i', 'District 1 Store Staff', 'store.d1.mock@cenfra.test', 9001, (SELECT role_id FROM role WHERE role_name = 'FRANCHISE_STORE_STAFF'), 'ACTIVE')
ON CONFLICT (user_name) DO UPDATE
SET password = EXCLUDED.password,
    full_name = EXCLUDED.full_name,
    email = EXCLUDED.email,
    store_id = EXCLUDED.store_id,
    role_id = EXCLUDED.role_id,
    status = EXCLUDED.status;

INSERT INTO units (unit_name, description, status) VALUES
  ('kg', 'Kilogram', 'ACTIVE'),
  ('pack', 'Packaged item', 'ACTIVE'),
  ('box', 'Box', 'ACTIVE')
ON CONFLICT (unit_name) DO UPDATE
SET description = EXCLUDED.description,
    status = EXCLUDED.status;

INSERT INTO categories (category_id, category_name, status) VALUES
  (9001, 'Prepared Food', 'ACTIVE'),
  (9002, 'Raw Ingredient', 'ACTIVE'),
  (9003, 'Beverage', 'ACTIVE')
ON CONFLICT (category_id) DO UPDATE
SET category_name = EXCLUDED.category_name,
    status = EXCLUDED.status;

INSERT INTO products (
  product_id,
  product_name,
  unit_id,
  image_url,
  description,
  status,
  price,
  shelf_life_days,
  order_multiplier,
  category_id
) VALUES
  (9001, 'Chicken Rice Meal', (SELECT unit_id FROM units WHERE unit_name = 'pack'), 'https://example.test/images/chicken-rice-meal.jpg', 'Prepared chicken rice meal for franchise stores.', 'ACTIVE', 45000.00, 2, 5, 9001),
  (9002, 'Beef Pho Broth', (SELECT unit_id FROM units WHERE unit_name = 'kg'), 'https://example.test/images/beef-pho-broth.jpg', 'Central kitchen pho broth.', 'ACTIVE', 70000.00, 3, 10, 9001),
  (9003, 'Fresh Noodles', (SELECT unit_id FROM units WHERE unit_name = 'kg'), 'https://example.test/images/fresh-noodles.jpg', 'Fresh noodles for daily franchise operations.', 'ACTIVE', 30000.00, 1, 5, 9002)
ON CONFLICT (product_id) DO UPDATE
SET product_name = EXCLUDED.product_name,
    unit_id = EXCLUDED.unit_id,
    image_url = EXCLUDED.image_url,
    description = EXCLUDED.description,
    status = EXCLUDED.status,
    price = EXCLUDED.price,
    shelf_life_days = EXCLUDED.shelf_life_days,
    order_multiplier = EXCLUDED.order_multiplier,
    category_id = EXCLUDED.category_id;

INSERT INTO manufacturing_orders (
  manu_order_id,
  order_code,
  start_date,
  end_date,
  status,
  created_by,
  product_id,
  quantity_planned
) VALUES
  (9001, 'MO-20260728-001', '2026-07-28T01:00:00Z', '2026-07-28T05:00:00Z', 'COMPLETED', (SELECT user_id FROM users WHERE user_name = 'kitchen.mock'), 9001, 100),
  (9002, 'MO-20260728-002', '2026-07-28T02:00:00Z', NULL, 'COOKING', (SELECT user_id FROM users WHERE user_name = 'kitchen.mock'), 9002, 80)
ON CONFLICT (manu_order_id) DO UPDATE
SET order_code = EXCLUDED.order_code,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    status = EXCLUDED.status,
    created_by = EXCLUDED.created_by,
    product_id = EXCLUDED.product_id,
    quantity_planned = EXCLUDED.quantity_planned;

INSERT INTO product_batches (
  batch_id,
  batch_code,
  product_id,
  manu_order_id,
  initial_quantity,
  current_quantity,
  manufacturing_date,
  expiry_date,
  status
) VALUES
  (9001, 'BATCH-CR-20260728-001', 9001, 9001, 100, 70, '2026-07-28', '2026-07-30', 'AVAILABLE'),
  (9002, 'BATCH-PB-20260728-001', 9002, 9002, 80, 80, '2026-07-28', '2026-07-31', 'AVAILABLE')
ON CONFLICT (batch_id) DO UPDATE
SET batch_code = EXCLUDED.batch_code,
    product_id = EXCLUDED.product_id,
    manu_order_id = EXCLUDED.manu_order_id,
    initial_quantity = EXCLUDED.initial_quantity,
    current_quantity = EXCLUDED.current_quantity,
    manufacturing_date = EXCLUDED.manufacturing_date,
    expiry_date = EXCLUDED.expiry_date,
    status = EXCLUDED.status;

INSERT INTO store_orders (
  order_id,
  order_code,
  store_id,
  order_date,
  delivery_date,
  received_at,
  status
) VALUES
  (9001, 'SO-20260728-D1-001', 9001, '2026-07-28T08:30:00', '2026-07-29', NULL, 'PENDING'),
  (9002, 'SO-20260728-D7-001', 9002, '2026-07-28T09:00:00', '2026-07-29', NULL, 'IN_TRANSIT')
ON CONFLICT (order_id) DO UPDATE
SET order_code = EXCLUDED.order_code,
    store_id = EXCLUDED.store_id,
    order_date = EXCLUDED.order_date,
    delivery_date = EXCLUDED.delivery_date,
    received_at = EXCLUDED.received_at,
    status = EXCLUDED.status;

INSERT INTO order_details (detail_id, order_id, product_id, quantity, unit_price) VALUES
  (9001, 9001, 9001, 10, 45000.00),
  (9002, 9001, 9002, 20, 70000.00),
  (9003, 9002, 9001, 15, 45000.00),
  (9004, 9002, 9003, 10, 30000.00)
ON CONFLICT (detail_id) DO UPDATE
SET order_id = EXCLUDED.order_id,
    product_id = EXCLUDED.product_id,
    quantity = EXCLUDED.quantity,
    unit_price = EXCLUDED.unit_price;

INSERT INTO deliveries (
  delivery_id,
  delivery_code,
  driver_name,
  vehicle_plate,
  scheduled_date,
  actual_start_date,
  actual_end_date,
  status,
  created_by,
  created_at,
  cancelled_notes_snapshot
) VALUES
  (9001, 'DEL-20260729-001', 'Mock Driver', '51C-12345', '2026-07-29T08:00:00+07:00', '2026-07-29T08:05:00+07:00', NULL, 'IN_TRANSIT', (SELECT user_id FROM users WHERE user_name = 'kitchen.mock'), '2026-07-28T15:30:00+07:00', NULL)
ON CONFLICT (delivery_id) DO UPDATE
SET delivery_code = EXCLUDED.delivery_code,
    driver_name = EXCLUDED.driver_name,
    vehicle_plate = EXCLUDED.vehicle_plate,
    scheduled_date = EXCLUDED.scheduled_date,
    actual_start_date = EXCLUDED.actual_start_date,
    actual_end_date = EXCLUDED.actual_end_date,
    status = EXCLUDED.status,
    created_by = EXCLUDED.created_by,
    created_at = EXCLUDED.created_at,
    cancelled_notes_snapshot = EXCLUDED.cancelled_notes_snapshot;

INSERT INTO delivery_issues (
  issue_id,
  store_order_id,
  replacement_order_id,
  status,
  reported_order_status,
  issue_reason,
  issue_note,
  total_quantity,
  affected_quantity,
  issue_items_json,
  recommended_resolution,
  reported_by,
  reported_at,
  reviewed_by,
  reviewed_at,
  review_decision,
  selected_resolution,
  image_urls
) VALUES
  (9001, 9002, NULL, 'PENDING_REVIEW', 'IN_TRANSIT', 'DAMAGED', 'Two packs were damaged during delivery.', 25, 2, '[{"productId":9001,"quantity":2,"note":"Damaged package"}]', 'REPLACE_PARTIAL', (SELECT user_id FROM users WHERE user_name = 'store.d1.mock'), '2026-07-29T10:15:00', NULL, NULL, NULL, NULL, '["https://example.test/images/delivery-issue-001.jpg"]')
ON CONFLICT (issue_id) DO UPDATE
SET store_order_id = EXCLUDED.store_order_id,
    replacement_order_id = EXCLUDED.replacement_order_id,
    status = EXCLUDED.status,
    reported_order_status = EXCLUDED.reported_order_status,
    issue_reason = EXCLUDED.issue_reason,
    issue_note = EXCLUDED.issue_note,
    total_quantity = EXCLUDED.total_quantity,
    affected_quantity = EXCLUDED.affected_quantity,
    issue_items_json = EXCLUDED.issue_items_json,
    recommended_resolution = EXCLUDED.recommended_resolution,
    reported_by = EXCLUDED.reported_by,
    reported_at = EXCLUDED.reported_at,
    reviewed_by = EXCLUDED.reviewed_by,
    reviewed_at = EXCLUDED.reviewed_at,
    review_decision = EXCLUDED.review_decision,
    selected_resolution = EXCLUDED.selected_resolution,
    image_urls = EXCLUDED.image_urls;

INSERT INTO inventory_receipts (receipt_id, receipt_code, receipt_date, status, created_by) VALUES
  (9001, 'IR-20260728-001', '2026-07-28T06:00:00Z', 'COMPLETED', (SELECT user_id FROM users WHERE user_name = 'kitchen.mock'))
ON CONFLICT (receipt_id) DO UPDATE
SET receipt_code = EXCLUDED.receipt_code,
    receipt_date = EXCLUDED.receipt_date,
    status = EXCLUDED.status,
    created_by = EXCLUDED.created_by;

INSERT INTO receipt_items (receipt_item_id, receipt_id, product_batch_id, quantity) VALUES
  (9001, 9001, 9001, 100),
  (9002, 9001, 9002, 80)
ON CONFLICT (receipt_item_id) DO UPDATE
SET receipt_id = EXCLUDED.receipt_id,
    product_batch_id = EXCLUDED.product_batch_id,
    quantity = EXCLUDED.quantity;

INSERT INTO inventory_transactions (
  transaction_id,
  product_batch_id,
  transaction_type,
  quantity,
  reference_code,
  transaction_date,
  created_by,
  note
) VALUES
  (9001, 9001, 'IMPORT', 100, 'IR-20260728-001', '2026-07-28T06:00:00+07:00', (SELECT user_id FROM users WHERE user_name = 'kitchen.mock'), 'Mock import for local UI testing'),
  (9002, 9002, 'IMPORT', 80, 'IR-20260728-001', '2026-07-28T06:00:00+07:00', (SELECT user_id FROM users WHERE user_name = 'kitchen.mock'), 'Mock import for local UI testing')
ON CONFLICT (transaction_id) DO UPDATE
SET product_batch_id = EXCLUDED.product_batch_id,
    transaction_type = EXCLUDED.transaction_type,
    quantity = EXCLUDED.quantity,
    reference_code = EXCLUDED.reference_code,
    transaction_date = EXCLUDED.transaction_date,
    created_by = EXCLUDED.created_by,
    note = EXCLUDED.note;

SELECT setval(pg_get_serial_sequence('role', 'role_id'), COALESCE((SELECT MAX(role_id) FROM role), 1), true);
SELECT setval(pg_get_serial_sequence('stores', 'store_id'), COALESCE((SELECT MAX(store_id) FROM stores), 1), true);
SELECT setval(pg_get_serial_sequence('users', 'user_id'), COALESCE((SELECT MAX(user_id) FROM users), 1), true);
SELECT setval(pg_get_serial_sequence('units', 'unit_id'), COALESCE((SELECT MAX(unit_id) FROM units), 1), true);
SELECT setval(pg_get_serial_sequence('categories', 'category_id'), COALESCE((SELECT MAX(category_id) FROM categories), 1), true);
SELECT setval(pg_get_serial_sequence('products', 'product_id'), COALESCE((SELECT MAX(product_id) FROM products), 1), true);
SELECT setval(pg_get_serial_sequence('manufacturing_orders', 'manu_order_id'), COALESCE((SELECT MAX(manu_order_id) FROM manufacturing_orders), 1), true);
SELECT setval(pg_get_serial_sequence('product_batches', 'batch_id'), COALESCE((SELECT MAX(batch_id) FROM product_batches), 1), true);
SELECT setval(pg_get_serial_sequence('store_orders', 'order_id'), COALESCE((SELECT MAX(order_id) FROM store_orders), 1), true);
SELECT setval(pg_get_serial_sequence('order_details', 'detail_id'), COALESCE((SELECT MAX(detail_id) FROM order_details), 1), true);
SELECT setval(pg_get_serial_sequence('deliveries', 'delivery_id'), COALESCE((SELECT MAX(delivery_id) FROM deliveries), 1), true);
SELECT setval(pg_get_serial_sequence('delivery_issues', 'issue_id'), COALESCE((SELECT MAX(issue_id) FROM delivery_issues), 1), true);
SELECT setval(pg_get_serial_sequence('inventory_receipts', 'receipt_id'), COALESCE((SELECT MAX(receipt_id) FROM inventory_receipts), 1), true);
SELECT setval(pg_get_serial_sequence('receipt_items', 'receipt_item_id'), COALESCE((SELECT MAX(receipt_item_id) FROM receipt_items), 1), true);
SELECT setval(pg_get_serial_sequence('inventory_transactions', 'transaction_id'), COALESCE((SELECT MAX(transaction_id) FROM inventory_transactions), 1), true);

COMMIT;
