
USE db_tp_bd_aplicada

GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Insertar_Comision]
@TIPO_DOC   TINYINT,
@NRO_DOC    CHAR(8),
@COD_MAT    CHAR(4),
@TURNO      CHAR(2),
@CUAT       TINYINT,
@D_SEM      TINYINT,
@ANO        INT
AS 
BEGIN 
    IF EXISTS 
    (
        SELECT 1
        FROM [db_tp_bd_aplicada].[negocio].[Comision]
        WHERE @TIPO_DOC = TipoDo
    )
END

