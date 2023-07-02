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
            salesorderdetail.salesorderdetailid,
            salesorderheader.salesorderid,
            salesorderheader.customerid,
            salesorderdetail.productid,
            salesorderheader.creditcardid,
            salesreason.salesreasonid,
            case 
                when salesorderheader.status = 1 then 'In Process'
                when salesorderheader.status = 2 then 'Approved'
                when salesorderheader.status = 3 then 'Backordered'
                when salesorderheader.status = 4 then 'Rejected'
                when salesorderheader.status = 5 then 'Shipped'
                when salesorderheader.status = 6 then 'Cancelled'
            end as status,
            salesorderdetail.orderqty,
            salesorderdetail.unitprice,
            salesorderdetail.unitpricediscount,
            (salesorderdetail.unitprice * salesorderdetail.orderqty) as gross_value,
	        (salesorderdetail.unitprice * salesorderdetail.orderqty) * (1-salesorderdetail.unitpricediscount) as net_value,
            salesorderheader.taxamt/(count(salesorderheader.taxamt) over (partition by salesorderheader.salesorderid)) as tax_per_order,
            salesorderheader.freight/(count(salesorderheader.freight) over (partition by salesorderheader.salesorderid)) as freight_per_order,
            salesorderheader.totaldue/(count(salesorderheader.totaldue) over (partition by salesorderheader.salesorderid)) as totaldue_per_order,
	        cast(salesorderheader.orderdate as timestamp) as orderdate,
            cast(salesorderheader.shipdate as timestamp) as shipdate,
        from salesorderheader
        left join salesorderdetail on salesorderheader.salesorderid = salesorderdetail.salesorderid
        left join salesorderheadersalesreason on (salesorderdetail.salesorderid = salesorderheadersalesreason.salesorderid)
        left join salesreason on (salesorderheadersalesreason.salesreasonid = salesreason.salesreasonid)
    )
select *
from join_sales