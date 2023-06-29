with 
    salesorderheadersalesreason as(
    select
        salesorderid,
        salesreasonid
    from {{ source('dev_lavino','salesorderheadersalesreason')}}
)
select *
from salesorderheadersalesreason