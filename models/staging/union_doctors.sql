{%- set schema_names  = get_schema_name() -%}

{% for schema in schema_names %}
(
  select
    '{{schema}}' as schema_name,
    doctor_id,
    doctor_name,
    doctor_created_at
   
  from {{schema}}.doctors
)

{% if not loop.last %}
union all
{% endif %}
{% endfor %}