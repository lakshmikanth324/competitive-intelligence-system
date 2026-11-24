from agents.attribute_agent import AttributeAgent
from agents.data_quality_agent import DataQualityAgent
from agents.extraction_agent import ExtractionAgent
from agents.matching_agent import MatchingAgent
from agents.prediction_agent import PredictionAgent
from agents.pricing_agent import PricingAgent
from agents.reviewer_agent import ReviewerAgent


class CompetitiveWorkflow:
    """Coordinates the competitive-intelligence processing pipeline."""

    def run(self, source: str, payload: dict, product_names: list[str]) -> dict:
        extracted = ExtractionAgent().run(source, payload)
        records = DataQualityAgent().run([extracted.payload])
        if not records:
            raise ValueError("No valid records after quality checks")

        record = records[0]
        attributes = AttributeAgent().run(record)
        match_name, match_score = MatchingAgent().run(
            str(record.get("name", "")), product_names
        )
        price = PricingAgent().run(record.get("price", 0), record.get("currency", "INR"))
        prediction = PredictionAgent().run(record.get("historical_prices", []))
        result = {
            "source": extracted.source,
            "attributes": attributes,
            "match": match_name,
            "match_score": match_score,
            "price": price,
            "prediction": prediction,
        }
        return ReviewerAgent().run(result)
