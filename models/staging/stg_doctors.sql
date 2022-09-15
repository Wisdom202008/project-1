with 
doctors as(
    SELECT
        id as doctor_id,
        name as doctor_name,
        created_at as doctor_created_at
    from {{source('staging', 'doctors')}}
)
select * from doctors