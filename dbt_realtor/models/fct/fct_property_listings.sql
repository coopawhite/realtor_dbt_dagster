{{ config(
    tags=["fct"]
) }}

WITH listings AS (
    SELECT
        property_listing_key
        , property_id
        , listing_id
        , plan_id
        , status
        
    FROM
        {{ ref("stg_realtor_properties") }}
)

SELECT 
    *
FROM 
    listings