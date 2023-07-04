WITH 
    order_header_reason AS (
        SELECT * 
        FROM {{ ref('stg_salesorderheadersalesreason') }}	
    ), 
    sales_reason AS (
        SELECT * 
        FROM {{ ref('stg_salesreason') }}	
    ), 
    union_reason AS ( 
        SELECT
            order_header_reason.salesorderid, 
            sales_reason.*
        FROM order_header_reason
        LEFT JOIN sales_reason ON sales_reason.salesreasonid = order_header_reason.salesreasonid
        ORDER BY reasontype DESC
    ),
    aggregate_columns AS (
        SELECT
            salesorderid,
            STRING_AGG(reasontype, ', ') AS agg_reason_type,
            STRING_AGG(reason, ', ') AS agg_name_reason
        FROM union_reason
        GROUP BY salesorderid
    ), 
    replace_aggregate AS (
        SELECT 
            salesorderid,
            REPLACE(agg_reason_type, 'Other, Other', 'Other') AS reason_type,
            REPLACE(agg_name_reason, 'Other, Other', 'Other') AS name_reason
        FROM aggregate_columns
    )
SELECT *
FROM replace_aggregate
