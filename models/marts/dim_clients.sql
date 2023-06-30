with 
    clients as (
        select *
        from {{ ref('int_clients') }}   
    ),
    transform as (
        select
            *,
            current_timestamp  as modified_date
        from clients
    )
select *
from transform