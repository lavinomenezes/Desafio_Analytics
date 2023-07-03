with stateprovince as (
    select
        stateprovinceid,
        name as state,
        countryregioncode,
    from {{ source('dev_lavino','stateprovince')}}
)
select *
from stateprovince
