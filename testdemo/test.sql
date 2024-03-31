DROP TABLE IF EXISTS rates CASCADE ;
DROP TABLE IF EXISTS char_info CASCADE ;
DROP TABLE IF EXISTS banner CASCADE ;
DROP TABLE IF EXISTS pay_wall CASCADE ;
DROP TABLE IF EXISTS character_pool CASCADE ;

CREATE TABLE char_info (
    char_id VARCHAR PRIMARY KEY,
    skill TEXT,
    element VARCHAR,
    rarity_star INT
);

CREATE TABLE banner (
    banner_id INT PRIMARY KEY,
    pity INT,
    banner_info VARCHAR,
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
    method INT, --  (1 for paypal)(2 credit/debit etc) method keeping it as int to simplify will added a databse for payment if have time
    country VARCHAR NOT NULL,
    exchange_rate INT NOT NULL
);


