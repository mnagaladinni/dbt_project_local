{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}
with src_reviews as (
    select * from {{ref("src_reviews")}}
)
select 
    {{ dbt_utils.generate_surrogate_key(['LISTING_ID', 'REVIEW_DATE', 'REVIEWER_NAME', 'REWIEW_TEXT']) }} as review_id,
    *
from 
    src_reviews
where 
    rewiew_text is not null 
{% if is_incremental() %}
    and review_date > (select max(review_date) from {{this}})
{% endif %}