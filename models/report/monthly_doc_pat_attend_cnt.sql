with 
monthly_doc_pat_attend_cnt as (
    SELECT 
        doctor_id, 
        doctor_name,
        FORMAT_DATETIME("%B", DATETIME(hospital_created_at)) as month,
        COUNT(id) as count
    FROM {{ref('hospital_doctor_patient')}}
    GROUP BY doctor_id, doctor_name, FORMAT_DATETIME("%B", DATETIME(hospital_created_at))
)
select * from monthly_doc_pat_attend_cnt