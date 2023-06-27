with productmodel as (
    select
        productmodelid,
        name as product_model_name,
    from {{ source('dev_lavino','productmodel') }}     
)
select *
from productmodel