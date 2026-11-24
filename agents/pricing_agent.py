from decimal import Decimal, InvalidOperation


class PricingAgent:
    """Validates and normalizes a monetary amount."""

    def run(self, price: str | int | float, currency: str = "INR") -> dict:
        try:
            normalized = Decimal(str(price))
        except (InvalidOperation, ValueError) as exc:
            raise ValueError("Invalid price") from exc
        if normalized < 0:
            raise ValueError("Price cannot be negative")
        return {"price": normalized.quantize(Decimal("0.01")), "currency": currency.upper()}
