with personphone as (
    select
        businessentityid,
        cast(phonenumber as string) as phonenumber,
        phonenumbertypeid,
    from {{ source('dev_lavino','personphone')}}
)
select *
from personphone
