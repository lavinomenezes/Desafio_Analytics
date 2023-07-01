with 
    salesorderdetail as (
    select
        salesorderdetailid,
        salesorderid,
        productid,
        orderqty,
        unitprice,
        unitpricediscount,
    from {{ source('dev_lavino','salesorderdetail')}}        
)
select *
from salesorderdetail