USE MovieRecommenderDB;
GO


-- ============================================================
-- 1. User-Level Features
-- ============================================================
-- Aggregate user rating behavior for personalization
-- and future hybrid/advanced recommendation models.

SELECT
    user_id,
    COUNT(*) AS rating_count,
    ROUND(AVG(CAST(rating AS FLOAT)), 2) AS average_rating
FROM dbo.Ratings
GROUP BY user_id;
GO


-- ============================================================
-- 2. Movie-Level Features
-- ============================================================
-- Aggregate movie popularity and rating statistics.

SELECT
    m.movie_id,
    m.title,
    COUNT(r.user_id) AS rating_count,
    ROUND(AVG(CAST(r.rating AS FLOAT)), 2) AS average_rating
FROM dbo.Movies AS m
INNER JOIN dbo.Ratings AS r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title;
GO


-- ============================================================
-- 3. Movie Content Features
-- ============================================================
-- Combine movie genres into a single feature representation
-- for Content-Based Filtering.

SELECT
    m.movie_id,
    m.title,
    STRING_AGG(g.genre_name, '|') AS genres
FROM dbo.Movies AS m
INNER JOIN dbo.MovieGenres AS mg
    ON m.movie_id = mg.movie_id
INNER JOIN dbo.Genres AS g
    ON mg.genre_id = g.genre_id
GROUP BY
    m.movie_id,
    m.title;
GO


-- ============================================================
-- 4. Collaborative Filtering Dataset
-- ============================================================
-- User-Movie interactions used to train the
-- Collaborative Filtering model.

SELECT
    user_id,
    movie_id,
    rating
FROM dbo.Ratings;
GO