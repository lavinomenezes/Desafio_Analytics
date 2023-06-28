with stateprovince as (
    select
        stateprovinceid,
        name as state_name,
        countryregioncode,
    from {{ source('dev_lavino','stateprovince')}}
)
select *
from stateprovince
