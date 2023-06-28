with businessentityaddress as (
    select
        addressid,
        addresstypeid,
    from {{ source('dev_lavino','businessentityaddress')}}
)
select * 
from businessentityaddress
