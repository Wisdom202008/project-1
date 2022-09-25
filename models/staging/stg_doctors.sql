with 
doctors as(
    SELECT
        doctor_id,
        doctor_name,
        doctor_created_at
    from {{source('staging', 'doctors')}}
)
select * from doctors