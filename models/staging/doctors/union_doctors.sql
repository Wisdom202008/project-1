{%- set schema_names  = get_schema_name('doctors') -%}

{% for schema in schema_names %}
(
  select
    '{{schema}}' as schema_name,
    doctor_id,
    doctor_name,
    doctor_created_at,
    CURRENT_TIMESTAMP() as run_date
  from {{schema}}.doctors
)

{% if not loop.last %}
union all
{% endif %}
{% endfor %}