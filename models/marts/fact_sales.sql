with 
    fact_sales as (
        select *
        from {{ ref('int_sales') }}
    ),
    transform as (
        select
            *,
            current_timestamp  as modified_date
        from fact_sales
    )
select * from fact_sales