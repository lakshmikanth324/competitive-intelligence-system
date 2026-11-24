import difflib


class MatchingAgent:
    """Matches a candidate product title against known product names."""

    def run(self, candidate_name: str, product_names: list[str]) -> tuple[str | None, float]:
        if not candidate_name or not product_names:
            return None, 0.0
        matches = difflib.get_close_matches(candidate_name, product_names, n=1, cutoff=0.0)
        if not matches:
            return None, 0.0
        score = difflib.SequenceMatcher(None, candidate_name.lower(), matches[0].lower()).ratio()
        return matches[0], round(score, 4)
