with person as (
    select
        businessentityid,
        persontype,
        firstname,
        lastname,
    from {{ source('dev_lavino','person')}}
)
select *
from person