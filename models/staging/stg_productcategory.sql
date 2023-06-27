with productcategory as (
        select
            productcategoryid,
            name as product_category_name,
        from {{ source('dev_lavino','productcategory') }}
    )

select *
from productcategory
