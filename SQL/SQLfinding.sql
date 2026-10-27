
-- Calculate 30 days readmission rate

select 
	count(*) as total_encounter,
	SUM(case when readmitted = '<30' then 1 else 0 end)
		AS readmitted_within_30_days,
	round(
		100 * SUM(case when readmitted = '<30' then 1 else 0 end) /
			count(*), 2) as readmission_rate_30_days
	from readmission;



-- Analyze previous inpatient visit

select 
	CASE
		when number_inpatient = 0 then '0'
		when number_inpatient = 1 then '1'
		when number_inpatient = 2 then '2'
		else '3+'
		end AS previous_inpatient_group,
	COUNT(*) AS encounters,
	SUM(case when readmitted = '<30' then 1 else 0 end) AS readmitted_within_30days,
	ROUND( 100 * sum(case when readmitted = '<30' then 1 else 0 end) / COUNT(*) ,2)
	AS readmission_rate
from Readmission
group by 
		CASE
		when number_inpatient = 0 then '0'
		when number_inpatient = 1 then '1'
		when number_inpatient = 2 then '2'
		else '3+' end
order by previous_inpatient_group;



-- Analyze readmission with respect to age

SELECT
	age, count(*) as encounter,
	SUM(case when readmitted = '<30' then 1 else 0 end) AS readmitted_within_30days,
	ROUND( 100 * sum(case when readmitted = '<30' then 1 else 0 end) / COUNT(*) ,2)
	AS readmission_rate

from Readmission

group by age

order by readmission_rate desc;



-- Analyze emergency visits 

Select 
CASE
    WHEN TRY_CAST(CAST(number_emergency AS VARCHAR(20)) AS INT) = 0 THEN '0'
    WHEN TRY_CAST(CAST(number_emergency AS VARCHAR(20)) AS INT) = 1 THEN '1'
    WHEN TRY_CAST(CAST(number_emergency AS VARCHAR(20)) AS INT) = 2 THEN '2'
    WHEN TRY_CAST(CAST(number_emergency AS VARCHAR(20)) AS INT) >= 3 THEN '3+'
    ELSE 'Missing/Invalid'
END AS emergency_visit,
COUNT(*) as encouners,
SUM(case when readmitted = '<30' then 1 else 0 end) As readmission,
CAST(
	ROUND( 100 *
		sum(case when readmitted = '<30' then 1 else 0 end)/ count(*),  
			2)AS decimal(5,2)) AS readmission_rate
from Readmission
group by CASE
    WHEN TRY_CAST(CAST(number_emergency AS VARCHAR(20)) AS INT) = 0 THEN '0'
    WHEN TRY_CAST(CAST(number_emergency AS VARCHAR(20)) AS INT) = 1 THEN '1'
    WHEN TRY_CAST(CAST(number_emergency AS VARCHAR(20)) AS INT) = 2 THEN '2'
    WHEN TRY_CAST(CAST(number_emergency AS VARCHAR(20)) AS INT) >= 3 THEN '3+'
    ELSE 'Missing/Invalid' end
order by readmission_rate desc;



-- Analyze length of stay

SELECT 
	CASE when time_in_hospital between 1 and 3 then '1-3'
		when time_in_hospital between 4 and 6 then '4-6'
		when time_in_hospital between 7 and 9 then '7-9'
		when time_in_hospital between 10 and 12 then '10-12'
		else '12+' END AS Length_of_stay,
	COUNT(*) as encouners,
SUM(case when readmitted = '<30' then 1 else 0 end) As readmission,
CAST(
	ROUND( 100 *
		sum(case when readmitted = '<30' then 1 else 0 end)/ count(*),  
			2)AS decimal(5,2)) AS readmission_rate
FROM Readmission
group by CASE when time_in_hospital between 1 and 3 then '1-3'
		when time_in_hospital between 4 and 6 then '4-6'
		when time_in_hospital between 7 and 9 then '7-9'
		when time_in_hospital between 10 and 12 then '10-12'
		else '12+' END 
order by readmission_rate desc;


-- Analyze medication count

