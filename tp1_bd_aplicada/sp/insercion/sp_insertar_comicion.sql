
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
        RETURN 2

    IF NOT EXISTS 
    (
        SELECT 1
        FROM [db_tp_bd_aplicada].[negocio].[Docente]
        WHERE TipoDoc = @TIPO_DOC AND NroDoc = @NRO_DOC
    )
        RETURN 4

    IF NOT EXISTS
    (
        SELECT 1 
        FROM [db_tp_bd_aplicada].[negocio].[Materia]
        WHERE @COD_MAT = CodMAteria
    )
        RETURN 5


    IF @TURNO <> 'TM' AND @TURNO <> 'TN' AND @TURNO <> 'TT'
        RETURN 6

    IF EXISTS 
    (
        SELECT 1
        FROM [db_tp_bd_aplicada].[negocio].[Comision]
        WHERE   @TIPO_DOC = TipoDocDocente  AND 
                @NRO_DOC  = NroDocDocente   AND
                @COD_MAT  = CodMateria      AND 
                @TURNO    = Turno           AND 
                @CUAT     = Cuatrimestre    AND 
                @ANO      = Año             AND
                @D_SEM    = DiaSemana  
    )
        RETURN 7 -- Comisión repetida   
    
    IF @ANO < 1900 
        RETURN 8

    DECLARE @NRO_COM INT = 
    (
        SELECT ISNULL(MAX(NroComision), -1)
        FROM    [db_tp_bd_aplicada].
                [negocio].
                [Comision]
        WHERE   @COD_MAT  = CodMateria      AND 
                @TURNO    <> Turno           OR 
                @CUAT     <> Cuatrimestre    OR 
                @ANO      <> Año
    )

    IF @NRO_COM = -1
        SET @NRO_COM = 1
    ELSE 
        SET @NRO_COM = @NRO_COM + 1

    INSERT INTO [db_tp_bd_aplicada].[negocio].[Comision] 
    (
        NroComision, 
        CodMateria, 
        TipoDocDocente, 
        NroDocDocente, 
        Turno, 
        Cuatrimestre, 
        Año,
        DiaSemana
    )
    VALUES 
    (
        @NRO_COM,
        @COD_MAT,
        @TIPO_DOC,
        @NRO_DOC,
        @TURNO,
        @CUAT,
        @ANO,
        @D_SEM
    )


    RETURN 1
END

/*
SELECT * FROM [negocio].Comision

DECLARE @RET INT = 0
EXEC @RET = [db_tp_bd_aplicada].[negocio].[sp_Insertar_Comision] 1,'12898081','2933','TM',2,2,2025
SELECT @RET

EXEC [db_tp_bd_aplicada].[negocio].[sp_Insertar_Comision] 1,'12898081','2933','TM',1,3,2026 
*/