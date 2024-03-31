WITH mart_fullmoon_reviews AS (
    SELECT * FROM {{ ref('mart_fullmoon_reviews') }}
)

SELECT
    is_full_moon,
    review_sentiment,
    count(*) as reviews
FROM mart_fullmoon_reviews
GROUP BY 1, 2
ORDER BY 1, 2
