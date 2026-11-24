import streamlit as st

from workflows.competitive_workflow import CompetitiveWorkflow

st.set_page_config(page_title="Competitive Intelligence", page_icon="📊", layout="wide")
st.title("E-commerce Competitive Intelligence Dashboard")

source = st.text_input("Source", value="manual")
product_name = st.text_input("Competitor product name")
price = st.number_input("Price", min_value=0.0, step=0.01)
currency = st.selectbox("Currency", ["INR", "USD", "EUR", "GBP"])
known_products = st.text_area("Known product names (one per line)").splitlines()

if st.button("Analyze"):
    if not product_name.strip():
        st.error("Enter a competitor product name")
    else:
        result = CompetitiveWorkflow().run(
            source,
            {"name": product_name, "price": price, "currency": currency},
            [name.strip() for name in known_products if name.strip()],
        )
        st.json(result)
