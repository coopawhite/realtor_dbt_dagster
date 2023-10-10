{{ config(
    tags=["staging"]
) }}

WITH price AS (
    SELECT
        property_listing_key
        , property_id
        , listing_id
        , list_price
        , list_price_min
        , list_price_max
        , price_reduced_amount
        , estimate
        , last_sold_date
        , list_date
        , last_sold_price
    FROM
        {{ ref("stg_realtor_properties") }}
)

SELECT 
    *
FROM 
    price