SELECT
	CASE WHEN num_medications BETWEEN 1 AND 10 then '1-10'
		WHEN num_medications BETWEEN 11 AND 20 then '11-20'
		WHEN num_medications BETWEEN 21 AND 30 then '21-30'
		ELSE '31+' END AS Medication_count,
	COUNT(*) AS encounter,
	SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) readmitted_30,
	ROUND(
		100 *
			SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*), 2)
			AS readmission_count

FROM Readmission 
group by CASE WHEN num_medications BETWEEN 1 AND 10 then '1-10'
		WHEN num_medications BETWEEN 11 AND 20 then '11-20'
		WHEN num_medications BETWEEN 21 AND 30 then '21-30'
		ELSE '31+' END
Order by readmission_count desc;



-- Analyze A1C result

SELECT 
	A1Cresult,
	COUNT(*) as encounter,
	SUM( CASE when readmitted = '<30' then 1 else 0 end) AS readmitted_30,
	CAST(
	ROUND(
		100.0 *
			sum(case when readmitted = '<30' then 1 else 0 end) / count(*),2) 
			AS decimal(5,2))
			AS readmission_rate

from Readmission
group by A1Cresult
order by readmission_rate desc;



-- Analyze medication change

SELECT 
	change,
	COUNT(*) as encounter,
	SUM( CASE when readmitted = '<30' then 1 else 0 end) AS readmitted_30,
	CAST(
	ROUND(
		100.0 *
			sum(case when readmitted = '<30' then 1 else 0 end) / count(*),2) 
			AS decimal(5,2))
			AS readmission_rate

from Readmission
Group by change
Order by readmission_rate desc;



-- Analyze diagnosis category

SELECT 
 diag_1_category,
 COUNT(*) as encounter,
	SUM( CASE when readmitted = '<30' then 1 else 0 end) AS readmitted_30,
	CAST(
	ROUND(
		100.0 *
			sum(case when readmitted = '<30' then 1 else 0 end) / count(*),2) 
			AS decimal(5,2))
			AS readmission_rate

FROM Readmission
Group by diag_1_category
order by readmission_rate desc;


-- Analyze Admission type

SELECT
	CASE when admission_type_id = 1 then 'Emergency'
		when admission_type_id = 2 then 'Urgenct'
		when admission_type_id = 3 then 'Elective'
		when admission_type_id = 4 then 'Newborn'
		when admission_type_id = 5 then 'Not_available'
		when admission_type_id = 6 then 'NULL'
		when admission_type_id = 7 then 'Truma_Center'
		when admission_type_id = 8 then 'Not_mapped' END AS Admission_type,

	COUNT(*) AS encounter,

	SUM( CASE when readmitted = '<30' then 1 else 0 end) AS readmitted_30,

	CAST(
	ROUND(
		100.0 *
			sum(case when readmitted = '<30' then 1 else 0 end) / count(*),2) 
			AS decimal(5,2))
			AS readmission_rate

FROM Readmission

Group by CASE when admission_type_id = 1 then 'Emergency'
		when admission_type_id = 2 then 'Urgenct'
		when admission_type_id = 3 then 'Elective'
		when admission_type_id = 4 then 'Newborn'
		when admission_type_id = 5 then 'Not_available'
		when admission_type_id = 6 then 'NULL'
		when admission_type_id = 7 then 'Truma_Center'
		when admission_type_id = 8 then 'Not_mapped' END
Order by readmission_rate desc;



-- Analyze discharge disposition
SELECT
    CASE when discharge_disposition_id = 1 then 'Discharged to home'
		 when discharge_disposition_id = 3 then 'Discharged/transferred to SNF'
		 when discharge_disposition_id = 6  then 'Discharged/transferred to home with home health service'
		 Else 'Other' END AS Discharge_disposition,

    COUNT(*) AS encounter,

	SUM( CASE when readmitted = '<30' then 1 else 0 end) AS readmitted_30,

	CAST(
	ROUND(
		100.0 *
			sum(case when readmitted = '<30' then 1 else 0 end) / count(*),2) 
			AS decimal(5,2))
			AS readmission_rate

FROM Readmission
GROUP BY CASE when discharge_disposition_id = 1 then 'Discharged to home'
		 when discharge_disposition_id = 3 then 'Discharged/transferred to SNF'
		 when discharge_disposition_id = 6  then 'Discharged/transferred to home with home health service'
		 Else 'Other' END

ORDER BY readmission_rate DESC;