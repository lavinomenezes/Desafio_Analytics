with salesorderheader as(
    select
        customerid,
        shiptoaddressid,
        creditcardid
    from {{ source('dev_lavino','salesorderheader')}}
)
select *
from salesorderheader