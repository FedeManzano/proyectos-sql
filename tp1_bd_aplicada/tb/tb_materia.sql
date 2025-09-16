
USE db_tp_bd_aplicada

IF NOT EXISTS 
(
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA    = 'negocio' AND
            TABLE_NAME      = 'Materia'
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Materia]
    (
        CodMAteria CHAR(4) PRIMARY KEY,
        Nombre VARCHAR(40) NOT NULL
    )
END PRINT('*** La tabla [Materia] ya existe en la base de datos')

-- TRUNCATE TABLE [db_tp_bd_aplicada].[negocio].[Materia]
-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Materia]