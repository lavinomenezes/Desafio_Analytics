with addresstype as (
    select 
        addresstypeid,
        name as address_type
    from {{ source('dev_lavino','addresstype')}}
)
select * 
from addresstype