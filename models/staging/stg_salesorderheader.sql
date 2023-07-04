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
        cast(cast(orderdate as timestamp) as date) as orderdate,
        cast(cast(shipdate as timestamp) as date) as shipdate,
    from {{ source('dev_lavino','salesorderheader')}}
)
select *
from salesorderheader