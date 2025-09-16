
USE db_tp_bd_aplicada

IF NOT EXISTS 
(
        SELECT 1 
        FROM INFORMATION_SCHEMA.TABLES 
        WHERE   TABLE_SCHEMA    = 'negocio' AND
                TABLE_NAME      = 'Alumno' 
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Alumno]
    (
        TipoDoc TINYINT NOT NULL,
        NroDoc VARCHAR(8) NOT NULL,
        FechaIng DATE NOT NULL,
        CONSTRAINT PK_Alumno PRIMARY KEY(TipoDoc, NroDoc),
        CONSTRAINT FK_Persona FOREIGN KEY(TipoDoc, NroDoc) 
        REFERENCES [db_tp_bd_aplicada].[negocio].[Persona](IDTipo, NroDoc)
    )
END
ELSE 
    PRINT('*** La tabla Alumno ya existe en la base de datos')

-- TRUNCATE TABLE [db_tp_bd_aplicada].[negocio].[Alumno]
-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Alumno]