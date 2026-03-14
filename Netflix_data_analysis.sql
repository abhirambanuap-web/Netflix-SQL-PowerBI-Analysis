-- Netflix Project

DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

-- Data set Loading

select * from netflix;


--  Count the Number of Movies vs TV Shows

SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1;

-- Find the Most Common Rating for Movies and TV Shows

WITH RatingCounts AS (
    SELECT
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank_num
    FROM RatingCounts
)

SELECT
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank_num = 1;

-- List All Movies Released in a Specific Year (e.g., 2020)

SELECT * 
FROM netflix
WHERE release_year = 2020;

-- Find the Top 5 Countries with the Most Content on Netflix

SELECT country, COUNT(*) AS total_content
FROM (
    SELECT 
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(country, ',', numbers.n), ',', -1)) AS country
    FROM netflix
    JOIN (
        SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
    ) numbers
    ON CHAR_LENGTH(country) - CHAR_LENGTH(REPLACE(country, ',', '')) >= numbers.n - 1
) AS t
WHERE country <> ''
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;

-- Identify the Longest Movie

SELECT *
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration,' ',1) AS UNSIGNED) DESC
LIMIT 1;

-- Find Content Added in the Last 5 Years

SELECT *
FROM netflix
WHERE STR_TO_DATE(date_added,'%M %d, %Y') >= CURDATE() - INTERVAL 5 YEAR;

-- Find Movies / Shows by Director Rajiv Chilaka

SELECT *
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';

-- TV Shows with More Than 5 Seasons

SELECT *
FROM netflix
WHERE type = 'TV Show'
AND CAST(SUBSTRING_INDEX(duration,' ',1) AS UNSIGNED) > 5;

-- Count Content in Each Genre

SELECT 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', numbers.n), ',', -1)) AS genre,
    COUNT(*) AS total_content
FROM netflix
JOIN (
    SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
) numbers
ON CHAR_LENGTH(listed_in) - CHAR_LENGTH(REPLACE(listed_in, ',', '')) >= numbers.n - 1
GROUP BY genre
ORDER BY total_content DESC;

-- Top 5 Years with Highest Indian Content Release

SELECT 
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        COUNT(show_id) /
        (SELECT COUNT(show_id) FROM netflix WHERE country LIKE '%India%') * 100,
        2
    ) AS avg_release
FROM netflix
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY avg_release DESC
LIMIT 5;

-- Movies that are Documentaries

SELECT *
FROM netflix
WHERE listed_in LIKE '%Documentaries%';

-- Content Without Director

SELECT *
FROM netflix
WHERE director IS NULL OR director = '';

-- Movies with Salman Khan in Last 10 Years

SELECT COUNT(*) AS total_movies
FROM netflix
WHERE casts LIKE '%Salman Khan%'
AND release_year >= YEAR(CURDATE()) - 10
AND type = 'Movie';

-- Top 10 Actors in Indian Movies

SELECT 
TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(casts, ',', numbers.n), ',', -1)) AS actor,
COUNT(*) AS movie_count
FROM netflix
JOIN (
SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
) numbers
ON CHAR_LENGTH(casts) - CHAR_LENGTH(REPLACE(casts, ',', '')) >= numbers.n - 1
WHERE country LIKE '%India%'
GROUP BY actor
ORDER BY movie_count DESC
LIMIT 10;

-- Categorize Content Based on Keywords
 
 SELECT category, COUNT(*) AS content_count
FROM (
SELECT
CASE
WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
ELSE 'Good'
END AS category
FROM netflix
) AS categorized_content
GROUP BY category;