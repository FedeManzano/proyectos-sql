
USE db_tp_bd_aplicada

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Se_Inscribe]' )
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Se_Inscribe]
    (
        TipoAlumno TINYINT NOT NULL,
        NroDocAlumno VARCHAR(8) NOT NULL,
        TipoDocente TINYINT NOT NULL,
        NroDocDocente VARCHAR(8) NOT NULL,
        NroComision INT NOT NULL,
        CodMAteria CHAR(4) NOT NULL,
        Cuatrimestre TINYINT NOT NULL,
        DiaSemana TINYINT NOT NULL,
        Año INT NOT NULL,

        PRIMARY KEY (TipoAlumno, NroDocAlumno, TipoDocente, NroDocDocente,NroComision, CodMAteria, Cuatrimestre, DiaSemana, Año),

        FOREIGN KEY(TipoAlumno, NroDocAlumno) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Alumno](TipoDoc, NroDoc),
        FOREIGN KEY(TipoDocente, NroDocDocente, NroComision, CodMAteria, Cuatrimestre, DiaSemana, Año) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Comision] 
        (TipoDocDocente, NroDocDocente, NroComision, CodMateria, Cuatrimestre, DiaSemana, Año)
    )
END 

