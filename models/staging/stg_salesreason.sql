with
    salesreason as(
        select
            salesreasonid,
            "name" as reason,
            reasonType,
        from {{ source('dev_lavino','salesreason') }}
    )
select *
from salesreason
