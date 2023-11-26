--average balance for each job and education level
SELECT job, education, AVG(balance) AS avg_balance
FROM Bank_Marketing
GROUP BY job, education;

--count the number of people who have a housing loan and a personal loan
SELECT COUNT(*) AS count_people
FROM Bank_Marketing
WHERE housing = 'yes' AND loan = 'yes';

--find the average duration of contact for each month
SELECT month, AVG(duration) AS avg_duration
FROM Bank_Marketing
GROUP BY month;

--identify the job with the highest average balance
SELECT job, AVG(balance) AS avg_balance
FROM Bank_Marketing
GROUP BY job
ORDER BY avg_balance DESC


--find the number of people contacted in each month, grouped by month and day of the month
SELECT month, day, COUNT(*) AS contact_count
FROM Bank_Marketing
GROUP BY  month, day;

--calculate the conversion rate (successful outcomes) by education level
SELECT education, COUNT(CASE WHEN poutcome = 'success' THEN 1 END) AS successful_outcomes,
       COUNT(*) AS total_contacts,
       (COUNT(CASE WHEN poutcome = 'success' THEN 1 END) * 100.0 / COUNT(*)) AS conversion_rate
FROM Bank_Marketing
GROUP BY education;

--find the average balance of people contacted in the last campaign
SELECT AVG(balance) AS avg_balance_last_campaign
FROM Bank_Marketing
WHERE pdays > 0;

--find the most common contact day of the month for each job
WITH RankedDays AS (
    SELECT job, day,
           ROW_NUMBER() OVER (PARTITION BY job ORDER BY COUNT(*) DESC) AS ranking
    FROM Bank_Marketing
    GROUP BY job, day
)
SELECT job, day, ranking
FROM RankedDays
WHERE ranking = 1;


--find customers with above-average balances and their contact details
WITH AvgBalance AS (
    SELECT AVG(balance) AS avg_balance
    FROM Bank_Marketing
)
SELECT bd.*, ab.avg_balance
FROM Bank_Marketing bd
JOIN AvgBalance ab ON 1=1
WHERE bd.balance > ab.avg_balance;

--rank customers based on their balance within each job category
SELECT
    job,
    age,
    balance,
    RANK() OVER (PARTITION BY job ORDER BY balance DESC) AS balance_rank
FROM Bank_Marketing;

--calculate the cumulative sum of balances over months
SELECT
    month,
    day,
    balance,
    SUM(balance) OVER (ORDER BY month, day) AS cumulative_balance
FROM Bank_Marketing;

--find the average balance change from the previous contact to the current one
SELECT
    age,
    balance,
    LAG(balance) OVER (ORDER BY age) AS prev_balance,
    balance - LAG(balance) OVER (ORDER BY age) AS balance_change
FROM Bank_Marketing;

--find the most common combination of job and marital status
SELECT
    job,
    marital,
    COUNT(*) AS count
FROM Bank_Marketing
GROUP BY job, marital
ORDER BY count DESC


--find the contact duration percentile for each job
WITH DurationPercentiles AS (
    SELECT
        job,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY duration) OVER (PARTITION BY job) AS median_duration
    FROM Bank_Marketing
)
SELECT bd.job, bd.duration, dp.median_duration
FROM Bank_Marketing bd
JOIN DurationPercentiles dp ON bd.job = dp.job;

--find the average balance for people who were contacted more than once in a day
SELECT
    day,
    AVG(balance) AS avg_balance
FROM Bank_Marketing
WHERE age IN (
    SELECT age
    FROM Bank_Marketing
    GROUP BY age
    HAVING COUNT(*) > 1
)
GROUP BY day;
