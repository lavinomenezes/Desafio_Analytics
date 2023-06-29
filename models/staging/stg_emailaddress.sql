with emailaddress as (
    select
        businessentityid,
        emailaddress
    from {{ source('dev_lavino','emailaddress')}}
)
select *
from emailaddress
