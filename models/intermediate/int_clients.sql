with 
    customer as (
        select *
        from {{ ref('stg_customer') }}
    ),
    person as (
        select *
        from {{ ref('stg_person') }}
    ),
    personphone as (
        select *
        from {{ ref('stg_personphone') }}
    ),
    emailaddress as (
        select *
        from {{ ref('stg_emailaddress') }}
    ),
    phonenumbertype as (
        select *
        from {{ ref('stg_phonenumbertype') }}
    ),
    join_client as (
        select 
            customer.customerid,
            customer.personid, 
            person.firstname,
            person.lastname,
            CASE
                WHEN person.persontype = 'SC' THEN 'Store Contact'
                WHEN person.persontype = 'IN' THEN 'Individual Customer'
                WHEN person.persontype = 'SP' THEN 'Sales Person'
                WHEN person.persontype = 'EM' THEN 'Employee'
                WHEN person.persontype = 'VC' THEN 'Vendor'
                WHEN person.persontype = 'GC' THEN 'General Contact'
            end as persontype,
            personphone.phonenumber,
            phonenumbertype.phone_type,
            emailaddress.person_emailaddress,
            from customer  
            left join person  on (customer.personid  = person.businessentityid)
		    left join personphone  on (customer.personid = personphone.businessentityid)
		    left join phonenumbertype on (personphone.phonenumbertypeid = phonenumbertype.phonenumbertypeid)
		    left join emailaddress on (emailaddress.businessentityid = customer.personid)
        order by customer.customerid asc
    )
select *
from join_client