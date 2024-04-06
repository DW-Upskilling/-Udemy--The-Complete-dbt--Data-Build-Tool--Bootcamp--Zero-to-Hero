{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

WITH src_reviews AS (
    SELECT * FROM {{ ref('src_reviews') }}
)

SELECT 
    {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id, 
    * 
FROM src_reviews
WHERE NVL(review_text, '') <> ''
{% if is_incremental() %}
    {{ log(this ~ ' incremental_load()', info=True) }}
    {% if var('reviews_start_date', False) and var('reviews_end_date', False) %}
        {{ log(this ~ ' from: ' ~ var('reviews_start_date') ~ ' to: ' ~ var('reviews_end_date'), info=True) }}
        AND review_date >= '{{ var("reviews_start_date") }}'
        AND review_date < '{{ var("reviews_end_date") }}'
    {% else %}
        {{ log(this ~ ' pulling everthing else not loaded...', info=True) }}
        AND review_date > (SELECT MAX(review_date) FROM {{ this }})
    {% endif %} 
{% endif %} 