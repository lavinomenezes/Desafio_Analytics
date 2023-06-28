with emailaddress as (
    select
        businessentityid,
        cast(emailaddress as string) as emailaddress
    from {{ source('dev_lavino','emailaddress')}}
)
select *
from emailaddress
