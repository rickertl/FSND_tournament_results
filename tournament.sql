-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- deletes database to start fresh
DROP DATABASE tournament;

-- creates database tournament and connects to it
CREATE DATABASE tournament;
\c tournament;

-- creates table players with two columns
CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name TEXT
);

-- creates table matches with 4 columns
CREATE TABLE matches (
    match SERIAL PRIMARY KEY,
    p1 INTEGER REFERENCES players(id),
    p2 INTEGER REFERENCES players(id),
    win INTEGER
);

-- creates view finding the number of matches each player has played.
CREATE VIEW played AS
SELECT players.id, COUNT(matches.match) AS match_ct
FROM players
LEFT JOIN matches
ON players.id = matches.p1 OR players.id = matches.p2
GROUP BY players.id;

-- creates view finding the number of wins for each player.
CREATE VIEW won AS
SELECT players.id, COUNT(matches.win) AS win_ct
FROM players
LEFT JOIN matches
ON players.id = matches.win
GROUP BY players.id;

-- creates view finding the player standings.
-- Returns a list of the players and their win records, sorted by wins.
-- A list of tuples, each of which contains (id, name, wins, matches):
--   id: the player's unique id (assigned by the database)
--   name: the player's full name (as registered)
--   wins: the number of matches the player has won
--   matches: the number of matches the player has played
CREATE VIEW standings AS
SELECT players.id, players.name, won.win_ct, played.match_ct
FROM players
    LEFT JOIN won
        ON players.id = won.id
    JOIN played
        ON won.id = played.id
ORDER BY won.win_ct DESC;


-- create sample data for validating views
-- INSERT INTO players (name)
-- VALUES ('Mickey'), ('Minny'), ('Pluto'), ('Goofy');
-- INSERT INTO matches (p1, p2, win)
-- VALUES
--     ((SELECT players.id FROM players WHERE players.name = 'Mickey'),
--     (SELECT players.id FROM players WHERE players.name = 'Minny'),
--     (SELECT players.id FROM players WHERE players.name = 'Mickey')),
--     ((SELECT players.id FROM players WHERE players.name = 'Pluto'),
--     (SELECT players.id FROM players WHERE players.name = 'Goofy'),
--     (SELECT players.id FROM players WHERE players.name = 'Goofy')),
--     ((SELECT players.id FROM players WHERE players.name = 'Goofy'),
--     (SELECT players.id FROM players WHERE players.name = 'Mickey'),
--     (SELECT players.id FROM players WHERE players.name = 'Mickey')),
--     ((SELECT players.id FROM players WHERE players.name = 'Minny'),
--     (SELECT players.id FROM players WHERE players.name = 'Pluto'),
--     (SELECT players.id FROM players WHERE players.name = 'Pluto'));
