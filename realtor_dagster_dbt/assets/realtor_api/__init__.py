import requests
import pandas as pd
from dotenv import load_dotenv
import os

from dagster import (
    asset, 
    AssetExecutionContext,
    MetadataValue,
)

load_dotenv()
RAPID_API_KEY = os.getenv('RAPID_API_KEY')
RAPID_API_HOST = os.getenv('RAPID_API_HOST')

@asset(
        io_manager_key="database_io_manager"
)
def realtor_properties_list(
    context: AssetExecutionContext
) -> pd.DataFrame:
    """
    Get available property lists from api
    """
    
    url = "https://realtor.p.rapidapi.com/properties/v3/list"

    payload = {
        "limit": 200,
        "offset": 0,
        "postal_code": "90004",
        "status": ["for_sale", "ready_to_build"],
        "sort": {
            "direction": "desc",
            "field": "list_date"
        }
    }
    headers = {
        "content-type": "application/json",
        "X-RapidAPI-Key": RAPID_API_KEY,
        "X-RapidAPI-Host": RAPID_API_HOST
    }

    response = requests.post(url, json=payload, headers=headers)

    json_data = response.json()
    df = pd.DataFrame.from_dict(json_data['data']['home_search']['results'])

    context.add_output_metadata(
    metadata={
        "num_records": len(df),  # Metadata can be any key-value pair
        "preview": MetadataValue.md(df.head().to_markdown()),
        # The `MetadataValue` class has useful static methods to build Metadata
        }   
    )

    return df
