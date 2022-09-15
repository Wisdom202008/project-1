with 
    visit as (
        SELECT 
            hospital_id,
            patient_id,
            doctor_id,
            hospital_created_at,
            patient_type
        FROM {{ref('stg_hospital_visits')}}
    ),
    patient as (
        select
            patient_id,
            patient_name,
            patient_created_at,
            patient_sex
        from {{ref('stg_patients')}}
    ),
    doctor as (
        select
            doctor_id,
            doctor_name,
            doctor_created_at
        from {{ref('stg_doctors')}}
    ),
    stg_final as (
        select
            substr(v.hospital_id, 1,5)||substr(v.patient_id,1,5)||substr(v.doctor_id, 1,5) as id,
            v.hospital_id, 
            v.patient_id,
            p.patient_name,
            p.patient_sex,
            cast(p.patient_created_at as date) as patient_created_at,
            v.doctor_id,
            d.doctor_name,
            cast(doctor_created_at as date ) as doctor_created_at,	
            cast(v.hospital_created_at as date) as hospital_created_at,
            v.patient_type
        from visit v
        left join doctor d
        on v.doctor_id = d.doctor_id
        left join patient p
        on v.patient_id = p.patient_id
    )
    select * from stg_final