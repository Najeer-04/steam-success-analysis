
WITH ranked_games AS (
    SELECT
        gm.name,
        gm.owner_midpoint,
        gm.positive_ratio,
        gm.success_score,
        gm.price,
        g.genre,
        RANK() OVER (
            PARTITION BY g.genre
            ORDER BY gm.success_score DESC
        ) AS genre_rank
    FROM games gm
    JOIN game_genres g ON gm.appid = g.appid
    WHERE gm.total_ratings > 50
    AND g.genre NOT IN (
        'Early Access', 'Free to Play', 'Indie',
        'Gore', 'Violent', 'Nudity', 'Sexual Content',
        'Animation & Modeling', 'Design & Illustration',
        'Utilities', 'Audio Production', 'Video Production',
        'Web Publishing', 'Education', 'Software Training'
    )
)
SELECT *
FROM ranked_games
WHERE genre_rank <= 3
ORDER BY genre, genre_rank
