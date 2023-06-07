{{
  config(
    materialized='view'
  )
}}
with delta as (
    select * from {{ref('stg_orders')}}
),
target as (
select * from {{ref('dwh_orders')}}
),
final as (
    select
    delta.order_id as d_order_id,
    target.order_id as t_order_id,
    delta.order_name as d_order_name,
    target.order_name as t_order_name,
    delta.start_date as d_start_date,
    target.start_date as t_start_date,
    delta.end_date as d_end_date,
    target.end_date as t_end_date,
    delta.apply_kind
    from delta
    full join target 
    ON delta.order_id = target.order_id
    AND delta.start_date = target.start_date
)
select * from final