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
            case 
                when product.size is null then 'not reported' 
                else product.size 
            end as size,
            case 
                when product.color is null then 'not reported' 
                else product.color 
            end as color,
            case 
                when product.weight is null then 0 
                else product.weight 
            end as weight,
            product.makeflag,
            product.safetystocklevel,
            product.reorderpoint,
            case 
                when product_model.product_model_name is null then 'not reported' 
                else product_model.product_model_name 
            end as product_model_name,
            case 
                when product_category.product_category_name is null then 'not reported' 
                else product_category.product_category_name
            end as product_category_name,
            case 
                when product_subcategory.product_subcategory_name is null then 'not reported' 
                else product_subcategory.product_subcategory_name
            end as product_subcategory_name,
            product.reference_price
        from product
        left join product_subcategory on product.productsubcategoryid = product_subcategory.productsubcategoryid
        left join product_category on product_subcategory.productcategoryid = product_category.productcategoryid
        left join product_model on product.productmodelid = product_model.productmodelid
        order by product.productid
    )

select * 
from join_product
