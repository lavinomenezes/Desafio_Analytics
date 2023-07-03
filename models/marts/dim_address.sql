with 
    int_address as (
        select *
        from {{ ref('int_address') }}
    ),
    remove_duplicates as (
        select
            *,
            row_number() over (partition by addressid order by addressid) as remove_duplicates_index,
        from int_address
    ),
    transform as (
        select
            MD5(cast(addressid as string)) as address_sk,
            address,
            address_type,
            postalcode,
            city,
            state,
            country,
            current_timestamp  as modified_date
        from remove_duplicates
        where remove_duplicates_index = 1
    )
select *
from transform

