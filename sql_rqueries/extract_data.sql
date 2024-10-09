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
