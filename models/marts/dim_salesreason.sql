with
    salesreason as (
        select *
        from {{ ref('stg_salesreason') }}
    ),
    remove_duplicates as (
        select
            *,
            row_number() over (partition by salesreasonid order by salesreasonid) as remove_duplicates_index,
        from salesreason
    ),
    transform as (
        select
            MD5(cast(salesreasonid as string)) as salesreason_sk,
            reason,
            reasontype,
            current_timestamp  as modified_date
        from remove_duplicates
        where remove_duplicates_index = 1
    )
select *
from transform