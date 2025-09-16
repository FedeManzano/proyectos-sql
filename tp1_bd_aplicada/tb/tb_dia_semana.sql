
USE db_tp_bd_aplicada

IF NOT EXISTS 
(
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA    = 'negocio' AND
            TABLE_NAME      = 'Dia_Semana' 
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Dia_Semana]
    (
        CodDia TINYINT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(15) NOT NULL 
    )
END
ELSE PRINT('*** La tabla Dia_Semana ya existe en la base de datos')

-- TRUNCATE TABLE [db_tp_bd_aplicada].[negocio].[Dia_Semana]
-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Dia_Semana]
