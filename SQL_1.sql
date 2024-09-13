CREATE DATABASE IF NOT EXISTS Sales;
-- here create database is for creating a database. if not exist is for to verify that a database with the same name exists already. and sales is a database name.
-- We can use CREATE SCHEMA IF NOT EXISTS Sales ; aslo for creating a database named sales.
USE Sales;
-- USE Sales; query is to we can select the existing sales database in MySQL.

CREATE TABLE Sales
(
purchase_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
date_of_purchase DATE NOT NULL ,
customer_id INT ,
item_code VARCHAR(10) NOT NULL
);

CREATE TABLE Customer
(
customer_id INT ,
first_name VARCHAR(255),
last_name VARCHAR(255),
email_address VARCHAR(255),
Number_of_Complains INT  
);
 
 SELECT * FROM sales;
 
 SELECT * FROM sales.sales;
 
 DROP TABLE sales;
