with productsubcategory as (
    select 
        productsubcategoryid,
        productcategoryid,
        name as product_subcategory_name,
    from {{ source('dev_lavino','productsubcategory') }}
)
select *
from productsubcategory 