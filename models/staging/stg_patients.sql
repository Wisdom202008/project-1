with 
patients as(
    SELECT
        id as patient_id,
        name as patient_name,
        created_at as patient_created_at,
        sex patient_sex
    from {{source('staging', 'patients')}}
)
select * from patients