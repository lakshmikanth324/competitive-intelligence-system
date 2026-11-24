USE competitive_intelligence;

INSERT INTO users (username, email, password_hash) VALUES
('Admin', 'admin@example.com', 'demo_hash'),
('Analyst', 'analyst@example.com', 'demo_hash'),
('Reviewer', 'reviewer@example.com', 'demo_hash');

INSERT INTO roles (role_name) VALUES
('ADMIN'), ('DATA_ANALYST'), ('DATA_REVIEWER');

INSERT INTO user_roles (user_id, role_id) VALUES (1, 1), (2, 2), (3, 3);

INSERT INTO retailers (retailer_name, retailer_type, country) VALUES
('Amazon', 'Ecommerce', 'India'),
('Walmart', 'Ecommerce', 'USA'),
('Target', 'Ecommerce', 'USA'),
('Best Buy', 'Electronics Retailer', 'USA');

INSERT INTO retailer_websites (retailer_id, website_url, country, currency) VALUES
(1, 'https://www.amazon.in', 'India', 'INR'),
(2, 'https://www.walmart.com', 'USA', 'USD'),
(3, 'https://www.target.com', 'USA', 'USD'),
(4, 'https://www.bestbuy.com', 'USA', 'USD');

INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Electronic products');
INSERT INTO categories (parent_category_id, category_name, description) VALUES
(1, 'Televisions', 'TV products'),
(1, 'Laptops', 'Laptop computers');

INSERT INTO products
(sku, product_name, category_id, brand, model_number, cost_price, selling_price) VALUES
('TV001', 'Samsung 55 Inch 4K TV', 2, 'Samsung', 'QA55Q60', 35000, 42000),
('TV002', 'LG 50 Inch Smart TV', 2, 'LG', 'UR7500', 30000, 38000),
('LP001', 'Dell Inspiron Laptop', 3, 'Dell', 'INS15', 45000, 55000);

INSERT INTO attributes (attribute_name, data_type) VALUES
('Screen Size', 'VARCHAR'), ('Resolution', 'VARCHAR'),
('RAM', 'VARCHAR'), ('Storage', 'VARCHAR');

INSERT INTO product_attributes (product_id, attribute_id, attribute_value) VALUES
(1, 1, '55 Inch'), (1, 2, '4K UHD'),
(2, 1, '50 Inch'), (2, 2, '4K UHD'),
(3, 3, '16 GB'), (3, 4, '512 GB SSD');

INSERT INTO competitor_products
(retailer_id, competitor_sku, product_title, brand, model_number, product_url) VALUES
(1, 'AMZ-TV001', 'Samsung 55 Inch 4K Smart TV', 'Samsung', 'QA55Q60', 'https://www.amazon.in/'),
(2, 'WAL-TV001', 'Samsung 55 Inch UHD Television', 'Samsung', 'QA55Q60', 'https://www.walmart.com/'),
(3, 'TGT-TV001', 'Samsung 55 Inch Smart Television', 'Samsung', 'QA55Q60', 'https://www.target.com/'),
(4, 'BB-TV001', 'Samsung 55 Inch QLED TV', 'Samsung', 'QA55Q60', 'https://www.bestbuy.com/');

INSERT INTO competitor_matches
(product_id, competitor_product_id, match_score, match_method, match_status) VALUES
(1, 1, 0.9900, 'MODEL_NUMBER', 'APPROVED'),
(1, 2, 0.9800, 'MODEL_NUMBER', 'APPROVED'),
(1, 3, 0.9700, 'ATTRIBUTE_MATCH', 'APPROVED'),
(1, 4, 0.9600, 'MODEL_NUMBER', 'PENDING');

INSERT INTO match_reviews (match_id, user_id, decision, comments) VALUES
(1, 3, 'APPROVED', 'Model number verified.'),
(4, 3, 'PENDING', 'Requires manual confirmation.');

INSERT INTO price_history (competitor_product_id, selling_price, discount_price, currency) VALUES
(1, 45000, 42000, 'INR'), (2, 44000, 41000, 'INR'),
(3, 46000, 43000, 'INR'), (4, 45500, 42500, 'INR');

INSERT INTO own_price_history (product_id, selling_price) VALUES
(1, 42000), (2, 38000), (3, 55000);

INSERT INTO inventory_history (competitor_product_id, stock_quantity, availability_status) VALUES
(1, 12, 'IN_STOCK'), (2, 8, 'IN_STOCK'), (3, 0, 'OUT_OF_STOCK'), (4, 5, 'LIMITED');

INSERT INTO promotions (competitor_product_id, promotion_type, discount_percentage, start_date, end_date) VALUES
(1, 'SALE', 6.67, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY));

INSERT INTO scrape_jobs (retailer_id, job_name, source_url, job_status, scheduled_at) VALUES
(1, 'Amazon product sample', 'https://www.amazon.in/', 'COMPLETED', NOW());

INSERT INTO scrape_runs (job_id, started_at, completed_at, records_collected, run_status) VALUES
(1, NOW(), NOW(), 1, 'COMPLETED');

INSERT INTO scraped_records (run_id, source_product_url, raw_data) VALUES
(1, 'https://www.amazon.in/', JSON_OBJECT('title', 'Samsung 55 Inch 4K Smart TV', 'price', 42000, 'currency', 'INR'));

INSERT INTO ai_agents (agent_name, agent_type, model_name, description, status) VALUES
('Data Extraction Agent', 'Extraction', 'Ollama', 'Collects competitor product data', 'ACTIVE'),
('Data Quality Agent', 'Validation', 'Ollama', 'Validates product datasets', 'ACTIVE'),
('Attribute Extraction Agent', 'NLP', 'Mistral', 'Extracts product specifications', 'ACTIVE'),
('Product Matching Agent', 'Matching', 'Ollama', 'Matches own and competitor SKUs', 'ACTIVE'),
('Price Intelligence Agent', 'Analytics', 'Ollama', 'Tracks competitor pricing', 'ACTIVE'),
('Price Prediction Agent', 'Machine Learning', 'XGBoost', 'Predicts product prices', 'ACTIVE'),
('Price Recommendation Agent', 'Optimization', 'Ollama', 'Generates pricing recommendations', 'ACTIVE'),
('Reviewer Agent', 'Validation', 'Ollama', 'Reviews AI-generated results', 'ACTIVE');

INSERT INTO agent_executions (agent_id, run_id, started_at, completed_at, execution_status) VALUES
(1, 1, NOW(), NOW(), 'COMPLETED');
INSERT INTO agent_logs (execution_id, log_level, log_message) VALUES
(1, 'INFO', 'Sample extraction completed.');

INSERT INTO model_versions (model_name, version_number, algorithm, trained_at) VALUES
('Price Forecast Model', '1.0.0', 'XGBoost', NOW());
INSERT INTO model_predictions (product_id, model_version_id, predicted_price, confidence_score) VALUES
(1, 1, 41500, 0.8750);
INSERT INTO price_recommendations
(product_id, prediction_id, recommended_price, recommendation_reason, approval_status) VALUES
(1, 1, 41999, 'Remain competitive while preserving margin.', 'PENDING');
INSERT INTO audit_logs (user_id, action, entity_name, entity_id) VALUES
(1, 'SEED_DATA_LOADED', 'competitive_intelligence', 1);
