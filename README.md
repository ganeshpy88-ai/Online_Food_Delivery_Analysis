🍕 Online Food Data Analysis (OFDA) Dashboard
An end-to-end data analytics pipeline designed to process, clean, and visualize over 100,000 food delivery records. This project utilizes a MySQL backend for high-efficiency data storage and a Streamlit frontend for real-time business intelligence.

🚀 Key Features
High-Efficiency Data Ingestion: Implemented Python-based batch processing with chunksize to import large Excel/CSV datasets into SQL without server timeouts.

Modular Query Bank: A centralized queries.py library containing 15 optimized SQL queries covering customer behavior, revenue trends, and operational performance.

Advanced Data Cleaning: Handled missing values (NaN) and performed categorical imputation for critical fields like Peak_Hour and Cancellation_Reason using Pandas.

Interactive Dashboard: A user-friendly UI featuring a custom pizza-themed interface to run complex SQL analysis with a single click.

🛠️ Tech Stack
Language: Python (Pandas, SQLAlchemy, PyMySQL).

Database: MySQL Server 8.0.44.

Visualization: Streamlit Framework.

Tooling: MySQL Workbench for database administration.

📊 Analytics Highlights
Revenue Analysis: Monthly growth trends and the impact of discounts on overall profit margins.

Operational Efficiency: Average delivery times by city and distance-based delay analysis.

Risk Management: Quantification of revenue loss due to order cancellations.
