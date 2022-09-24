

 {#
    This macro unions all available tables from all mathcing schemas 
#}

{% macro dynamic_union()  -%}

    {% set relation_to_select = dbt_utils.get_relations_by_pattern(
        schema_pattern='wisdom%',
        table_pattern='doctors'
    ) %}

    {% set sql_to_execute = [] %}

    {{ log('Statements to run:', info=True) }}

    {% for relation in relation_to_select %}
        {% set sql_command -%}
        
        select a.* , '{{ relation.schema }}' as source_dataset from {{ relation }} a
        {% if not loop.last %} union all {% endif %}

        {%- endset %}
        {% do log(sql_command, info=True) %}
        {% do sql_to_execute.append(sql_command) %}
    {% endfor %}

{%- endmacro %}