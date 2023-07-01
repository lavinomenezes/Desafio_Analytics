with
    creditcard as (
        select
            creditcardid,
            cast(cardtype as string) as card_type,
            cast(cardnumber as string) card_number,
            expmonth,
            expyear
        from {{ source('dev_lavino','creditcard') }}
    )
select *
from creditcard