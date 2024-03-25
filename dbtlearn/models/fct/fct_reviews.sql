{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

WITH src_reviews AS (
    SELECT * FROM {{ ref('src_reviews') }}
)

SELECT * FROM src_reviews
WHERE NVL(review_text, '') <> ''
{% if is_incremental() %}
    AND review_date > (SELECT MAX(review_date) FROM {{ this }})
{% endif %} 