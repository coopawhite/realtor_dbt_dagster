from dagster import (
    Definitions,
    load_assets_from_package_module,
)

from dagster_duckdb_pandas import DuckDBPandasIOManager

from .assets import realtor_api
from .assets.dbt import (
    DBT_PROJECT_DIR,
    dbt_project_assets,
    dbt_resource
)


database_io_manager = DuckDBPandasIOManager(database="analytics", schema="raw")

resources = {
    "database_io_manager": database_io_manager,
    "dbt": dbt_resource,
}


realtor_api_assets = load_assets_from_package_module(
    realtor_api,
)




defs = Definitions(
    assets=[*realtor_api_assets, dbt_project_assets],
    resources=resources
)
