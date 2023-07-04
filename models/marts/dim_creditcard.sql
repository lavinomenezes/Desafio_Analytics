with
    creditcard as (
        select *
        from {{ ref('stg_creditcard') }}
    ),
    remove_duplicates as (
        select
            *,
            row_number() over (partition by  creditcardid order by creditcardid) as remove_duplicates_index,
        from creditcard
    ),
    creditcard_sk as (
        select
            cast(TO_HEX(MD5(cast(creditcardid as string)))as string) as creditcard_sk,
            card_type,
            card_number,
            expmonth,
            expyear,
            current_timestamp  as modified_date
        from remove_duplicates
        where remove_duplicates_index = 1
    )
select *
from creditcard_sk
