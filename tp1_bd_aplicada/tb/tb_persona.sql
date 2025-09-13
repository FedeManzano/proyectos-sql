
USE db_tp_bd_aplicada


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Persona]')
BEGIN
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Persona] 
    (
        IDTipo TINYINT NOT NULL,
        NroDoc VARCHAR(8) NOT NULL,
        Nombre VARCHAR(40) NOT NULL,
        Apellido VARCHAR(40) NOT NULL,
        FNac DATE NOT NULL,
        IdLocalidad INT NOT NULL,
        CONSTRAINT PK_Persona PRIMARY KEY(IDTipo, NroDoc),
        CONSTRAINT FK_TIPO FOREIGN KEY(IDTipo) REFERENCES [db_tp_bd_aplicada].[negocio].[Tipo_Doc],
        CONSTRAINT FK_Localidad FOREIGN KEY(IdLocalidad) REFERENCES  [db_tp_bd_aplicada].[negocio].[Localidad]
    );
END

-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Persona]
