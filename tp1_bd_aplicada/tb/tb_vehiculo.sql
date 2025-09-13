
USE db_tp_bd_aplicada

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Vehiculo]')
BEGIN
   CREATE TABLE [db_tp_bd_aplicada].[negocio].[Vehiculo]
    (
        Patente VARCHAR(7) PRIMARY KEY,
        Modelo VARCHAR(30) NOT NULL,
        IDTipo TINYINT NOT NULL,
        NroDoc VARCHAR(8) NOT NULL,
        CONSTRAINT CK_Patente CHECK
        (
            Patente NOT LIKE '[A-Z0-9 ]'
        ),

        CONSTRAINT FK_Persona FOREIGN KEY(IDTipo, NroDoc) REFERENCES 
        [db_tp_bd_aplicada].[negocio].[Persona](IDTipo,NroDoc)

    );
END

-- TRUNCATE TABLE [db_tp_bd_aplicada].[negocio].[Vehiculo]
-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Vehiculo]