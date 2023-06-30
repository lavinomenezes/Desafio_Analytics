with dim_products as (
    select *
    from {{ ref('int_products') }}  
)

select * from dim_products