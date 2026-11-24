from dataclasses import dataclass
from typing import Any


@dataclass
class ExtractedRecord:
    source: str
    payload: dict[str, Any]


class ExtractionAgent:
    """Accepts a raw record from a configured data source."""

    def run(self, source: str, payload: dict[str, Any]) -> ExtractedRecord:
        if not payload:
            raise ValueError("Extraction payload cannot be empty")
        return ExtractedRecord(source=source, payload=payload)
