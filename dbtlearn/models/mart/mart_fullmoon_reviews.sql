WITH fct_reviews AS (
    SELECT * FROM {{ ref('fct_reviews') }}
), full_moon_dates AS (
    SELECT * FROm {{ ref('seed_full_moon_dates') }}
)

SELECT 
    r.*, 
    CASE 
        WHEN fd.full_moon_date IS NULL THEN 'N'
        ELSE 'Y'
    END AS is_full_moon
FROM fct_reviews r
LEFT JOIN full_moon_dates fd ON TO_DATE(r.review_date) = DATEADD(DAY, 1, fd.full_moon_date)