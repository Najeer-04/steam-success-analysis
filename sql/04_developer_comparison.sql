
WITH developer_stats AS (
    SELECT
        developer,
        COUNT(*)                             AS total_games,
        ROUND(AVG(owner_midpoint), 0)        AS avg_owners,
        ROUND(AVG(positive_ratio), 3)        AS avg_positive_ratio,
        ROUND(AVG(success_score), 2)         AS avg_success_score,
        ROUND(AVG(price), 2)                 AS avg_price,
        SUM(owner_midpoint)                  AS total_owners
    FROM games
    WHERE total_ratings > 10
    GROUP BY developer
    HAVING total_games >= 1
),
developer_tier AS (
    SELECT *,
        CASE
            WHEN total_games = 1      THEN '1. Single Title'
            WHEN total_games BETWEEN 2 AND 5   THEN '2. Small Studio (2-5)'
            WHEN total_games BETWEEN 6 AND 20  THEN '3. Mid Studio (6-20)'
            ELSE                               '4. Large Studio (20+)'
        END AS studio_tier
    FROM developer_stats
)
SELECT
    studio_tier,
    COUNT(*)                             AS total_developers,
    ROUND(AVG(total_games), 1)           AS avg_games_made,
    ROUND(AVG(avg_owners), 0)            AS avg_owners,
    ROUND(AVG(avg_positive_ratio), 3)    AS avg_positive_ratio,
    ROUND(AVG(avg_success_score), 2)     AS avg_success_score,
    ROUND(AVG(avg_price), 2)             AS avg_price
FROM developer_tier
GROUP BY studio_tier
ORDER BY studio_tier
