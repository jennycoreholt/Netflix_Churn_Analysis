--  1. Define Churn: What is Netflix's overall churn rate?

-- Double check we have only to values and they represent boolean values.
SELECT DISTINCT
	churned
FROM netflix_customer_churn.customer_information;

-- What is the overall churn rate (%) ?
SELECT 
	COUNT(
		CASE WHEN churned = 1 
			THEN 1
			ELSE NULL 
		END
	) AS churned_customers,
    COUNT(
		CASE WHEN churned = 0 
			THEN 0 
            ELSE NULL 
		END
        ) AS active_customers,
	COUNT(*) AS total_customers,
	ROUND(
      COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
		) * 100.0 / COUNT(*), 2
    ) AS churn_rate_pct
FROM netflix_customer_churn.customer_information;

-- 2. What plans have the highest churn rate?
   SELECT 
    st.subscription_type,
    MAX(p.monthly_fee) AS monthly_fee,
    SUM(CASE WHEN ci.churned = 1 THEN p.monthly_fee END) AS churned_revenue,
    COUNT(CASE WHEN ci.churned = 1 THEN 1 END) AS churned_customers,
    COUNT(CASE WHEN ci.churned = 0 THEN 1 END) AS active_customers,
    COUNT(ci.customer_id) AS total_customers
FROM netflix_customer_churn.customer_insights AS ci
JOIN netflix_customer_churn.subscription_types AS st
    ON ci.customer_id = st.customer_id
JOIN netflix_customer_churn.payments AS p
    ON ci.customer_id = p.customer_id
GROUP BY st.subscription_type
ORDER BY st.subscription_type;

-- 3. What age groups are most likey to churn?
SELECT 
	CASE 
		WHEN age BETWEEN 18 AND 29 THEN '18 - 29'
		WHEN age BETWEEN 30 AND 39 THEN '30 - 39'
        WHEN age BETWEEN 40 AND 49 THEN '40 - 49'
        WHEN age BETWEEN 50 AND 59 THEN '50 - 59'
        ELSE '60+'
	END AS age_group,
    COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
	) AS churned_customers,
    COUNT(
		CASE WHEN churned = 0 
			THEN 0 
			ELSE NULL 
		END
	) AS active_customers,
	COUNT(*) AS total_customers,
    ROUND(
      COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
		) * 100.0 / COUNT(*), 2
    ) AS churn_rate_pct
FROM netflix_customer_churn.customer_information
GROUP BY age_group
ORDER BY churn_rate_pct DESC;

-- what is the median age of churned vs non-churned customers?
WITH ranked AS (
    SELECT
        churned,
        age,
        ROW_NUMBER() OVER (PARTITION BY churned ORDER BY age) AS rn,
        COUNT(*) OVER (PARTITION BY churned) AS total_count
    FROM netflix_customer_churn.customer_information
)
SELECT
    churned,
    AVG(age) AS median_age
FROM ranked
WHERE rn IN (
        FLOOR((total_count + 1) / 2),
        CEIL((total_count + 1) / 2)
)
GROUP BY churned;


SELECT 
	age,
	COUNT(age) AS 'total_customers',
    COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
	) AS churned_customers,
    ROUND(
      COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
		) * 100.0 / COUNT(*), 2
    ) AS churn_rate_pct
FROM netflix_customer_churn.customer_information
GROUP BY age
ORDER BY churn_rate_pct DESC;

-- 4. What gender is most likely to churn?
SELECT
	gender,
    COUNT(
		CASE WHEN churned = 1 
		THEN 1 
		ELSE NULL 
	END
	) AS churned_customers,
    ROUND(
      COUNT(
		CASE WHEN churned = 1 
		THEN 1 
		ELSE NULL 
	  END
	  ) * 100.0 / COUNT(*), 2
    ) AS churn_rate_pct
FROM netflix_customer_churn.customer_information
GROUP BY gender
ORDER BY churn_rate_pct DESC;

-- 5. Are there geographic churn patterns?
SELECT 
	customer_information.region,
    COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
	) AS churned_customers,
	COUNT(*) AS total_customers,
    ROUND(
      COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
		) * 100.0 / COUNT(*), 2
    ) AS churn_rate_pct
FROM netflix_customer_churn.customer_information
GROUP BY region
ORDER BY churn_rate_pct DESC;

