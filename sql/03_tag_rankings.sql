
SELECT
    t.tag,
    COUNT(DISTINCT gm.appid)         AS total_games,
    ROUND(AVG(gm.owner_midpoint), 0) AS avg_owners,
    ROUND(AVG(gm.positive_ratio), 3) AS avg_positive_ratio,
    ROUND(AVG(gm.success_score), 2)  AS avg_success_score,
    ROUND(AVG(gm.price), 2)          AS avg_price
FROM game_tags t
JOIN games gm ON t.appid = gm.appid
WHERE gm.total_ratings > 10
GROUP BY t.tag
HAVING total_games > 100
ORDER BY avg_success_score DESC
LIMIT 20
