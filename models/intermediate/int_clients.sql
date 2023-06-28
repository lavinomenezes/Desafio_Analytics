with salesorderheader as (
    select *
    from {{ ref('stg_salesorderheader') }}
),
with shiptoaddressid as (
    select *
    from {{ ref('stg_salesorderheader') }}
),
with creditcardid as (
    select *
    from {{ ref('stg_raw_creditcard') }}
),
with personcreditcard as (
    select *
    from {{ ref('stg_personcreditcard') }}
),
with person as (
    select *
    from {{ ref('stg_person') }}
),
with personphone as (
    select *
    from {{ ref('stg_personphone') }}
),
with emailaddress as (
    select *
    from {{ ref('stg_emailaddress') }}
),
with address as (
    select *
    from {{ ref('stg_address') }}
),
with stateprovince as (
    select *
    from {{ ref('stg_stateprovince') }}
),
with countryregion as (
    select *
    from {{ ref('stg_countryregion') }}
),
with businessentityaddress as (
    select *
    from {{ ref('stg_businessentityaddress') }}
),
with addresstype as (
    select *
    from {{ ref('stg_addresstype') }}
),

join_client as(
    select
        salesorderheader.customerid,
        person.businessentityid, 
        person.firstname,
        person.lastname,
        personphone.phonenumber,
        emailaddress.emailaddress,
        address.postalcode,
        address_type.name as address_type,
        address.city,	
        stateprovince.name as state,
        countryregion.name  as country
    from salesorderheader  
    left join personcreditcard       on (salesorderheader.creditcardid = personcreditcard.creditcardid)
	left join person                 on (personcreditcard.businessentityid = person.businessentityid)
	left join personphone            on (person.businessentityid = personphone.businessentityid)
	left join emailaddress           on (person.businessentityid = emailaddress.businessentityid)
	left join address                on (salesorderheader.shiptoaddressid = address.addressid)
	left join stateprovince          on (address.stateprovinceid = stateprovince.stateprovinceid)
	left join countryregion          on (stateprovince.countryregioncode = countryregion .countryregioncode)
	left join businessentityaddress  on (businessentityaddress.addressid = address.addressid)
	left join addresstype            on (addresstype.addresstypeid = businessentityaddress.addresstypeid)
order by salesorderheader.customerid asc
)


select *
from join_client