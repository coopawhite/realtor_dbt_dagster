{{ config(
    tags=["dim"]
) }}

WITH stg_open_house AS (
    SELECT * FROM {{ ref('snap_property_open_house') }}
)

SELECT
    *
FROM
    stg_open_house