with 
    clients as (
        select *
        from {{ ref('int_clients') }} 
        where persontype =  'Individual Customer' 
    ),
    remove_duplicates as (
    select
        *,
        row_number() over (partition by customerid order by customerid) as remove_duplicates_index,
    from clients
    ),
    transform as (
        select
            cast(TO_HEX(MD5(cast(customerid as string)))as string) as customer_sk,
            personid,
            concat(firstName ,' ',lastName) as complete_name,
            phonenumber,
            phone_type,
            person_emailaddress,
            current_timestamp  as modified_date
        from remove_duplicates
        where remove_duplicates_index = 1
    )
select *
from transform