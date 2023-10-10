{{ config(
    tags=["stg"]
) }}

WITH raw_properties AS (
    SELECT
        *
        , ROW_NUMBER() OVER (PARTITION BY property_id, listing_id order by property_id) as row_num
    FROM 
        {{ ref("raw_realtor_properties_flattened") }}
    
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['property_id', 'listing_id']) }} as property_listing_key
    , *
FROM 
    raw_properties
WHERE
    row_num = 1
