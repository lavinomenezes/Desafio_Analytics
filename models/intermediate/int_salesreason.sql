with salesorderheadersalesreason as (
	select * 
	from {{ ref('stg_salesorderheadersalesreason') }}	
)
, salesreason as (
	select * 
	from {{ ref('stg_salesreason') }}	
)

, join_reason as ( 
	select
        salesorderheadersalesreason.salesreasonid,
		salesorderheadersalesreason.salesorderid,
        salesreason.reason,
        salesreason.reasontype
	from salesorderheadersalesreason left join salesreason on salesorderheadersalesreason.salesreasonid = salesreason.salesreasonid
)

select *
from join_reason