{{ config(
    tags=["dim"]
) }}

WITH stg_price AS (
    SELECT * FROM {{ ref('snap_property_price') }}
)

SELECT
    *
FROM
    stg_price