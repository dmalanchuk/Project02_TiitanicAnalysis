SELECT *
FROM titanic;

SELECT survived, count(*) as total_surv
FROM titanic
group by survived;

SELECT Sex, COUNT(*) AS passenger_count
FROM titanic
GROUP BY Sex;

SELECT pclass, count(*) as pclas_count
from titanic
group by pclass;

SELECT age, count(*) as age_count
from titanic
group by age;


-- Як клас квитка впливав на виживання?

WITH surv_procent AS (
    SELECT
        pclass,
        COUNT(*) AS total_passengers,
        SUM(CASE WHEN survived = true THEN 1 ELSE 0 END) AS total_survived
FROM titanic
GROUP BY pclass
)

SELECT
    pclass,
    round((total_survived * 1.0 / total_passengers), 4) AS rate
FROM surv_procent
;

-- Чи були шанси вижити у жінок вищими за шанси чоловіків?

WITH survival_count AS (SELECT sex,
                               SUM(CASE WHEN survived = true THEN 1 ELSE 0 END)  AS total_survived,    -- кількість тих, хто вижив
                               SUM(CASE WHEN survived = false THEN 1 ELSE 0 END) AS total_not_survived -- кількість тих, хто не вижив
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
