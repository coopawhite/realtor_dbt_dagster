{% snapshot snap_property_open_house %}

    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='property_listing_key',
          check_cols=["open_house_start_time","open_house_description","open_house_time_zone"],
        )
    }}

    SELECT 
      * 
    FROM 
      {{ ref("stg_realtor_properties_open_house") }}
    WHERE
      open_house_start_time is not null
      
{% endsnapshot %}

