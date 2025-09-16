
USE db_tp_bd_aplicada


IF NOT EXISTS 
(
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA    = 'negocio'   AND
            TABLE_NAME      = 'Localidad'
)
BEGIN
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Localidad]
    (
        IDLocalidad INT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(30) NOT NULL
    );
END PRINT('*** La tabla [Localidad] ya existe en la base de datos')

-- TRUNCATE TABLE [db_tp_bd_aplicada].[negocio].[Localidad]
-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Localidad]
