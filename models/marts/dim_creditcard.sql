with
    creditcard as (
        select *
        from {{ ref('stg_raw_creditcard') }}
    ),
    transform as (
        select
            row_number() over (order by creditcardid) as creditcard_id,
            *,
            current_timestamp  as modified_date
        from creditcard
    )
select *
from transform
