class AttributeAgent:
    """Normalizes product attributes from a record."""

    def run(self, product: dict) -> dict:
        attributes = product.get("attributes", {})
        if not isinstance(attributes, dict):
            raise ValueError("attributes must be a dictionary")
        return {
            "product": product.get("name"),
            "attributes": {
                str(key).strip().lower(): str(value).strip()
                for key, value in attributes.items()
            },
        }
