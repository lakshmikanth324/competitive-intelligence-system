USE competitive_intelligence;

CREATE INDEX idx_product_brand ON products(brand);
CREATE INDEX idx_product_category ON products(category_id);
CREATE INDEX idx_competitor_retailer ON competitor_products(retailer_id);
CREATE INDEX idx_competitor_brand ON competitor_products(brand);
CREATE INDEX idx_match_status ON competitor_matches(match_status);
CREATE INDEX idx_price_date ON price_history(competitor_product_id, recorded_at);
CREATE INDEX idx_own_price_date ON own_price_history(product_id, recorded_at);
CREATE INDEX idx_prediction_product ON model_predictions(product_id, predicted_at);
CREATE INDEX idx_scrape_run ON scrape_runs(job_id, run_status);
