{{ config(
    tags=["dim"]
) }}

WITH stg_flags AS (
    SELECT * FROM {{ ref('snap_property_listing_flags') }}
)

SELECT
    *
FROM
    stg_flags