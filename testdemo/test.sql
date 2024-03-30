DROP TABLE IF EXISTS rates;
DROP TABLE IF EXISTS char_info;

CREATE TABLE char_info (
    char_id VARCHAR PRIMARY KEY,
    skill TEXT NOT NULL,
    element VARCHAR NOT NULL,
    rarity_star INT NOT NULL
);

CREATE TABLE rates (
    char_id VARCHAR PRIMARY KEY,
    color VARCHAR NOT NULL,
    rates REAL NOT NULL,
    FOREIGN KEY (char_id) REFERENCES char_info(char_id)
);



