USE competitive_intelligence;

-- Compare a product against its matched competitor listings and latest prices.
SELECT
    p.sku,
    p.product_name,
    r.retailer_name,
    cp.product_title,
    ph.selling_price AS competitor_price,
    p.selling_price AS own_price,
    cm.match_score
FROM products p
JOIN competitor_matches cm ON p.product_id = cm.product_id
JOIN competitor_products cp ON cm.competitor_product_id = cp.competitor_product_id
JOIN retailers r ON cp.retailer_id = r.retailer_id
LEFT JOIN price_history ph
    ON cp.competitor_product_id = ph.competitor_product_id
WHERE p.sku = 'TV001'
ORDER BY ph.recorded_at DESC;

-- Find competitor listings priced below your current product price.
SELECT
    p.sku,
    r.retailer_name,
    ph.selling_price AS competitor_price,
    p.selling_price AS our_price
FROM products p
JOIN competitor_matches cm ON p.product_id = cm.product_id
JOIN competitor_products cp ON cm.competitor_product_id = cp.competitor_product_id
JOIN retailers r ON cp.retailer_id = r.retailer_id
JOIN price_history ph ON cp.competitor_product_id = ph.competitor_product_id
WHERE ph.selling_price < p.selling_price;

-- Find products with pending matching reviews.
SELECT
    p.sku,
    p.product_name,
    cp.product_title,
    cm.match_score,
    cm.match_status
FROM competitor_matches cm
JOIN products p ON cm.product_id = p.product_id
JOIN competitor_products cp ON cm.competitor_product_id = cp.competitor_product_id
WHERE cm.match_status = 'PENDING';

-- Verify table count and list tables in the configured database.
SHOW TABLES;
SELECT COUNT(*) AS total_tables
FROM information_schema.tables
WHERE table_schema = 'competitive_intelligence';

SELECT * FROM products;
SELECT * FROM competitor_products;
SELECT * FROM competitor_matches;
SELECT * FROM price_history;
SELECT * FROM ai_agents;
