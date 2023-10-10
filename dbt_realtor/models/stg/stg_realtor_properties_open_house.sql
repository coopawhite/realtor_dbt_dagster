{{ config(
    tags=["staging"]
) }}

WITH open_house AS (
    SELECT
        property_listing_key
        , property_id
        , listing_id
        , open_house_start_time
        , open_house_description
        , open_house_time_zone
    FROM
        {{ ref("stg_realtor_properties") }}
)

SELECT
    *
FROM
    open_house