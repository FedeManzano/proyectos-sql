
USE db_tp_bd_aplicada

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Dia_Semana]' )
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Dia_Semana]
    (
        CodDia TINYINT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(15) NOT NULL 
    )

    INSERT INTO [db_tp_bd_aplicada].[negocio].[Dia_Semana]( Nombre)
    VALUES 
    ('Lunes'),
    ('Martes'),
    ('Miércoles'),
    ('Jueves'),
    ('Viernes'),
    ('Sábado'),
    ('Domingo')
END

-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Dia_Semana]
