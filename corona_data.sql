
-- 1. Find the number of corona patients who faced shortness of breath.

use coronadata;
select * from corona_tested_006;
SELECT COUNT(*)  AS num_patients_shortness_of_breath
From corona_tested_006
WHERE shortness_of_breath = 'TRUE';


-- 2. Find the number of negative corona patients who have fever and sore_throat

SELECT COUNT(*) AS no_of_negativecorona_patients
From corona_tested_006
where Corona = 'Negative'
and Fever = 'false'
and Sore_throat = 'false';

-- 3. Group the data by month and rank the number of positive cases.

SELECT
    DATE_FORMAT(Test_date, '%m') AS month,
    COUNT(*) AS num_positive_cases,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS Rank_positive
    from corona_tested_006
WHERE
    Corona = 'Positive'
GROUP BY
    DATE_FORMAT(Test_date, '%m')
ORDER BY
    month;

-- 4. Find the female negative corona patients who faced cough and headache
SELECT * from corona_tested_006
where Corona = 'Negative'
and sex = 'female'
and Cough_symptoms = 'true'
and Headache = 'true';


-- 5. How many elderly corona patients have faced breathing problems?
SELECT COUNT(*) AS num_elderly_breathing_problems
FROM corona_tested_006
WHERE Age_60_above >= 34
  AND Shortness_of_breath = 'true';

-- 6. Which three symptoms were more common among COVID positive patients?
SELECT
    Cough_symptoms,
    COUNT(*) AS num_occurrences
FROM
    corona_tested_006
WHERE
    Corona = 'Positive'
GROUP BY
    Cough_symptoms
ORDER BY
    num_occurrences DESC
LIMIT 2;

-- 7. Which symptom was less common among COVID negative people?
 
select Cough_symptoms, Fever, Sore_throat, Shortness_of_breath, Headache, Corona as symptom 
from corona_tested_006
limit 5;

WITH Corona AS (
    SELECT Corona.negative as covid_negative
    FROM corona_tested_006
    WHERE covid_positive = 'True'
)

SELECT Corona, COUNT(*) AS count
FROM corona_tested_006
GROUP BY Corona
ORDER BY count DESC
LIMIT 1;

-- 8. What are the most common symptoms among COVID positive males whose known contact was abroad? 

SELECT  Corona, count(*) As no_of_patients
from corona_tested_006
where Corona = 'Negative'
and sex = 'male'
and Known_contact = 'Abroad';



