with 
    dim_products as (
        select *
        from {{ ref('int_products') }}
        where productid is not null  
    ),
    remove_duplicates as (
        select
            *,
            row_number() over (partition by productid order by productid) as remove_duplicates_index,
        from dim_products
    ),
    transform as (
        select
            MD5(cast(productid as string)) as product_sk,
            product_name,
            size,
            product_model_name,
            product_category_name,
            product_subcategory_name,
            reference_price,
            color,
            weight,
            makeflag,
            safetystocklevel,
            reorderpoint,
            current_timestamp  as modified_date
        from remove_duplicates
        where remove_duplicates_index = 1
    )

select * from transform