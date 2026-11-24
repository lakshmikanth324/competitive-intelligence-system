CREATE DATABASE IF NOT EXISTS competitive_intelligence
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE competitive_intelligence;

-- Run this file against a new/empty database. Tables are ordered before their dependents.

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255),
    status VARCHAR(30) DEFAULT 'ACTIVE',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(100) UNIQUE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE user_roles (
    user_role_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    UNIQUE (user_id, role_id)
) ENGINE=InnoDB;

CREATE TABLE retailers (
    retailer_id INT AUTO_INCREMENT PRIMARY KEY,
    retailer_name VARCHAR(150) NOT NULL,
    retailer_type VARCHAR(100),
    country VARCHAR(100),
    status VARCHAR(30) DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

CREATE TABLE retailer_websites (
    website_id INT AUTO_INCREMENT PRIMARY KEY,
    retailer_id INT NOT NULL,
    website_url VARCHAR(500),
    country VARCHAR(100),
    currency VARCHAR(10),
    FOREIGN KEY (retailer_id) REFERENCES retailers(retailer_id)
) ENGINE=InnoDB;

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    parent_category_id INT NULL,
    category_name VARCHAR(150) NOT NULL,
    description TEXT,
    FOREIGN KEY (parent_category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(100) UNIQUE NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    category_id INT,
    brand VARCHAR(100),
    model_number VARCHAR(100),
    cost_price DECIMAL(12,2),
    selling_price DECIMAL(12,2),
    status VARCHAR(30) DEFAULT 'ACTIVE',
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
) ENGINE=InnoDB;

CREATE TABLE attributes (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_name VARCHAR(150) NOT NULL,
    data_type VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE product_attributes (
    product_attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    attribute_id INT NOT NULL,
    attribute_value VARCHAR(500),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (attribute_id) REFERENCES attributes(attribute_id),
    UNIQUE (product_id, attribute_id)
) ENGINE=InnoDB;

CREATE TABLE competitor_products (
    competitor_product_id INT AUTO_INCREMENT PRIMARY KEY,
    retailer_id INT NOT NULL,
    competitor_sku VARCHAR(100),
    product_title VARCHAR(500) NOT NULL,
    brand VARCHAR(100),
    model_number VARCHAR(100),
    product_url VARCHAR(1000),
    collected_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (retailer_id) REFERENCES retailers(retailer_id)
) ENGINE=InnoDB;

CREATE TABLE competitor_matches (
    match_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    competitor_product_id INT NOT NULL,
    match_score DECIMAL(5,4),
    match_method VARCHAR(100),
    match_status VARCHAR(30) DEFAULT 'PENDING',
    matched_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (competitor_product_id) REFERENCES competitor_products(competitor_product_id),
    UNIQUE (product_id, competitor_product_id)
) ENGINE=InnoDB;

CREATE TABLE match_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT NOT NULL,
    user_id INT NOT NULL,
    decision VARCHAR(30),
    comments TEXT,
    reviewed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (match_id) REFERENCES competitor_matches(match_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB;

CREATE TABLE scrape_jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    retailer_id INT NOT NULL,
    job_name VARCHAR(150),
    source_url VARCHAR(1000),
    job_status VARCHAR(30),
    scheduled_at DATETIME,
    FOREIGN KEY (retailer_id) REFERENCES retailers(retailer_id)
) ENGINE=InnoDB;

CREATE TABLE scrape_runs (
    run_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    started_at DATETIME,
    completed_at DATETIME,
    records_collected INT DEFAULT 0,
    run_status VARCHAR(30),
    FOREIGN KEY (job_id) REFERENCES scrape_jobs(job_id)
) ENGINE=InnoDB;

CREATE TABLE scraped_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    run_id INT NOT NULL,
    source_product_url VARCHAR(1000),
    raw_data JSON,
    scraped_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (run_id) REFERENCES scrape_runs(run_id)
) ENGINE=InnoDB;

CREATE TABLE price_history (
    price_history_id INT AUTO_INCREMENT PRIMARY KEY,
    competitor_product_id INT NOT NULL,
    selling_price DECIMAL(12,2),
    discount_price DECIMAL(12,2),
    currency VARCHAR(10) DEFAULT 'INR',
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (competitor_product_id) REFERENCES competitor_products(competitor_product_id)
) ENGINE=InnoDB;

CREATE TABLE own_price_history (
    own_price_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    selling_price DECIMAL(12,2),
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
) ENGINE=InnoDB;

CREATE TABLE inventory_history (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    competitor_product_id INT NOT NULL,
    stock_quantity INT,
    availability_status VARCHAR(50),
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (competitor_product_id) REFERENCES competitor_products(competitor_product_id)
) ENGINE=InnoDB;

CREATE TABLE promotions (
    promotion_id INT AUTO_INCREMENT PRIMARY KEY,
    competitor_product_id INT NOT NULL,
    promotion_type VARCHAR(100),
    discount_percentage DECIMAL(5,2),
    start_date DATETIME,
    end_date DATETIME,
    FOREIGN KEY (competitor_product_id) REFERENCES competitor_products(competitor_product_id)
) ENGINE=InnoDB;

CREATE TABLE ai_agents (
    agent_id INT AUTO_INCREMENT PRIMARY KEY,
    agent_name VARCHAR(150) NOT NULL,
    agent_type VARCHAR(100),
    model_name VARCHAR(100),
    description TEXT,
    status VARCHAR(30)
) ENGINE=InnoDB;

CREATE TABLE agent_executions (
    execution_id INT AUTO_INCREMENT PRIMARY KEY,
    agent_id INT NOT NULL,
    run_id INT,
    started_at DATETIME,
    completed_at DATETIME,
    execution_status VARCHAR(30),
    FOREIGN KEY (agent_id) REFERENCES ai_agents(agent_id),
    FOREIGN KEY (run_id) REFERENCES scrape_runs(run_id)
) ENGINE=InnoDB;

CREATE TABLE agent_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    execution_id INT NOT NULL,
    log_level VARCHAR(30),
    log_message TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (execution_id) REFERENCES agent_executions(execution_id)
) ENGINE=InnoDB;

CREATE TABLE model_versions (
    model_version_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(150),
    version_number VARCHAR(50),
    algorithm VARCHAR(100),
    trained_at DATETIME
) ENGINE=InnoDB;

CREATE TABLE model_predictions (
    prediction_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    model_version_id INT NOT NULL,
    predicted_price DECIMAL(12,2),
    confidence_score DECIMAL(5,4),
    predicted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (model_version_id) REFERENCES model_versions(model_version_id)
) ENGINE=InnoDB;

CREATE TABLE price_recommendations (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    prediction_id INT NOT NULL,
    recommended_price DECIMAL(12,2),
    recommendation_reason TEXT,
    approval_status VARCHAR(30) DEFAULT 'PENDING',
    approved_by INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (prediction_id) REFERENCES model_predictions(prediction_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id)
) ENGINE=InnoDB;

CREATE TABLE audit_logs (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(150),
    entity_name VARCHAR(150),
    entity_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB;
