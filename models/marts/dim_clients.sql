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
            MD5(cast(customerid as string)) as client_sk,
            concat(firstName ,' ',lastName) as customer_name,
            phonenumber,
            phone_type,
            person_emailaddress,
            address_line1,  
            address_type,
            city,
            postalcode,
            state_name,
            country,
            current_timestamp  as modified_date
        from remove_duplicates
        where remove_duplicates_index = 1
    )
select *
from transform