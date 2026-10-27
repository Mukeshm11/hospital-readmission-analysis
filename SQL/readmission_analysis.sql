

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
order by previous_inpatient_group



-- Analyze emergency visits

SELECT
	CASE
    WHEN CAST(number_emergency AS VARCHAR(10)) = '0' THEN '0'
    WHEN CAST(number_emergency AS VARCHAR(10)) = '1' THEN '1'
    WHEN CAST(number_emergency AS VARCHAR(10)) = '2' THEN '2'
    WHEN CAST(number_emergency AS VARCHAR(10)) = '3' THEN '3'
    ELSE '3+' END AS number_of_emergency,

	COUNT(*) AS number_of_encounter,

	sum( case when readmitted = '<30' then 1 else 0 end) AS readmitted_30,

	CAST (
	ROUND(
		100.0 * SUM(CASE WHEN readmitted = '<30' then 1 else 0 end) / count(*) , 2) AS decimal (5,2))
		AS readmission_rate

from Readmission

group by 	
	CASE
    WHEN CAST(number_emergency AS VARCHAR(10)) = '0' THEN '0'
    WHEN CAST(number_emergency AS VARCHAR(10)) = '1' THEN '1'
    WHEN CAST(number_emergency AS VARCHAR(10)) = '2' THEN '2'
    WHEN CAST(number_emergency AS VARCHAR(10)) = '3' THEN '3'
    ELSE '3+' end

ORDER BY readmission_rate desc



-- Analyze length of stays

select

	CASE
	WHEN time_in_hospital = 1 THEN '1'
	WHEN time_in_hospital = 2 THEN '2'
	WHEN time_in_hospital = 3 THEN '3'
	ELSE '3+' END AS Hospital_stays,

	count(*) AS total_encounter,

	SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30,

	ROUND(
		100.0 * SUM( CASE WHEN readmitted= '<30' THEN 1 ELSE 0 END) / 
		count(*), 2) AS readmission_rate

from Readmission

group by 
	CASE
	WHEN time_in_hospital = 1 THEN '1'
	WHEN time_in_hospital = 2 THEN '2'
	WHEN time_in_hospital = 3 THEN '3'
	ELSE '3+' END

ORDER BY 
	readmission_rate desc



-- Analyze medication count

select 
	CASE
		WHEN num_medications BETWEEN 1 AND 5 THEN '1-5'
		WHEN num_medications BETWEEN 6 AND 10 THEN '6-10'
		WHEN num_medications BETWEEN 11 AND 15 THEN '10-15'
		WHEN num_medications BETWEEN 16 AND 20 THEN '16-20'
		WHEN num_medications BETWEEN 21 AND 25 THEN '21-25'
		WHEN num_medications BETWEEN 26 AND 30 THEN '26-30'
		ELSE '30+' END AS Medication_count,

		COUNT(*) AS encounter_count,

		SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30,

		CAST(
		ROUND(
			100.0 * SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) , 2) 
			AS DECIMAL (5,2))
			AS readmission_rate

from Readmission

group by 

CASE
		WHEN num_medications BETWEEN 1 AND 5 THEN '1-5'
		WHEN num_medications BETWEEN 6 AND 10 THEN '6-10'
		WHEN num_medications BETWEEN 11 AND 15 THEN '10-15'
		WHEN num_medications BETWEEN 16 AND 20 THEN '16-20'
		WHEN num_medications BETWEEN 21 AND 25 THEN '21-25'
		WHEN num_medications BETWEEN 26 AND 30 THEN '26-30'
		ELSE '30+' END

ORDER BY
	readmission_rate desc; 



-- Analyze A1C result 
SELECT 
	CASE
		WHEN A1Cresult = '>7' THEN 'Greater_than_7' 
		WHEN A1Cresult = '>8' THEN 'Greater_than_8' 
		WHEN A1Cresult = 'Norm' THEN 'Normal'
		END AS A1C_Result, 

		COUNT(*) AS encounter_count,

		SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30,

		CAST(
		ROUND(
			100.0 * SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) , 2) 
			AS DECIMAL (5,2))
			AS readmission_rate
		

from Readmission

WHERE A1Cresult in ('Norm','>7','>8')

group by 
	CASE
		WHEN A1Cresult = '>7' THEN 'Greater_than_7' 
		WHEN A1Cresult = '>8' THEN 'Greater_than_8' 
		WHEN A1Cresult = 'Norm' THEN 'Normal'
		END

order by readmission_rate desc



-- Analyze medication change

SELECT
	CASE
		WHEN num_medications BETWEEN 1 AND 10 THEN '1-10'
		WHEN num_medications BETWEEN 11 AND 20 THEN '11-20'
		WHEN num_medications BETWEEN 21 AND 30 THEN '21-30'
		WHEN num_medications BETWEEN 31 AND 40 THEN '31-40'
		WHEN num_medications BETWEEN 41 AND 50 THEN '41-50'
		ELSE '50+' END AS Medication_range,

	COUNT(*) AS encounter_count,

	SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30,

	CAST(
		ROUND(
			100.0 * SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) , 2) 
			AS DECIMAL (5,2))
			AS readmission_rate

FROM Readmission

GROUP BY
		CASE
		WHEN num_medications BETWEEN 1 AND 10 THEN '1-10'
		WHEN num_medications BETWEEN 11 AND 20 THEN '11-20'
		WHEN num_medications BETWEEN 21 AND 30 THEN '21-30'
		WHEN num_medications BETWEEN 31 AND 40 THEN '31-40'
		WHEN num_medications BETWEEN 41 AND 50 THEN '41-50'
		ELSE '50+' END

ORDER BY 
		readmission_rate DESC;



SELECT
	CASE
		WHEN age = '0-10' THEN '0-10'
		WHEN age = '10-20' THEN '10-20'
		WHEN age = '20-30' THEN '21-30'
		ELSE '30+' END AS age_range,

	COUNT(*) AS encounter_count,

	SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30,

	CAST(
		ROUND(
			100.0 * SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) , 2) 
			AS DECIMAL (5,2))
			AS readmission_rate

FROM Readmission

GROUP BY
		CASE
		WHEN age = '0-10' THEN '0-10'
		WHEN age = '10-20' THEN '10-20'
		WHEN age = '20-30' THEN '21-30'
		ELSE '30+' END

ORDER BY 
		readmission_rate DESC;


		select number_emergency from Readmission


SELECT
	CASE
		WHEN number_emergency between 0 AND 5 THEN '0-5'
		WHEN number_emergency between 6 AND 10 THEN '6-10'
		WHEN number_emergency between 11 AND 15 THEN '11-15'
		WHEN number_emergency between 16 AND 20 THEN '16-20'
		ELSE '20+' END,


	COUNT(*) AS encounter_count,

	SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_30,

	CAST(
		ROUND(
			100.0 * SUM( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) , 2) 
			AS DECIMAL (5,2))
			AS readmission_rate

FROM Readmission

GROUP BY
		CASE
		WHEN number_emergency between 0 AND 5 THEN '0-5'
		WHEN number_emergency between 6 AND 10 THEN '6-10'
		WHEN number_emergency between 11 AND 15 THEN '11-15'
		WHEN number_emergency between 16 AND 20 THEN '16-20'
		ELSE '20+' END

ORDER BY 
		readmission_rate DESC;