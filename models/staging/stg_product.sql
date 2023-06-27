with product as (
    select
        cast(productid as int) as productid,
        cast(name as string) as product_name,
        productsubcategoryid,
        productmodelid,
        size,
        listprice as reference_price,
    from {{ source('dev_lavino','product') }}
)

select *
from product
