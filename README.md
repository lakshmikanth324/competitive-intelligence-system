# E-commerce Competitive Intelligence System

Starter implementation of a competitive intelligence pipeline, MySQL database schema, sample data, and Streamlit dashboard.

## Database setup

The schema defines 26 tables and uses MySQL with InnoDB foreign keys.

1. Open a MySQL client or Workbench and run `database/schema.sql`.
2. Run `database/indexes.sql`.
3. Run `database/sample_data.sql` to load demo records.
4. Use `database/queries.sql` to try example comparisons and verify the database.

The sample inserts assume a fresh database. Demo password hashes are placeholders and must not be used for authentication.

## Python setup

```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\\Scripts\\activate
pip install -r requirements.txt
```

Set `DATABASE_URL` to your MySQL connection string before using the database connection helper. The default is `mysql+pymysql://root:password@localhost:3306/competitive_intelligence`.

Run the sample workflow with `python main.py`, or launch the dashboard with `streamlit run dashboard/app.py`.
