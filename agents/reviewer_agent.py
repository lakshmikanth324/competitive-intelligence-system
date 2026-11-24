class ReviewerAgent:
    """Adds basic completeness checks to a workflow result."""

    def run(self, result: dict) -> dict:
        reviewed = dict(result)
        reviewed["reviewed"] = True
        reviewed["complete"] = bool(result.get("match") and result.get("price") is not None)
        return reviewed
