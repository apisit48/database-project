DROP TABLE IF EXISTS rates;
DROP TABLE IF EXISTS char_info;

CREATE TABLE rates (
    char_id VARCHAR PRIMARY KEY ,
    rarity_star INT NOT NULL ,
    color VARCHAR NOT NULL ,
    rates REAL NOT NULL
);
CREATE TABLE char_info(
    char_id VARCHAR PRIMARY KEY ,
    skill TEXT NOT NULL ,
    element  VARCHAR NOT NULL ,
    rarity_star INT NOT NULL
);


