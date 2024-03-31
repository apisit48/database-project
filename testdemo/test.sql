DROP TABLE IF EXISTS rates CASCADE ;
DROP TABLE IF EXISTS char_info CASCADE ;
DROP TABLE IF EXISTS banner CASCADE ;
DROP TABLE IF EXISTS pay_wall CASCADE ;
DROP TABLE IF EXISTS character_pool CASCADE ;
DROP TABLE IF EXISTS player_info CASCADE ;
DROP TABLE IF EXISTS player_characters CASCADE ;
DROP TABLE IF EXISTS pvp_leaderboard CASCADE ;
DROP TABLE IF EXISTS pve_leaderboard CASCADE ;
DROP TABLE IF EXISTS pvp_matches CASCADE ;
DROP TABLE IF EXISTS achievements CASCADE ;
DROP TABLE IF EXISTS player_achievements CASCADE ;
DROP TABLE IF EXISTS users CASCADE;



CREATE TABLE char_info (
    char_id VARCHAR(50) PRIMARY KEY,
    skill TEXT,
    element VARCHAR,
    rarity_star INT
);

CREATE TABLE banner (
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
    FOREIGN KEY (banner_id) REFERENCES banner(banner_id)
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

CREATE TABLE pvp_matches (
    match_id SERIAL PRIMARY KEY,
    player_id INT,
    opponent_id INT,
    result VARCHAR(50),
    match_timestamp TIMESTAMP WITHOUT TIME ZONE DEFAULT (NOW() AT TIME ZONE 'UTC'),
    FOREIGN KEY (player_id) REFERENCES users(user_id),
    FOREIGN KEY (opponent_id) REFERENCES users(user_id)

);

CREATE OR REPLACE FUNCTION update_pvp_match_count()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE player_info
    SET pvp_match_count = pvp_match_count + 1
    WHERE user_id = NEW.player_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_pvp_match_count
AFTER INSERT ON pvp_matches
FOR EACH ROW
EXECUTE FUNCTION update_pvp_match_count();


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

CREATE OR REPLACE FUNCTION calculate_win_rate(p_user_id INT)
RETURNS FLOAT AS $$
DECLARE
    v_win_count INT;
    v_loss_count INT;
    v_total_matches INT;
    v_win_rate FLOAT;
BEGIN
    SELECT win_count, lose_count INTO v_win_count, v_loss_count
    FROM pvp_leaderboard
    WHERE user_id = p_user_id;

    v_total_matches := v_win_count + v_loss_count;

    IF v_total_matches > 0 THEN
        v_win_rate := (v_win_count::FLOAT / v_total_matches) * 100;
    ELSE
        v_win_rate := 0;
    END IF;

    RETURN v_win_rate;
END;
$$ LANGUAGE plpgsql;

CREATE INDEX idx_banner_char_id ON banner(char_id);

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

INSERT INTO char_info (char_id, skill, element, rarity_star)   VALUES
(111,'blah blah','fire',1),
(112, 'Harnessing the flames of chaos', 'fire', 2),
(113, 'Master of aquatic illusions', 'water', 1),
(114, 'Earthshaker with seismic might', 'earth', 5),
(115, 'Crackling with thunderous power', 'thunder', 1),
(116, 'Dark sorcerer of the shadows', 'dark', 3),
(117, 'Blessed with celestial light', 'light', 5),
(118, 'Pyromancer commanding infernos', 'fire', 2),
(119, 'Mystic guardian of the deep', 'water', 3),
(120, 'Geomancer sculpting landscapes', 'earth', 4),
(121, 'Electrifying storms' , 'thunder', 2),
(122, 'Shadowcaster cloaked in darkness', 'dark', 1),
(123, 'Radiant beacon of hope', 'light', 1),
(124, 'Igniting sparks with fiery finesse', 'fire', 2),
(125, 'Aquatic sage of serene waters', 'water', 3),
(126, 'Earthen guardian of ancient lands', 'earth', 4),
(127, 'Thundercaller wielding lightning', 'thunder', 2),
(128, 'Channeler of forbidden shadows', 'dark', 5),
(129, 'Bearer of luminous purity', 'light', 4),
(130, 'Blazing infernos at their command', 'fire', 2),
(131, 'Mystical guardian of the sea', 'water', 1),
(132, 'Shaping earth with elemental force', 'earth', 4),
(133, 'Crashing thunderbolts from above', 'thunder', 2),
(134, 'Conjurer of dark mysteries', 'dark', 3),
(135, 'Radiating with divine light', 'light', 5),
(136, 'Incinerating enemies with flames', 'fire', 2),
(137, 'Whispering secrets of the tides', 'water', 5);

INSERT INTO banner (banner_id, banner_info, pity, duration, rates, char_id)
VALUES (1,'Summer Banner',300,'[2024-06-21 00:00, 2024-09-22 12:59)',0.4,'122'),
(0,'Regular Banner',300,null,0.4,'131');