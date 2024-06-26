DROP TABLE IF EXISTS rates CASCADE ;
DROP TABLE IF EXISTS char_info CASCADE ;
DROP TABLE IF EXISTS current_banner CASCADE ;
DROP TABLE IF EXISTS pay_wall CASCADE ;
DROP TABLE IF EXISTS character_pool CASCADE ;
DROP TABLE IF EXISTS player_info CASCADE ;
DROP TABLE IF EXISTS users CASCADE ;
DROP TABLE IF EXISTS player_characters CASCADE ;
DROP TABLE IF EXISTS pvp_leaderboard CASCADE ;
DROP TABLE IF EXISTS pve_leaderboard CASCADE ;
DROP TABLE IF EXISTS pvp_matches CASCADE ;
DROP TABLE IF EXISTS achievements CASCADE ;
DROP TABLE IF EXISTS player_achievements CASCADE ;
DROP TABLE IF EXISTS users CASCADE;



CREATE TABLE char_info (
    char_id VARCHAR(50) PRIMARY KEY,
    name TEXT,
    skill TEXT,
    element VARCHAR,
    rarity_star INT
);

CREATE TABLE current_banner (
    banner_id INT PRIMARY KEY,
    banner_info VARCHAR,
    pity INT,
    duration tsrange,
    rates FLOAT,
    char_id VARCHAR,
    FOREIGN KEY (char_id) REFERENCES char_info(char_id)
);
CREATE TABLE rates (
    banner_id INT,
    color VARCHAR,
    star INT,
    rates REAL PRIMARY KEY,
    FOREIGN KEY (banner_id) REFERENCES current_banner(banner_id)
);
CREATE TABLE character_pool (
    char_id VARCHAR,
    color VARCHAR,
    rates REAL,
    FOREIGN KEY (char_id) REFERENCES char_info(char_id),
    FOREIGN KEY (rates) REFERENCES rates(rates)
);
CREATE TABLE pay_wall (
    id SERIAL PRIMARY KEY,
    price FLOAT NOT NULL,
    amount INT NOT NULL,
    limited_purchase BOOLEAN NOT NULL,
    method INT, --  (1 for paypal)(2 credit/debit etc) method keeping it as int to simplify will added a database for payment if have time
    country VARCHAR NOT NULL,
    exchange_rate INT NOT NULL
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    account_creation_date TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC')
);

