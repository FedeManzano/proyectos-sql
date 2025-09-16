USE db_tp_bd_aplicada


IF NOT EXISTS 
(
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES  
    WHERE   TABLE_SCHEMA = 'negocio' AND
            TABLE_NAME   = 'Docente'
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Docente]
    (
        TipoDoc TINYINT NOT NULL,
        NroDoc VARCHAR(8) NOT NULL,
        Cargo VARCHAR(30) NOT NULL,
        CONSTRAINT PK_Docente PRIMARY KEY(TipoDoc, NroDoc), 
        CONSTRAINT FK_Persona_Docente FOREIGN KEY(TipoDoc, NroDoc)
        REFERENCES [db_tp_bd_aplicada].[negocio].[Persona](IDTipo, NroDoc)
    )
END 
ELSE PRINT('*** La tabla [Docente] ya existe en la base de datos')

-- TRUNCATE TABLE [db_tp_bd_aplicada].[negocio].[Docente]
-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Docente]

