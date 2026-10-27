-- Validating the unique counters (checking the unique encounter)

/*
select COUNT(*) AS Total_Rows,
COUNT( DISTINCT encounter_id) AS Unique_encounterID,
COUNT(DISTINCT patient_nbr) AS Unique_PatientID
from Readmission


-- Check target distribution (checking the distribution of readmition for <30,>30, 
-- and NO by calculating the encounter count and percentage)

select 
	readmitted,
	count(*) as encounter_count,
	ROUND (100.0 * count(*) / sum(count(*)) over (),2) AS percentagee
	from readmission
	group by readmitted
	order by encounter_count

	*/

	