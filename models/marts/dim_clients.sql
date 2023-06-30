with 
    clients as (
        select *
        from {{ ref('int_clients') }}   
)
select *
from clients