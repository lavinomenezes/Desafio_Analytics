with 
    table_address as (
        select *
        from {{ ref('stg_address') }}
    ),
    stateprovince as (
        select *
        from {{ ref('stg_stateprovince') }}
    ),
    countryregion as (
        select *
        from {{ ref('stg_countryregion') }}
    ),
    address_type as (
        select *
        from {{ ref('stg_addresstype') }}
    ),
    businessentityaddress as (
        select *
        from {{ ref('stg_businessentityaddress') }}
    ),
    join_address as (
        select
            table_address.addressid,
            concat(address_line1, ' ', ifnull(complement, '')) as address, 
            address_type.address_type,
            table_address.postalcode,
            table_address.city,
            stateprovince.state,
            countryregion.country
        from table_address
        left join stateprovince on (table_address.stateprovinceid = stateprovince.stateprovinceid)
        left join countryregion on (stateprovince.countryregioncode = countryregion.countryregioncode)
        left join businessentityaddress on (table_address.addressid = businessentityaddress.addressid)
        left join address_type on (businessentityaddress.addresstypeid = address_type.addresstypeid)
    )
select * 
from join_address
