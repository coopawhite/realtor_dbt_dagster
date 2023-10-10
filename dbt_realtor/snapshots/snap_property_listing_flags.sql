{% snapshot snap_property_listing_flags %}

    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='property_listing_key',
          check_cols=["is_price_reduced","is_new_construction","is_foreclosure","is_plan","is_new_listing","is_coming_soon","is_contingent","is_pending","cats_allowed","dogs_allowed"],
        )
    }}

    select * from {{ ref("stg_realtor_properties_listing_flags") }}

{% endsnapshot %}
