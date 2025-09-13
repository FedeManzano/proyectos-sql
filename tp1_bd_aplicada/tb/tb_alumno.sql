
USE db_tp_bd_aplicada

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Alumno]' )
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

