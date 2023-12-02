DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    prefered_region_id INTEGER REFERENCES regions ON DELETE SET NULL
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users ON DELETE CASCADE,
    title TEXT NOT NULL,
    content TEXT,
    region_id INTEGER REFERENCES regions ON DELETE SET NULL,
    category_id INTEGER REFERENCES category ON DELETE SET NULL
);