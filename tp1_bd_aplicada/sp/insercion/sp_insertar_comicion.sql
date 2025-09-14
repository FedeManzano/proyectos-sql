
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

    IF [db_utils].[library].[fn_Validate_Dni](@NRO_DOC) = 0
        RETURN 0 -- DNI Inválido

    IF NOT EXISTS
    (
        SELECT 1
        FROM [db_tp_bd_aplicada].[negocio].[Tipo_Doc]
        WHERE IDTipo = @TIPO_DOC
    ) 
        RETURN 0 -- Tipo Doc Inválido

    IF NOT EXISTS 
    (
        SELECT 1
        FROM [db_tp_bd_aplicada].[negocio].[Materia]
        WHERE CodMAteria = @COD_MAT
    ) 
        RETURN 0


    IF EXISTS 
    (
        SELECT 1
        FROM [db_tp_bd_aplicada].[negocio].[Comision]
        WHERE   @TIPO_DOC = TipoDocDocente  AND 
                @NRO_DOC  = NroDocDocente   AND
                @COD_MAT  = CodMateria      AND 
                @TURNO    = Turno           AND 
                @CUAT     = Cuatrimestre    AND 
                @ANO      = Año   
    )
    RETURN 0 -- Comisión repetida    
END



