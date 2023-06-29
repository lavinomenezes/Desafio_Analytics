with address as (
    select
        addressid,
        city,
        postalcode,
        stateprovinceid,
    from {{ source('dev_lavino','address') }}
)

select *
from address