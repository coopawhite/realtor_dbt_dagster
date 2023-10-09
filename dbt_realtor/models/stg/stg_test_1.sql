WITH stg_realtor AS (
    SELECT * FROM {{ ref("stg_realtor_api") }}
)

SELECT * FROM stg_realtor