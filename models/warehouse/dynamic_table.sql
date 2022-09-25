{% set event_relations = dbt_utils.get_relations_by_pattern('wisdom_%', 'doctors') %}
{{ dbt_utils.union_relations(relations = event_relations) }}