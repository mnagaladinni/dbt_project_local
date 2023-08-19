{{
    config(
    materialized = 'view',
    )
}}
with src_hosts as (
    select * from {{ref("src_hosts")}}
)
select
    host_id,
    coalesce(host_name,'Anonymous') as host_name,
    IS_SUPERHOST,
    CREATED_AT,
    UPDATED_AT
from 
    src_hosts