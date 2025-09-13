
USE db_tp_bd_aplicada

IF NOT EXISTS 
(
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Materia]'
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Materia]
    (
        CodMAteria CHAR(4) PRIMARY KEY,
        Nombre VARCHAR(40) NOT NULL
    )
END

-- TRUNCATE TABLE [db_tp_bd_aplicada].[negocio].[Materia]
-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Materia]