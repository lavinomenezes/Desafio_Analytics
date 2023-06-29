with
    salesorderheader as (
        select *
        from {{ ref('stg_salesorderheader') }}
    ),
    salesorderdetail as (
        select *
        from {{ ref('stg_salesorderdetail') }}
    ),
    salesreason as (
        select *
        from {{ ref('stg_salesreason') }}
    ),
    salesorderheadersalesreason as (
        select *
        from {{ ref('stg_salesorderheadersalesreason') }}
    ),
    join_sales as (
        select
            salesorderheader.salesorderid,
            salesorderheader.customerid,
            salesorderdetail.productid,
            salesorderheader.creditcardid,
            salesreason.salesreasonid,
            salesorderheader.status,
            salesorderdetail.orderqty,
            salesorderdetail.unitprice,
            salesorderdetail.unitpricediscount,
            (salesorderdetail.unitprice * salesorderdetail.orderqty) as gross_value,
	        (salesorderdetail.unitprice * salesorderdetail.orderqty) * (1-salesorderdetail.unitpricediscount) as net_value,
	        salesorderheader.orderdate
        from salesorderheader
        left join salesorderdetail on salesorderheader.salesorderid = salesorderdetail.salesorderid
        left join salesorderheadersalesreason on (salesorderdetail.salesorderid = salesorderheadersalesreason.salesorderid)
        left join salesreason on (salesorderheadersalesreason.salesreasonid = salesreason.salesreasonid)
    )
select *
from join_sales