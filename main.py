from workflows.competitive_workflow import CompetitiveWorkflow


def main() -> None:
    result = CompetitiveWorkflow().run(
        source="manual",
        payload={"name": "Samsung 55 Inch 4K TV", "price": 42000, "currency": "INR"},
        product_names=["Samsung 55 Inch 4K TV", "LG 50 Inch Smart TV"],
    )
    print(result)


if __name__ == "__main__":
    main()
