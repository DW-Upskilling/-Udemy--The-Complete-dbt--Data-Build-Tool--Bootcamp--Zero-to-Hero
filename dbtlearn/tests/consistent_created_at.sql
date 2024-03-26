WITH dim_listings AS (
    SELECT * FROM {{ ref('dim_listings_cleansed') }}
), fct_reviews AS (
    SELECT * FROM {{ ref('fct_reviews') }}
)

SELECT *
FROM dim_listings l 
INNER JOIN fct_reviews r 
    ON l.listing_id = r.listing_id
    AND l.created_at >= r.review_date
LIMIT 10