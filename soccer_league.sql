DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    yr INTEGER NOT NULL
);

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    team_id INTEGER REFERENCES teams ON DELETE SET NULL
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    winning_team_id INTEGER REFERENCES teams ON DELETE SET NULL,
    losing_team_id INTEGER REFERENCES teams ON DELETE SET NULL,
    referee_id INTEGER REFERENCES referees ON DELETE SET NULL,
    season_id INTEGER REFERENCES seasons ON DELETE CASCADE
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES players ON DELETE SET NULL,
    team_id INTEGER REFERENCES teams ON DELETE CASCADE,
    match_id INTEGER REFERENCES matches ON DELETE CASCADE
);

-- For the last excersize "The standings/rankings of each team in the league 
-- (This doesn’t have to be its own table if the data can be captured somehow)", 
-- I think this could be achieved using the follwing query

SELECT seasons.yr, 
        teams.name,
        SUM(CASE WHEN teams.id=winning_team_id THEN 1 ELSE 0 END) wins,
        SUM(CASE WHEN teams.id=losing_team_id THEN 1 ELSE 0 END) losses
    FROM matches JOIN goals ON matches.id = goals.match_id
    JOIN seasons ON seasons.id = matches.season_id
    JOIN teams ON (teams.id = winning_team_id)
    GROUP BY seasons.yr, teams.name
    ORDER BY seasons.yr, wins DESC, losses, teams.name;