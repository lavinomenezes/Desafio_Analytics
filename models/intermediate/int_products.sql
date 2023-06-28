with 
    product as (
        select *
        from {{ ref('stg_product') }}
    ),
    product_category as (
        select *
        from {{ ref('stg_productcategory') }}
    ),
    product_subcategory as (
        select *
        from {{ ref('stg_productsubcategory') }}
    ),
    product_model as (
        select *
        from {{ ref('stg_productmodel') }}
    ),
    join_product as (
        select
            product.productid,
            product.product_name,
            product.size,
            product_model.product_model_name,
            product_category.product_category_name,
            product_subcategory.product_subcategory_name,
            product.reference_price
        from product
        left join product_subcategory on product.productsubcategoryid = product_subcategory.productsubcategoryid
        left join product_category on product_subcategory.productcategoryid = product_category.productcategoryid
        left join product_model on product.productmodelid = product_model.productmodelid
        order by product.productid
    )

select * 
from join_product
