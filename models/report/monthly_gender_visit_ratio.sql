WITH 
MONTHLY_COUNT AS (
    SELECT 
        EXTRACT(YEAR FROM  DATETIME(hospital_created_at)) AS YEAR,
        FORMAT_DATETIME("%B", DATETIME(hospital_created_at)) AS month,
        SUM(CASE WHEN patient_sex = 'female' THEN 1 ELSE 0 END) FEMALE_COUNT ,
        SUM(CASE WHEN patient_sex = 'male' THEN 1 ELSE 0 END) MALE_COUNT,
        COUNT(*) as TOTAL_COUNT
    FROM {{ref('hospital_doctor_patient')}}
    GROUP BY 
        hospital_created_at, 
        FORMAT_DATETIME("%B", DATETIME(hospital_created_at)),
        EXTRACT(YEAR FROM  DATETIME(hospital_created_at))
),
RATIO AS (
    SELECT 
        YEAR,
        MONTH, FEMALE_COUNT,
        ROUND((FEMALE_COUNT/TOTAL_COUNT)*100,1) FM_RATIO,
        MALE_COUNT,
        ROUND((MALE_COUNT/   TOTAL_COUNT)*100,1) M_RATIO
    FROM MONTHLY_COUNT
)
    SELECT
        YEAR, 
        MONTH,
        FEMALE_COUNT,
        MALE_COUNT,
        FM_RATIO,
        M_RATIO,
        FM_RATIO  ||' : '|| M_RATIO AS GENDER_RATIO
    FROM RATIO