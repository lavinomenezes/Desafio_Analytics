with
    salesreason as (
        select *
        from {{ ref('stg_salesreason') }}
    ),
    transform as (
        select
            *,
            current_timestamp  as modified_date
        from salesreason
    )
select *
from transform