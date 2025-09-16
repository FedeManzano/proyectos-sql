/***
    1 - PRIORIDAD
    Abrir el proyecto (db_utils 'DEPENDENCIAS') y crear la base de datos con todos 
    los elementos como se describe en la documentación

    2 - BASE DE DATOS (Código de abajo en este archivo)
    ESQUEMAS (Código de abajo en este archivo)

    3 - PROCEDIMINETOS
    /sp/random/sp_crear_dni_aleatorio.sql (Crear dni aleatorios)
    /sp/insercion/sp_insertar_comision.sql
    /sp/insercion/sp_inscribirse_materia.sql

    4 - FUNCIONES
    /fn/fn_selector_turnos.sql

    5 - SCRIPTS (Sólo para probar)
    *** Sólo para pruebas No para producción ***
    /_scripts/_crear_tablas.sql (Está todo el lote de prueba)

    6(OPCIONAL) - TABLAS (Para generar BD Vacía)
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