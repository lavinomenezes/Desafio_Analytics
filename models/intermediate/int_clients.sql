with 
    salesorderheader as (
        select *
        from {{ ref('stg_salesorderheader') }}
    ),
    shiptoaddressid as (
        select *
        from {{ ref('stg_salesorderheader') }}
    ),
    creditcardid as (
        select *
        from {{ ref('stg_creditcard') }}
    ),
    personcreditcard as (
        select *
        from {{ ref('stg_personcreditcard') }}
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
    address as (
        select *
        from {{ ref('stg_address') }}
    ),
    stateprovince as (
        select *
        from {{ ref('stg_stateprovince') }}
    ),
    countryregion as (
        select *
        from {{ ref('stg_countryregion') }}
    ),
    businessentityaddress as (
        select *
        from {{ ref('stg_businessentityaddress') }}
    ),
    addresstype as (
        select *
        from {{ ref('stg_addresstype') }}
    ),
    phonenumbertype as (
        select *
        from {{ ref('stg_phonenumbertype') }}
    ),
    join_client as (
        select 
            salesorderheader.customerid,
            person.businessentityid, 
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
            address.address_line1,
            addresstype.address_type,
            address.city,
            address.postalcode,	
            stateprovince.state_name,
            countryregion.country
        from salesorderheader  
        left join personcreditcard on (salesorderheader.creditcardid = personcreditcard.creditcardid)
        left join person on (personcreditcard.businessentityid = person.businessentityid)
        left join personphone on (person.businessentityid = personphone.businessentityid)
        left join emailaddress on (person.businessentityid = emailaddress.businessentityid)
        left join address on (salesorderheader.shiptoaddressid = address.addressid)
        left join stateprovince on (address.stateprovinceid = stateprovince.stateprovinceid)
        left join countryregion on (stateprovince.countryregioncode = countryregion .countryregioncode)
        left join businessentityaddress on (businessentityaddress.addressid = address.addressid)
        left join addresstype on (addresstype.addresstypeid = businessentityaddress.addresstypeid)
        left join phonenumbertype on (personphone.phonenumbertypeid = phonenumbertype.phonenumbertypeid)
        order by salesorderheader.customerid asc
    )
select *
from join_client