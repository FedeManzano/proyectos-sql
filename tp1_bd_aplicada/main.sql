/***
    BASE DE DATOS (Código de abajo en este archivo)
    ESQUEMAS (Código de abajo en este archivo)

    PROCEDIMINETOS
    sp\random\sp_crear_dni_aleatorio.sql (Crear dni aleatorios)

    SCRIPTS
    _scripts/_crear_tablas.sql (Está todo ell lote de prueba)

    TABLAS
    /tb/tb_tipo_doc.sql
    /tb/tb_localidad.sql
    /tb/tb_persona.sql
*/
-------------PRIMERO
USE MASTER

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'db_tp_bd_aplicada')
BEGIN 
    CREATE DATABASE db_tp_bd_aplicada
    COLLATE sql_latin1_general_cp1_ci_as
END
------------------------------------------------------------------

------------SEGUNDO
USE db_tp_bd_aplicada

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'negocio')
BEGIN 
    EXEC('CREATE SCHEMA negocio')
END

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'test')
BEGIN 
    EXEC('CREATE SCHEMA test')
END

---------------------------------------------------------------------------------
