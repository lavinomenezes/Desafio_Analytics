with email_address as (
    select
        businessentityid,
        emailaddress.emailaddress as person_emailaddress
    from {{ source('dev_lavino','emailaddress')}}
)
select *
from email_address
