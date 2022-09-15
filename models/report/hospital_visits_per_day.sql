with
daily_visits as (
SELECT 
    hospital_created_at, COUNT(id) as count
FROM {{ref('hospital_doctor_patient')}}
GROUP BY hospital_created_at
ORDER BY hospital_created_at DESC
)
select * from daily_visits