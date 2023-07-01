with salesorderheader as(
    select
        customerid,
        shiptoaddressid,
        creditcardid,
        salesorderid,
        status,
        subtotal,
        taxamt,
        freight,
        totaldue,
        cast(orderdate as timestamp) as orderdate,
        cast(shipdate as timestamp) as shipdate,
    from {{ source('dev_lavino','salesorderheader')}}
)
select *
from salesorderheader