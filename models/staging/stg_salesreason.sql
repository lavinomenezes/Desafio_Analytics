with
    salesreason as(
        select
            salesreasonid,
            name as reason,
            reasontype,
        from {{ source('dev_lavino','salesreason') }}
    )
select *
from salesreason
