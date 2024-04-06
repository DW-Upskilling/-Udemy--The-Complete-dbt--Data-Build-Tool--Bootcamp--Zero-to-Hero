{% macro learn_logging() %}
    {{ log("logs/dbt.log") }}
    {{ log("logs/dbt.log + console", info=True) }}
    {# This is a comment #}
{% endmacro %}
