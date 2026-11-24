class PredictionAgent:
    """Provides a simple first-to-last price trend estimate."""

    def run(self, historical_prices: list[float]) -> dict:
        if len(historical_prices) < 2:
            return {"direction": "insufficient_data", "change_percent": 0.0}
        start, end = historical_prices[0], historical_prices[-1]
        change = ((end - start) / start * 100) if start else 0.0
        direction = "up" if change > 0 else "down" if change < 0 else "flat"
        return {"direction": direction, "change_percent": round(change, 2)}
