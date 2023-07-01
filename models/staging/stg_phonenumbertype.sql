with phonenumbertype as (
    select
        phonenumbertypeid,
        name as phone_type,
    from {{ source('dev_lavino','phonenumbertype')}}
)

select * from phonenumbertype