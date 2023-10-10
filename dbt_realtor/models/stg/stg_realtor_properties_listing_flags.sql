{{ config(
    tags=["staging"]
) }}

WITH flags AS (
    SELECT
        property_listing_key
        , property_id
        , listing_id
        , is_price_reduced
        , is_new_construction
        , is_foreclosure
        , is_plan
        , is_new_listing
        , is_coming_soon
        , is_contingent
        , is_pending
        , cats_allowed
        , dogs_allowed
    FROM
        {{ ref("stg_realtor_properties") }}
)

SELECT
    *
FROM
    flags