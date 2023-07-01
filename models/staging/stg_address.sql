with address as (
    select
        addressid,
        addressline1 as address_line1,
        addressline2 as complement,
        city,
        postalcode,
        stateprovinceid,
    from {{ source('dev_lavino','address') }}
)

select *
from address