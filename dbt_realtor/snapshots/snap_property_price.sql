{% snapshot snap_property_price %}

    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='property_listing_key',
          check_cols=["listing_id","list_price","list_price_min","list_price_max","price_reduced_amount"],
        )
    }}

    select * from {{ ref('stg_realtor_properties_price') }}

{% endsnapshot %}


