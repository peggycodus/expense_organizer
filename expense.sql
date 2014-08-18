CREATE DATABASE expense_test;
CREATE TABLE expenses (id serial PRIMARY KEY, amount float, description varchar, company_id int, date date);
CREATE TABLE categories (id serial PRIMARY KEY, name varchar, budget float);
CREATE TABLE companies (id serial PRIMARY KEY, name varchar);
CREATE TABLE category_expense (id serial PRIMARY KEY, category_id int, expense_id int);
