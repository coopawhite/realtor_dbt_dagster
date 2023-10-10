{{ config(
    tags=["dim"]
) }}

WITH stg_desc AS (
    SELECT * FROM {{ ref('stg_realtor_properties_description') }}
)

SELECT
    *
FROM
    stg_desc