-- 6. What % of revenue comes from churned customers?
SELECT
    SUM(monthly_fee) AS total_revenue,
    SUM(CASE WHEN churned = 1 THEN monthly_fee ELSE 0 END) AS churned_revenue,
    SUM(CASE WHEN churned = 0 THEN monthly_fee ELSE 0 END) AS active_cus_revenue,
    ROUND(
        SUM(CASE WHEN churned = 1 THEN monthly_fee ELSE 0 END) 
        * 100.0 / SUM(monthly_fee),
        2
    ) AS churned_revenue_pct
FROM netflix_customer_churn.payments p
JOIN netflix_customer_churn.customer_information c
    ON p.customer_id = c.customer_id;

-- 7. Is there a correlation between average daily streaming hours and churn rate?
SELECT 
    CASE 
        WHEN ci.avg_watch_time_per_day < 1 THEN 'Less than 1 hour'
        WHEN ci.avg_watch_time_per_day BETWEEN 1 AND 2 THEN '1 - 2 hours'
        WHEN ci.avg_watch_time_per_day BETWEEN 2 AND 3 THEN '2 - 3 hours'
        WHEN ci.avg_watch_time_per_day BETWEEN 4 AND 5 THEN '4 - 5 hours'
        ELSE 'Over 5 hours'
    END AS Streaming_hours_per_day,
    COUNT(*) AS total_customers,
    COUNT(
        CASE WHEN ci.churned = 1 THEN 1 END
    ) AS churned_customers,

    ROUND(
        COUNT(CASE WHEN ci.churned = 1 THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_pct,
    SUM(CASE WHEN ci.churned = 1 THEN p.monthly_fee END) AS churned_revenue
FROM netflix_customer_churn.customer_insights AS ci
JOIN netflix_customer_churn.payments AS p
    ON ci.customer_id = p.customer_id
GROUP BY Streaming_hours_per_day
ORDER BY churn_rate_pct;

-- Streaming hours vs churned vs plan type
SELECT 
    s.subscription_type,
    CASE 
        WHEN ci.avg_watch_time_per_day < 1 THEN 'Less than 1 hour'
        WHEN ci.avg_watch_time_per_day BETWEEN 1 AND 2 THEN '1 - 2 hours'
        WHEN ci.avg_watch_time_per_day BETWEEN 2 AND 3 THEN '2 - 3 hours'
        WHEN ci.avg_watch_time_per_day BETWEEN 3 AND 4 THEN '3 - 4 hours'
        WHEN ci.avg_watch_time_per_day BETWEEN 4 AND 5 THEN '4 - 5 hours'
        ELSE 'Over 5 hours'
    END AS streaming_hours_group,

    COUNT(*) AS total_customers,

    COUNT(CASE WHEN ci.churned = 1 THEN 1 END) AS churned_customers,

    ROUND(
        COUNT(CASE WHEN ci.churned = 1 THEN 1 END) * 100.0 
        / COUNT(*),
        2
    ) AS churn_rate_pct,

    SUM(CASE WHEN ci.churned = 1 THEN p.monthly_fee END) AS churned_revenue

FROM netflix_customer_churn.customer_insights ci
JOIN netflix_customer_churn.subscription_types s
    ON ci.customer_id = s.customer_id
JOIN netflix_customer_churn.payments p
    ON ci.customer_id = p.customer_id

GROUP BY streaming_hours_group, s.subscription_type
ORDER BY streaming_hours_group, churn_rate_pct DESC;


-- 8. What favourite movie genres have the highest the churn?
SELECT 
	favorite_genre,
    COUNT(*) AS total_customers,
    COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
	) AS churned_customers,
    ROUND(
      COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
		) * 100.0 / COUNT(*), 2
    ) AS churn_rate_pct
FROM netflix_customer_churn.customer_insights
GROUP BY favorite_genre
ORDER BY churn_rate_pct DESC;

-- 9. Does the streaming device type impact churn?
SELECT 
	device,
    COUNT(*) AS total_customers,
    COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
	) AS churned_customers,
    ROUND(
      COUNT(
		CASE WHEN churned = 1 
			THEN 1 
			ELSE NULL 
		END
		) * 100.0 / COUNT(*), 2
    ) AS churn_rate_pct
FROM netflix_customer_churn.customer_insights
GROUP BY device
ORDER BY churn_rate_pct DESC;