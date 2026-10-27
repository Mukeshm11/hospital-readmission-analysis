-- Validating the unique counters

/*
select COUNT(*) AS Total_Rows,
COUNT( DISTINCT encounter_id) AS Unique_encounterID,
COUNT(DISTINCT patient_nbr) AS Unique_PatientID
from Readmission


-- Check target distribution
select
	readmitted,
	COUNT(*) as encounter_count,
	CAST (
	ROUND( 
		100.0* COUNT(*)/sum(count(*)) over(), 2) AS decimal (5,2) )
	AS Percentage
	from Readmission
	group by readmitted
	order by encounter_count

	

-- Calculate 30-days readmission rate

Select	
	count(*) AS total_encounter,
	SUM(CASE WHEN readmitted = '<30' then 1 else 0 END)
		AS readmitted_within30days,
	CAST(
	ROUND( 
		100.0 * SUM(CASE WHEN readmitted = '<30' then 1 else 0 END)/
			count(*), 2) AS decimal (5,2))
				AS readmitted_rate
from Readmission

*/

-- Analyze previous inpatient visits

