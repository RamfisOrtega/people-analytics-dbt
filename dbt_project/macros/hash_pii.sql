{% macro hash_pii(column) %}
    {% if target.type == 'snowflake' %}
        sha2(lower(trim({{ column }})), 256)
    {% else %}
        sha256(lower(trim({{ column }})))
    {% endif %}
{% endmacro %}
