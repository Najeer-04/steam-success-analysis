
SELECT
    CASE
        WHEN price = 0                THEN '1. Free'
        WHEN price < 5                THEN '2. Under $5'
        WHEN price BETWEEN 5 AND 10   THEN '3. $5 - $10'
        WHEN price BETWEEN 10 AND 20  THEN '4. $10 - $20'
        WHEN price BETWEEN 20 AND 40  THEN '5. $20 - $40'
        ELSE                               '6. Over $40'
    END AS price_tier,
    COUNT(*)                             AS total_games,
    ROUND(AVG(owner_midpoint), 0)        AS avg_owners,
    ROUND(AVG(positive_ratio), 3)        AS avg_positive_ratio,
    ROUND(AVG(success_score), 2)         AS avg_success_score,
    ROUND(AVG(average_playtime), 1)      AS avg_playtime_mins
FROM games
WHERE total_ratings > 10
GROUP BY price_tier
ORDER BY price_tier
