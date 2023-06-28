with person as (
    select
        businessentityid,
        firstname,
        lastname,
    from {{ source('dev_lavino','person')}}
)
select *
from person