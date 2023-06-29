with salesorderheader as(
    select
        customerid,
        shiptoaddressid,
        creditcardid,
        salesorderid,
        status,
        orderdate
    from {{ source('dev_lavino','salesorderheader')}}
)
select *
from salesorderheader