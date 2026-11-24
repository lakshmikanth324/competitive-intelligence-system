from dataclasses import dataclass
from datetime import datetime
from decimal import Decimal


@dataclass
class Product:
    product_id: int | None
    sku: str
    product_name: str
    category_id: int | None = None
    brand: str | None = None
    model_number: str | None = None
    cost_price: Decimal | None = None
    selling_price: Decimal | None = None
    status: str = "ACTIVE"


@dataclass
class CompetitorProduct:
    competitor_product_id: int | None
    retailer_id: int
    product_title: str
    competitor_sku: str | None = None
    brand: str | None = None
    model_number: str | None = None
    product_url: str | None = None
    collected_at: datetime | None = None
