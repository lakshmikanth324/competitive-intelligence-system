import os

from sqlalchemy import create_engine
from sqlalchemy.engine import Engine

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "mysql+pymysql://root:password@localhost:3306/competitive_intelligence",
)


def get_engine() -> Engine:
    """Create a SQLAlchemy engine using DATABASE_URL from the environment."""
    return create_engine(DATABASE_URL, pool_pre_ping=True)
