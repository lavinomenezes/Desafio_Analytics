with countryregion as (
    select
        countryregioncode,
        name as country,
    from {{ source('dev_lavino','countryregion')}}
)
select *
from countryregion