
USE db_tp_bd_aplicada

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Comision]' )
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Comision]
    (
        TipoDocDocente TINYINT NOT NULL,
        NroDocDocente VARCHAR(8) NOT NULL,
        CodMateria CHAR(4) NOT NULL,
        NroComision INT NOT NULL,
        Turno CHAR(2) NOT NULL,
        Cuatrimestre TINYINT NOT NULL,
        DiaSemana TINYINT NOT NULL,
        Año INT NOT NULL,
        CONSTRAINT PK_Docente_Comision 
            PRIMARY KEY(TipoDocDocente, NroDocDocente, NroComision, CodMAteria, Cuatrimestre, DiaSemana, Año),
        CONSTRAINT FK_Docente_Comision FOREIGN KEY(TipoDocDocente, NroDocDocente) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Docente](TipoDoc, NroDoc),
        CONSTRAINT FK_Materia FOREIGN KEY(CodMateria) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Materia](CodMateria),
        CONSTRAINT FK_DiaSemana FOREIGN KEY(DiaSemana) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Dia_Semana](CodDia)
    )
END

-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Comision]
-- TRUNCATE TABLE [db_tp_bd_aplicada].[negocio].[Comision]