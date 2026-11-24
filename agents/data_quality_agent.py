from collections.abc import Iterable


class DataQualityAgent:
    """Normalizes simple records and skips invalid entries."""

    def run(self, records: Iterable[dict]) -> list[dict]:
        cleaned = []
        for record in records:
            if not isinstance(record, dict):
                continue
            normalized = {
                key.strip().lower(): value
                for key, value in record.items()
                if isinstance(key, str) and key.strip() and value is not None
            }
            if normalized:
                cleaned.append(normalized)
        return cleaned
