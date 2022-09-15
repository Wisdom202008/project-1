with 
visits as(
    SELECT
        id as hospital_id,
        patient_id,
        doctor_id,
        created_at as hospital_created_at,
        type as patient_type
    from {{source('staging', 'hospital_visits')}}
)
select * from visits