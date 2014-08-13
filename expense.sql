CREATE DATABASE expense_test;
CREATE TABLE expense (id serial PRIMARY KEY, amount float, description varchar, company_id int, date timestamp);
CREATE TABLE category (id serial PRIMARY KEY, name varchar, budget float);
CREATE TABLE company (id serial PRIMARY KEY, name varchar);
