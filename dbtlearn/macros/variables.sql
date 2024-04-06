{% macro learn_variables() %}
    {% set temp = "Hello World" %}
    {{ log("Variable says " ~ temp, info=True) }}

    {{ log("Hello there " ~ var("username", "DEFAULT") ~ "!", info=True) }}
{% endmacro %}