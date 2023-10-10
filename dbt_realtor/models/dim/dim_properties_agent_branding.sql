{{ config(
    tags=["dim"]
) }}

WITH stg_agent AS (
    SELECT * FROM {{ ref('stg_realtor_properties_agent_branding') }}
)

SELECT
    *
FROM
    stg_agent