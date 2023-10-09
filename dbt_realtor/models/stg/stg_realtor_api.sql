WITH UnnestedBranding AS (
    SELECT
        property_id,
        listing_id,
        b['photo'] AS photo,
        b['name'] AS name,
        b['phone'] AS phone,
        b['link'] AS link,
    FROM raw.call_property_list_api,
    LATERAL UNNEST(branding) AS t(b)
),

UnnestedOpenHouses AS (
    SELECT
        property_id,
        listing_id,
        oh['start_date'] AS open_house_start_time,
        oh['description'] AS open_house_description,
        oh['time_zone'] AS open_house_time_zone,
    FROM raw.call_property_list_api,
    LATERAL UNNEST(open_houses) AS t(oh)
),

VirtualTours AS (
    SELECT
        property_id,
        listing_id,
        vt['href'] as virtual_tour_link
    FROM raw.call_property_list_api,
    LATERAL UNNEST(virtual_tours) as t(vt)
),

Advertisers AS (
    SELECT
        property_id,
        listing_id,
        ad.fulfillment_id as advertiser_fulfillment_id,
        ad.name as advertiser_name,
        ad.email as advertiser_email,
        ad.href as advertiser_href,
        ad.slogan as advertiser_slogan,
        ad.type as advertiser_type
    FROM raw.call_property_list_api,
    LATERAL UNNEST(advertisers) as t(ad)
),

Source AS (
    SELECT
        property_id,
        listing_id,
        ag.agent_id as source_agent_id,
        ag.agent_name as source_agent_name,
        ag.office_id as source_office_id,
        ag.office_name as source_office_name,
        source['id'] as source_id,
        source['type'] as source_type,
        source['spec_id'] as source_spec_id,
        source['plan_id'] as source_plan_id,
        source['listing_href'] as source_listing_href,
        source['listing_id'] as source_listing_id
    FROM raw.call_property_list_api,
    LATERAL UNNEST(source['agents']) as t(ag)
)


SELECT
    a.property_id,
    a.listing_id,
    a.plan_id,
    a.status,
    a.photo_count,
    ub.photo,
    ub.name,
    ub.phone,
    ub.link,
    a.location['address']['city'] AS city,
    a.location['address']['line'] AS line,
    a.location['address']['street_name'] AS street_name,
    a.location['address']['street_number'] AS street_number,
    a.location['address']['street_suffix'] AS street_suffix,
    a.location['address']['country'] AS country,
    a.location['address']['postal_code'] AS postal_code,
    a.location['address']['state_code'] AS state_code,
    a.location['address']['state'] AS state,
    a.location['address']['coordinate']['lat'] AS lat,
    a.location['address']['coordinate']['lon'] AS lon,
    a.location['address']['coordinate']['accuracy'] AS accuracy,
    a.location['street_view_url'] AS street_view_url,
    a.location['county']['fips_code'] AS fips_code,
    uoh.open_house_start_time,
    uoh.open_house_description,
    uoh.open_house_time_zone,
    a.description['sub_type'] AS sub_type,
    a.description['type'] AS type,
    a.description['beds'] AS beds,
    a.description['baths'] AS baths,
    a.description['lot_sqft'] AS lot_sqft,
    a.description['beds_max'] AS beds_max,
    a.description['beds_min'] AS beds_min,
    a.description['sqft_max'] AS sqft_max,
    a.description['sqft_min'] AS sqft_min,
    a.description['baths_full'] AS baths_full,
    a.description['baths_half'] AS baths_half,
    a.description['baths_max'] AS baths_max,
    a.description['baths_full_calc'] AS baths_full_calc,
    a.description['baths_partial_calc'] AS baths_partial_calc,
    vt.virtual_tour_link,
    a.matterport,
    ad.advertiser_fulfillment_id,
    ad.advertiser_name,
    ad.advertiser_email,
    ad.advertiser_href,
    ad.advertiser_slogan,
    ad.advertiser_type,
    a.flags['is_price_reduced'],
    a.flags['is_new_construction'],
    a.flags['is_foreclosure'],
    a.flags['is_plan'],
    a.flags['is_new_listing'],
    a.flags['is_coming_soon'],
    a.flags['is_contingent'],
    a.flags['is_pending'],
    source_agent_id,
    source_agent_name,
    source_office_id,
    source_office_name,
    source_id,
    source_type,
    source_spec_id,
    source_plan_id,
    source_listing_href,
    source_listing_id,
    a.pet_policy['cats'] as cats_allowed,
    a.pet_policy['dogs'] as dogs_allowed,
    a.community,
    a.primary_photo['href'] as primary_photo_href,
    a.href as listing_href,
    a.list_price,
    a.list_price_min,
    a.list_price_max,
    a.price_reduced_amount,
    a.estimate,
    a.lead_attributes['lead_type'] as lead_type,
    a.lead_attributes['show_contact_an_agent'] as show_contact_an_agent,
    a.lead_attributes['opcity_lead_attributes']['flip_the_market_enabled'] as flip_the_market_enabled,
    a.last_sold_date,
    a.list_date,
    a.products['brand_name'] as product_brand_name,
    a.last_sold_price
FROM raw.call_property_list_api a
LEFT JOIN UnnestedOpenHouses uoh ON 
    uoh.property_id = a.property_id AND uoh.listing_id = a.listing_id
LEFT JOIN UnnestedBranding ub ON
    ub.property_id = a.property_id AND ub.listing_id = a.listing_id
LEFT JOIN VirtualTours vt ON 
    vt.property_id = a.property_id AND vt.listing_id = a.listing_id
LEFT JOIN Advertisers ad ON 
    ad.property_id = a.property_id AND ad.listing_id = a.listing_id
LEFT JOIN Source sc ON 
    sc.property_id = a.property_id AND sc.listing_id = a.listing_id