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
CREATE TABLE pay_wall (
    id SERIAL PRIMARY KEY,
    price FLOAT NOT NULL,
    amount INT NOT NULL,
    limited_purchase BOOLEAN NOT NULL,
    country VARCHAR NOT NULL,
    exchange_rate INT NOT NULL
);

CREATE TABLE Banner (
    banner_id SERIAL PRIMARY KEY,
    amount_needed INT NOT NULL,
    pity INT NOT NULL,
    banner_info VARCHAR NOT NULL,
    rates FLOAT NOT NULL,
    char_id VARCHAR NOT NULL,
    FOREIGN KEY (char_id) REFERENCES char_info(char_id)
);



