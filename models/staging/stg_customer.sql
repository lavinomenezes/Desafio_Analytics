with customer as (
    select
        customerid,
        personid,
        territoryid
    from {{ source('dev_lavino','customer') }}        
)
select * from customer