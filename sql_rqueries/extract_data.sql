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

SELECT
    pclass,
    COUNT(*) AS total_passengers,
    SUM(CASE WHEN survived = true THEN 1 ELSE 0 END) AS total_survived,
    SUM(CASE WHEN survived = false THEN 1 ELSE 0 END) AS total_not_survived
FROM titanic
GROUP BY pclass
;

-- Чи були шанси вижити у жінок вищими за шанси чоловіків?

SELECT
    sex
    , SUM(CASE WHEN sex = 'male' THEN 1 ELSE 0 END) AS male
    , SUM(CASE WHEN sex = 'female' THEN 1 ELSE 0 END) AS female
    , SUM(CASE WHEN survived = true THEN 1 ELSE 0 END) AS total_survived,
    SUM(CASE WHEN survived = false THEN 1 ELSE 0 END) AS total_not_surviv
FROM titanic
GROUP BY sex
;

SELECT
    sex,
    COUNT(*) AS total_count, -- загальна кількість людей за статтю
    SUM(CASE WHEN survived = true THEN 1 ELSE 0 END) AS total_survived, -- кількість тих, хто вижив
    SUM(CASE WHEN survived = false THEN 1 ELSE 0 END) AS total_not_survived -- кількість тих, хто не вижив
FROM titanic
GROUP BY sex;
-- Який вік був найбільш критичним для виживання?
