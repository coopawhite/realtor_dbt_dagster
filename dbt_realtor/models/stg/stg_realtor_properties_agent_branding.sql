{{ config(
    tags=["staging"]
) }}

WITH branding AS (
    SELECT
        property_listing_key
        , property_id
        , listing_id
        , photo
        , name
        , phone
        , link
        , advertiser_fulfillment_id
        , advertiser_name
        , advertiser_email
        , advertiser_href
        , advertiser_slogan
        , advertiser_type
        , source_agent_id
        , source_agent_name
        , source_office_id
        , source_office_name
        , source_id
        , source_type
        , source_spec_id
        , source_plan_id
        , source_listing_href
        , source_listing_id
    FROM
        {{ ref("stg_realtor_properties") }}
)

SELECT 
    *
FROM 
    branding