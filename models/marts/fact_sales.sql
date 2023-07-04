with 
    fact_sales as (
        select *
        from {{ ref('int_sales') }}
    ),
    remove_duplicates as (
        select
            *,
            row_number() over (partition by salesorderid,salesorderdetailid order by salesorderid) as remove_duplicates_index,
        from fact_sales
    ),
    transform as (
        select
            row_number() over (order by salesorderid,salesorderdetailid) as sales_sk,
            salesorderid,
            salesorderdetailid,
            MD5(cast(customerid as string)) as customer_fk,
            MD5(cast(productid as string)) as product_fk,
            MD5(cast(creditcardid as string)) as creditcard_fk,
            MD5(cast(shiptoaddressid as string)) as address_fk,
            status,
            orderqty,
            unitprice,
            unitpricediscount,
            gross_value,
            net_value,
            tax_per_order,
            freight_per_order,
            totaldue_per_order,
            orderdate,
            shipdate,
            current_timestamp  as modified_date
        from remove_duplicates
        where remove_duplicates_index = 1
    )
select * from transform