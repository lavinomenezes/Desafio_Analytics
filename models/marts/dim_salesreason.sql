with
    salesreason as (
        select *
        from {{ ref('int_salesreason') }}
    ),
    remove_duplicates as (
        select
            *,
            row_number() over (partition by reason_type order by reason_type) as remove_duplicates_index,
        from salesreason
    ),
    transform as (
        select
            cast(TO_HEX(MD5(cast(reason_type as string)))as string) as salesreason_sk,
            reason_type,
            current_timestamp  as modified_date
        from remove_duplicates
        where remove_duplicates_index = 1
    )
select *
from transform