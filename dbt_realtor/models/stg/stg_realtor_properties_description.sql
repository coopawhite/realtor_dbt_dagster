{{ config(
    tags=["staging"]
) }}

WITH description AS (
    SELECT
        property_listing_key
        , property_id
        , listing_id
        , sub_type
        , type
        , beds
        , baths
        , lot_sqft
        , beds_max
        , beds_min
        , sqft_max
        , sqft_min
        , baths_full
        , baths_half
        , baths_max
        , baths_full_calc
        , baths_partial_calc
    FROM
        {{ ref("stg_realtor_properties") }}
)

SELECT
    *
FROM
    description