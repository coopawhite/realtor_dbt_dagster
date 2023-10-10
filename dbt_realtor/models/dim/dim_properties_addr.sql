{{ config(
    tags=["dim"]
) }}

WITH stg_addr AS (
    SELECT * FROM {{ ref('stg_realtor_properties_address') }}
)

SELECT
    *
FROM
    stg_addr