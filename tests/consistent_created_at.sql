select 
* 
from {{ ref('fct_reviews') }} as r
inner join {{ ref('dim_listings_cleansed') }} as l on 
r.listing_id = l.listing_id
where 
r.review_date <= l.created_at

