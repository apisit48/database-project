INSERT INTO char_info (char_id, name, skill, element, rarity_star) VALUES
(111, 'Aldric the Blazing', 'blah blah', 'fire', 1),
(112, 'Seraphina Flameheart', 'Harnessing the flames of chaos', 'fire', 2),
(113, 'Marina Mistweaver', 'Master of aquatic illusions', 'water', 1),
(114, 'Garron Stonecrusher', 'Earthshaker with seismic might', 'earth', 5),
(115, 'Thorin Thundercrack', 'Crackling with thunderous power', 'thunder', 1),
(116, 'Lilith Shadowcaster', 'Dark sorcerer of the shadows', 'dark', 3),
(117, 'Aurora Dawnbringer', 'Blessed with celestial light', 'light', 5),
(118, 'Ignatius Pyromancer', 'Pyromancer commanding infernos', 'fire', 2),
(119, 'Nerida Tidecaller', 'Mystic guardian of the deep', 'water', 3),
(120, 'Terrance Earthwarden', 'Geomancer sculpting landscapes', 'earth', 4),
(121, 'Raiden Stormcaller', 'Electrifying storms', 'thunder', 2),
(122, 'Sylvia Shadowcaster', 'Shadowcaster cloaked in darkness', 'dark', 1),
(123, 'Aria Lightbringer', 'Radiant beacon of hope', 'light', 1),
(124, 'Pyralis Firebrand', 'Igniting sparks with fiery finesse', 'fire', 2),
(125, 'Marinus Aquasage', 'Aquatic sage of serene waters', 'water', 3),
(126, 'Gronn Earthguard', 'Earthen guardian of ancient lands', 'earth', 4),
(127, 'Voltan Thundercaller', 'Thundercaller wielding lightning', 'thunder', 2),
(128, 'Malakai Shadowbinder', 'Channeler of forbidden shadows', 'dark', 5),
(129, 'Elysia Lightbearer', 'Bearer of luminous purity', 'light', 4),
(130, 'Inferno Blazebringer', 'Blazing infernos at their command', 'fire', 2),
(131, 'Maris Mystical', 'Mystical guardian of the sea', 'water', 1),
(132, 'Terra Earthshaper', 'Shaping earth with elemental force', 'earth', 4),
(133, 'Thalia Thunderstrike', 'Crashing thunderbolts from above', 'thunder', 2),
(134, 'Vladimir Shadowweaver', 'Conjurer of dark mysteries', 'dark', 3),
(135, 'Lumina Radiant', 'Radiating with divine light', 'light', 5),
(136, 'Blaze Incinerator', 'Incinerating enemies with flames', 'fire', 2),
(137, 'Talia Tidecaller', 'Whispering secrets of the tides', 'water', 5);


INSERT INTO current_banner (banner_id, banner_info, pity, duration, rates, char_id)
VALUES
(2,'Summer Banner',300,'[2024-06-27 00:00, 2024-09-4 12:59)',0.4,'122'),
(1,'Summer Banner',300,'[2024-06-21 00:00, 2024-09-22 12:59)',0.4,'122'),
(0,'Regular Banner',300,null,0.4,'131');


INSERT INTO users (username, password_hash, email) VALUES ('BlueRanger', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'nimrjeq@test.org');
INSERT INTO users (username, password_hash, email) VALUES ('RedPanda', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'avcgtdg@mail.com');
INSERT INTO users (username, password_hash, email) VALUES ('MightyEagle', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'drghwhl@example.com');
INSERT INTO users (username, password_hash, email) VALUES ('SilentWolf', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'kslyzvx@test.org');
INSERT INTO users (username, password_hash, email) VALUES ('CunningFox', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'qxvqmgl@example.com');
INSERT INTO users (username, password_hash, email) VALUES ('SwiftHare', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'iekkfiq@mail.com');
INSERT INTO users (username, password_hash, email) VALUES ('NobleStag', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'zpatqzg@example.com');
INSERT INTO users (username, password_hash, email) VALUES ('WiseOwl', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'kyruyzv@test.org');
INSERT INTO users (username, password_hash, email) VALUES ('FierceTiger', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'mlcusfs@test.org');
INSERT INTO users (username, password_hash, email) VALUES ('CalmWhale', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'wmrvvxj@mail.com');
INSERT INTO users (username, password_hash, email) VALUES ('SneakyRat', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'ngqgspr@test.org');
INSERT INTO users (username, password_hash, email) VALUES ('BraveLion', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'omkmjvk@test.org');
INSERT INTO users (username, password_hash, email) VALUES ('WanderingBear', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'xomkzva@mail.com');
INSERT INTO users (username, password_hash, email) VALUES ('GentleDoe', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'jpcnvgo@example.com');
INSERT INTO users (username, password_hash, email) VALUES ('QuickSquirrel', '008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601', 'ewfvjla@test.org');

INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (1, 7, 28, 68.32, 86, 23, 'Stage_1');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (2, 3, 70, 55.21, 439, 30, 'Stage_13');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (3, 6, 100, 90.08, 157, 11, 'Stage_13');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (4, 2, 65, 72.12, 258, 10, 'Stage_10');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (5, 3, 52, 85.34, 398, 28, 'Stage_3');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (6, 3, 47, 92.68, 472, 36, 'Stage_8');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (7, 8, 63, 64.8, 241, 46, 'Stage_15');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (8, 3, 43, 34.9, 197, 31, 'Stage_20');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (9, 6, 79, 12.7, 288, 19, 'Stage_17');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (10, 8, 85, 75.23, 396, 28, 'Stage_13');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (11, 7, 83, 60.27, 149, 28, 'Stage_15');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (12, 4, 24, 24.56, 92, 46, 'Stage_20');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (13, 5, 39, 13.43, 429, 10, 'Stage_14');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (14, 6, 48, 76.34, 40, 9, 'Stage_10');
INSERT INTO player_info (user_id, char_obtained, level, pvp_win_rate, pvp_match_count, achievement_count, current_stage) VALUES (15, 10, 18, 75.87, 225, 21, 'Stage_14');

INSERT INTO achievements (achievement_name, description, task) VALUES
('First Win', 'Win your first PvP match', 'Win 1 PvP match'),
('Explorer', 'Complete all stages in the first zone', 'Complete stage 10'),
('Strategist', 'Win a match with each element', 'Win with fire, water, and earth'),
('Collector', 'Obtain 10 characters', 'Obtain 10 different characters'),
('Veteran', 'Win 100 PvP matches', 'Win 100 PvP matches');

INSERT INTO pvp_leaderboard (user_id, win_count, lose_count) VALUES
(1, 10, 5),
(2, 8, 7),
(3, 15, 2),
(4, 7, 8),
(5, 12, 3),
(6, 9, 6),
(7, 5, 10),
(8, 11, 4),
(9, 4, 11),
(10, 13, 1),
(11, 6, 9),
(12, 14, 0),
(13, 3, 12),
(14, 2, 13),
(15, 0, 15);


INSERT INTO pve_leaderboard (user_id, current_stage, stages_completed) VALUES
(1, 'Stage_3', 11),
(2, 'Stage_18', 16),
(3, 'Stage_17', 4),
(4, 'Stage_19', 1),
(5, 'Stage_10', 3),
(6, 'Stage_4', 10),
(7, 'Stage_20', 4),
(8, 'Stage_11', 13),
(9, 'Stage_3', 11),
(10, 'Stage_1', 10),
(11, 'Stage_8', 19),
(12, 'Stage_17', 1),
(13, 'Stage_9', 16),
(14, 'Stage_12', 18),
(15, 'Stage_17', 17);

INSERT INTO pvp_matches (player_id, opponent_id, result, match_timestamp) VALUES
(1, 2, 'win', '2023-01-01 00:00:00'),
(2, 1, 'lose', '2023-01-01 00:00:00'),
(3, 4, 'win', '2023-01-02 00:00:00'),
(4, 3, 'lose', '2023-01-02 00:00:00'),
(5, 6, 'win', '2023-01-03 00:00:00'),
(6, 5, 'lose', '2023-01-03 00:00:00'),
(7, 8, 'win', '2023-01-04 00:00:00'),
(8, 7, 'lose', '2023-01-04 00:00:00'),
(9, 10, 'win', '2023-01-05 00:00:00'),
(10, 9, 'lose', '2023-01-05 00:00:00'),
(11, 12, 'win', '2023-01-06 00:00:00'),
(12, 11, 'lose', '2023-01-06 00:00:00'),
(13, 14, 'win', '2023-01-07 00:00:00'),
(14, 13, 'lose', '2023-01-07 00:00:00'),
(15, 1, 'win', '2023-01-08 00:00:00'),
(1, 15, 'lose', '2023-01-08 00:00:00');

INSERT INTO player_achievements (user_id, achievement_id, earned_on) VALUES
(1, 1, '2023-01-02'),
(1, 2, '2023-02-05'),
(2, 1, '2023-01-10'),
(3, 3, '2023-03-15'),
(4, 4, '2023-04-20'),
(5, 5, '2023-05-25'),
(6, 2, '2023-06-30'),
(7, 3, '2023-07-04'),
(8, 1, '2023-08-09'),
(9, 5, '2023-09-12'),
(10, 4, '2023-10-17'),
(11, 1, '2023-11-22'),
(12, 2, '2023-12-27'),
(13, 3, '2024-01-01'),
(14, 4, '2024-02-05'),
(15, 5, '2024-03-10');
