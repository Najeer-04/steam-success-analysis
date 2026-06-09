
SELECT 
    g.genre,
    COUNT(DISTINCT gm.appid)         AS total_games,
    ROUND(AVG(gm.owner_midpoint), 0) AS avg_owners,
    ROUND(AVG(gm.positive_ratio), 3) AS avg_positive_ratio,
    ROUND(AVG(gm.success_score), 2)  AS avg_success_score,
    ROUND(AVG(gm.price), 2)          AS avg_price
FROM game_genres g
JOIN games gm ON g.appid = gm.appid
WHERE gm.total_ratings > 10
AND g.genre NOT IN (
    'Early Access', 'Free to Play', 'Indie',
    'Gore', 'Violent', 'Nudity', 'Sexual Content',
    'Animation & Modeling', 'Design & Illustration',
    'Utilities', 'Audio Production', 'Video Production',
    'Web Publishing', 'Education', 'Software Training'
)
GROUP BY g.genre
HAVING total_games > 50
ORDER BY avg_success_score DESC
