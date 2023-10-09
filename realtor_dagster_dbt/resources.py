from dagster_duckdb_pandas import DuckDBPandasIOManager


database_io_manager = DuckDBPandasIOManager(database="analytics.realtor", schema="raw")

