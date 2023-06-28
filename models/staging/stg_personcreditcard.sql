with personcreditcard as (
    select
        creditcardid,
        businessentityid
    from {{ source('dev_lavino','personcreditcard')}}
)
select *
from personcreditcard