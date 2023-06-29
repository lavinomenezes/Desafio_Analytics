with 
    salesorderdetail as (
    select
        salesorderid,
        productid,
        orderqty,
        unitprice,
        unitpricediscount,
    from {{ source('dev_lavino','salesorderdetail')}}        
)
select *
from salesorderdetail