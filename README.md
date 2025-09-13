# Utililerias para trabajar con SQL

## Estructura de carperas
- main.sql
    - _scripts
    - fn
    - mod
    - req
    - sp 
    - tb 
    - tg
    - vw

## Ejemplo de modelo entidad relación del ejercicio

![DER](tp1_bd_aplicada/mod/DER.png)

> Para poder correrlo hay que grear la base de datod <b>db_utils</b> incluída en el repositorio.
Todo lo que se encuentre dentro de esa base de datos es código para reútilización.

## Dependencias (db_utils)

Creación de esquemas necesarios para las dependencias.

```SQL
/**
   Funcionalidades reutilizables para colaborar con los diseños de otras bases de datos

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

/*
   PRIMERO 
   FN
   /fn/fn_validate_dni.sql
   /fn/fn_validate_email.sql

   SP
   /sp/format/sp_format_tittle.sql
   /sp/random/sp_date_random
*/
```

### Estructura
- main.sql   
    - fn
        - f_validate_dni.sql 
        - fn_validate_email.sql
    - sp
        - format
            - sp_format_tittle.sql
        - random
            - sp_sate_random.sql
            - sp_str_letter_random.sql
            - sp_str_number_random.sql
 


[Documetación Dependencias](utils/README.md)

