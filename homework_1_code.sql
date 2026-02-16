DROP TABLE games;
CREATE TABLE games AS
SELECT *
FROM read_json_auto("C:\Users\Lesya\Desktop\Databases\games_dataset_small.json",
      maximum_object_size=100000000);
CREATE OR REPLACE TABLE games AS
       SELECT games FROM games;
CREATE OR REPLACE TABLE flattened_games AS
       SELECT UNNEST(games) AS game_info
       FROM games;
CREATE OR REPLACE TABLE structured_games AS
       SELECT
           json_extract(game_info, '$.appid') AS appid,
           json_extract_string(game_info, '$.name_from_applist') AS game_name,
           json_extract_string(game_info, '$.app_details.data.type') AS type,
           json_extract(game_info, '$.app_details.data.is_free') AS is_free,
           json_extract(game_info, '$.app_details.data.developers') AS developers_json,
           json_extract(game_info, '$.app_details.data.platforms') AS platforms_json,
           json_extract(game_info, '$.app_details.data.genres') AS genres_json
       FROM flattened_games;
SELECT * FROM structured_games LIMIT 10;
CREATE OR REPLACE TABLE structured_games AS
       SELECT
           structured_games.appid,
           structured_games.game_name,
           structured_games.type,
           structured_games.is_free,
           structured_games.developers_json,
           CAST(json_extract(platforms_json, '$.mac') AS BOOL) AS mac,
           UNNEST(from_json(structured_games.genres_json, '["JSON"]')) AS genre_json_object
       FROM structured_games;
SELECT * FROM structured_games LIMIT 10;

CREATE OR REPLACE TABLE structured_games AS
       SELECT
           structured_games.appid,
           structured_games.game_name,
           structured_games.type,
           structured_games.is_free,
           structured_games.developers_json,
           structured_games.mac,
           json_extract_string(genre_json_object, '$.description') AS game_description
       FROM structured_games;
SELECT * FROM structured_games LIMIT 10;

WITH mac_usable AS (
    SELECT
        game_description,
        COUNT (*) AS mac_games
    FROM structured_games
    WHERE mac = TRUE
    GROUP BY game_description
)
SELECT
    game_description,
    mac_games,
    RANK () OVER (ORDER BY mac_games DESC) AS rank_by_mac_usability
FROM mac_usable
ORDER BY rank_by_mac_usability;

WITH free_games AS (
    SELECT
        type,
        COUNT (*) AS free_games_count
    FROM structured_games
    WHERE is_free = TRUE
    GROUP BY type
)
SELECT
    type,
    free_games_count,
    RANK () OVER (ORDER BY free_games_count DESC) AS rank_by_free_games_count
FROM free_games
ORDER BY rank_by_free_games_count;