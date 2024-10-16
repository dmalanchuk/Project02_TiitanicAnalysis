SELECT *
FROM titanic;

SELECT Pclass, Sex, Age, COUNT(*) AS passenger_count
FROM titanic
GROUP BY Pclass, Sex, Age
ORDER BY Pclass, Sex, Age;

SELECT survived, count(*) as total_surv
FROM titanic
group by survived;


-- Як клас квитка впливав на виживання?

WITH surv_procent AS (
    SELECT
        COALESCE(age, (SELECT round(avg(age)) FROM titanic)) AS age_with_avg,
        pclass,
        COUNT(*) AS total_passengers,
        SUM(CASE WHEN survived = true THEN 1 ELSE 0 END) AS total_survived
FROM titanic
GROUP BY pclass, age
)

SELECT
    age_with_avg,
    pclass,
    round((total_survived * 1.0 / total_passengers), 4) AS rate
FROM surv_procent
ORDER BY 2
;

-- Чи були шанси вижити у жінок вищими за шанси чоловіків?

WITH survival_count AS (SELECT sex,
                               SUM(CASE WHEN survived = true THEN 1 ELSE 0 END)  AS total_survived,
                               SUM(CASE WHEN survived = false THEN 1 ELSE 0 END) AS total_not_survived
                        FROM titanic
                        GROUP BY sex)

SELECT
    (female_survived::float / female_not_survived) /
    (male_survived::float / male_not_survived) AS odds_ratio,

    CASE
        WHEN (female_survived::float / female_not_survived) /
        (male_survived::float / male_not_survived) > 1 THEN 'Шанси вижити у жінок вищі'
        WHEN (female_survived::float / female_not_survived) /
             (male_survived::float / male_not_survived) < 1 THEN 'Шанси вижити у жінок нижчі'
        ELSE 'Шанси вижити у жінок і чоловіків майже однакові'
    END AS interpretation
FROM (
    SELECT
        MAX(CASE WHEN sex = 'female' THEN total_survived ELSE 0 END) AS female_survived,
        MAX(CASE WHEN sex = 'female' THEN total_not_survived ELSE 0 END) AS female_not_survived,
        MAX(CASE WHEN sex = 'male' THEN total_survived ELSE 0 END) AS male_survived,
        MAX(CASE WHEN sex = 'male' THEN total_not_survived ELSE 0 END) AS male_not_survived
    FROM survival_count
     ) AS calculated
;


-- Який вік був найбільш критичним для виживання?

WITH main_age AS (
    SELECT
        age,
        COALESCE(age, (SELECT round(avg(age)) FROM titanic)) AS age_with_avg,
        survived,
        pclass,
        sex
    FROM titanic
)
SELECT
    CASE
        WHEN age_with_avg BETWEEN 0 AND 14 THEN 'babies'
        WHEN age_with_avg BETWEEN 15 AND 18 THEN 'teenagers'
        WHEN age_with_avg BETWEEN 19 AND 60 THEN 'adults'
        ELSE 'seniors'
    END AS grouped_age,
    COUNT(*) AS total_people,
    SUM(CASE WHEN survived = true THEN 1 ELSE 0 END) AS total_survived_people,
    ROUND((SUM(CASE WHEN survived = true THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS survival_percentage,
    pclass,
    sex
FROM main_age
GROUP BY grouped_age, pclass, sex
ORDER BY pclass;

