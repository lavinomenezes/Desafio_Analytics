with 
    dim_products as (
        select *
        from {{ ref('int_products') }}  
    ),
    transform as (
        select
            *,
            current_timestamp  as modified_date
        from dim_products
    )

select * from transform