CREATE TABLE player_info(
    user_id INT PRIMARY KEY,
    char_obtained INT NOT NULL,
    level INT NOT NULL,
    pvp_win_rate FLOAT NOT NULL,
    pvp_match_count INT,
    achievement_count  INT,
    current_stage VARCHAR,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE player_characters (
    user_id INT,
    char_id VARCHAR,
    obtained_at TIMESTAMP WITHOUT TIME ZONE,
    character_level INT DEFAULT 1,
    PRIMARY KEY (user_id, char_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (char_id) REFERENCES char_info(char_id)
);


CREATE TABLE pvp_leaderboard (
    user_id INT,
    win_count INT DEFAULT 0,
    lose_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE OR REPLACE FUNCTION func_update_leaderboard()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.result = 'win' THEN
        UPDATE pvp_leaderboard
        SET win_count = win_count + 1
        WHERE user_id = NEW.player_id;
    ELSIF NEW.result = 'lose' THEN
        UPDATE pvp_leaderboard
        SET lose_count = lose_count + 1
        WHERE user_id = NEW.player_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;




CREATE TABLE pvp_matches (
    match_id SERIAL PRIMARY KEY,
    player_id INT,
    opponent_id INT,
    result VARCHAR(50),
    match_timestamp TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    FOREIGN KEY (player_id) REFERENCES users(user_id),
    FOREIGN KEY (opponent_id) REFERENCES users(user_id)

);
CREATE TRIGGER trg_update_leaderboard
AFTER INSERT ON pvp_matches
FOR EACH ROW
EXECUTE FUNCTION func_update_leaderboard();


CREATE OR REPLACE FUNCTION func_sync_player_info()
RETURNS TRIGGER AS $$
DECLARE
    v_total_matches INT;
    v_win_rate FLOAT;
BEGIN
    SELECT win_count + lose_count,
           CASE WHEN win_count + lose_count > 0 THEN win_count::FLOAT / (win_count + lose_count) * 100 ELSE 0 END
    INTO v_total_matches, v_win_rate
    FROM pvp_leaderboard
    WHERE user_id = NEW.user_id;

    UPDATE player_info
    SET pvp_match_count = v_total_matches, pvp_win_rate = v_win_rate
    WHERE user_id = NEW.user_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_sync_player_info
AFTER UPDATE ON pvp_leaderboard
FOR EACH ROW
EXECUTE FUNCTION func_sync_player_info();



CREATE TABLE pve_leaderboard (
    user_id INT,
    current_stage VARCHAR,
    stages_completed INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);



CREATE TABLE achievements (
    achievement_id SERIAL PRIMARY KEY,
    achievement_name VARCHAR(255) NOT NULL,
    description TEXT,
    task VARCHAR(255) NOT NULL
);

CREATE TABLE player_achievements (
    user_id INT,
    achievement_id INT,
    earned_on TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    PRIMARY KEY (user_id, achievement_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (achievement_id) REFERENCES achievements(achievement_id)
);

CREATE OR REPLACE FUNCTION update_achievement_count()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE player_info
    SET achievement_count = (
        SELECT COUNT(*)
        FROM player_achievements
        WHERE user_id = NEW.user_id
    )
    WHERE user_id = NEW.user_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_achievement_count
AFTER INSERT ON player_achievements
FOR EACH ROW
EXECUTE FUNCTION update_achievement_count();


CREATE INDEX idx_banner_char_id ON current_banner(char_id);

CREATE INDEX idx_character_pool_char_id ON character_pool(char_id);
CREATE INDEX idx_character_pool_rates ON character_pool(rates);

CREATE INDEX idx_rates_banner_id ON rates(banner_id);

CREATE INDEX idx_player_characters_user_id ON player_characters(user_id);
CREATE INDEX idx_player_characters_char_id ON player_characters(char_id);

CREATE INDEX idx_pvp_leaderboard_user_id ON pvp_leaderboard(user_id);

CREATE INDEX idx_pvp_matches_player_id ON pvp_matches(player_id);
CREATE INDEX idx_pvp_matches_opponent_id ON pvp_matches(opponent_id);

CREATE INDEX idx_player_achievements_user_id ON player_achievements(user_id);
CREATE INDEX idx_player_achievements_achievement_id ON player_achievements(achievement_id);

CREATE INDEX idx_pve_leaderboard_user_id ON pve_leaderboard(user_id);

CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);

CREATE INDEX idx_char_info_element ON char_info(element);
CREATE INDEX idx_char_info_rarity_star ON char_info(rarity_star);

CREATE INDEX idx_player_info_win_rate ON player_info(pvp_win_rate);
CREATE INDEX idx_player_info_level ON player_info(level);
CREATE INDEX idx_player_info_current_stage ON player_info(current_stage);

DROP VIEW IF EXISTS player_achievements_overview;
DROP VIEW IF EXISTS player_pvp_stats;
DROP VIEW IF EXISTS player_pve_progress;
DROP VIEW IF EXISTS gacha_banner_view;

CREATE VIEW player_achievements_overview AS
SELECT
    pa.user_id,
    u.username,
    COUNT(pa.achievement_id) AS total_achievements,
    MAX(a.achievement_name) AS latest_achievement
FROM
    player_achievements pa
JOIN
    users u ON pa.user_id = u.user_id
JOIN
    achievements a ON pa.achievement_id = a.achievement_id
GROUP BY
    pa.user_id, u.username;

CREATE VIEW player_pvp_stats AS
SELECT
    p.user_id,
    u.username,
    p.pvp_win_rate,
    p.pvp_match_count,
    pvpl.win_count,
    pvpl.lose_count
FROM
    player_info p
JOIN
    users u ON p.user_id = u.user_id
LEFT JOIN
    pvp_leaderboard pvpl ON p.user_id = pvpl.user_id;

CREATE VIEW player_pve_progress AS
SELECT
    p.user_id,
    u.username,
    p.current_stage
FROM
    player_info p
JOIN
    users u ON p.user_id = u.user_id;

CREATE VIEW gacha_banner_view AS
SELECT
    b.banner_id,
    b.banner_info,
    b.duration,
    b.rates AS banner_rates,
    c.char_id,
    c.name AS character_name,
    c.skill,
    c.element,
    c.rarity_star
FROM
    current_banner b
JOIN
    char_info c ON b.char_id = c.char_id
LEFT JOIN
    rates r ON b.banner_id = r.banner_id;
