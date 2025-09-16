USE db_tp_bd_aplicada


IF NOT EXISTS 
(
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA = 'negocio' AND
            TABLE_NAME = 'Tipo_Doc'
)
BEGIN
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Tipo_Doc]
    (
        IDTipo TINYINT PRIMARY KEY,
        Descripcion VARCHAR(3) NOT NULL,
        CONSTRAINT CK_DESC CHECK
        (
            Descripcion LIKE 'DNI' OR 
            Descripcion LIKE 'LC'  OR
            Descripcion LIKE 'CAR'
        ), 
    );
END
ELSE PRINT('*** La tabla [Tipo_Doc] ya existe en la base de datos')

-- TRUNCATE TABLE [db_tp_bd_aplicada].[negocio].[Tipo_Doc]
-- DROP TABLE [db_tp_bd_aplicada].[negocio].[Tipo_Doc]
