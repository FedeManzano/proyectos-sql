/**
   Funcionalidades reutilizables para colaborar con los diseños de otras bases de datos

*/
/*
   1 - CREAR LA BASE DE DATOS Y LOS ESQUEMAS
   
   2 - FN
   /fn/fn_validate_dni.sql
   /fn/fn_validate_email.sql

   3 - SP
   /sp/format/sp_format_tittle.sql
   /sp/random/sp_date_random
   /sp/random/sp_letter_random
   /sp/random/sp_number_random
   /sp/random/sp_validate_test
*/


----------- PRIMERO
USE master 

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'db_utils')
BEGIN
    CREATE DATABASE db_utils
    COLLATE SQL_Latin1_General_CP1_CI_AS
END 
---------------------------------------------------------------------------
-------------- SEGUNDO
USE db_utils

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'library')
BEGIN
   EXEC('CREATE SCHEMA library') -- Esquema donde están todos los elementos
END 

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'test')
BEGIN
   EXEC('CREATE SCHEMA test') -- Test unitarios de los elementos
END 
---------------------------------------------------------------------

