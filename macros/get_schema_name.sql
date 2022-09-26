{% macro get_schema_name(table_name) %}

{% set schema_name_query %}
select distinct
table_schema,
table_name
from region-us.INFORMATION_SCHEMA.TABLES
where table_name = '{{table_name}}'
order by 1
{% endset %}

{% set results = run_query(schema_name_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}