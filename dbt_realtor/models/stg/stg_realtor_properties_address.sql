{{ config(
    tags=["staging"]
) }}

WITH address AS (
    SELECT
        property_listing_key
        , property_id
        , listing_id
        , city
        , line
        , street_name
        , street_number
        , street_suffix
        , country
        , postal_code
        , state_code
        , state
        , lat
        , lon
        , accuracy
        , street_view_url
        , fips_code
    FROM
        {{ ref("stg_realtor_properties") }}
)

SELECT 
    *
FROM 
    address