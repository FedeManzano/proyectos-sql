USE db_utils 

/**
    Procedimiento almacenado que compara el valor esperado con el obtenido
    Parámetros:
        @NRO_TEST INT: Número del test
        @DESC_TEST NVARCHAR(MAX): Descripción del test
        @ESPERADO INT: Valor esperado
        @OBTENIDO INT: Valor obtenido
    Autor: Federico Manzano
*/
GO
CREATE OR ALTER PROCEDURE [library].[sp_Assert_No_Equals]
@NRO_TEST                   INT,
@DESC_TEST                  NVARCHAR(MAX),
@ESPERADO                   INT,
@OBTENIDO                   INT,
@RES                        INT = -1 OUTPUT
AS 
BEGIN
    DECLARE @RESULTADO_DESC VARCHAR(18) = ''
    IF @ESPERADO <> @OBTENIDO
    BEGIN
        EXEC [db_utils].[library].[sp_Show_Result_Test] @NRO_TEST, @DESC_TEST, 1
        SET @RES = 1
    END
    ELSE 
    BEGIN
        EXEC [db_utils].[library].[sp_Show_Result_Test] @NRO_TEST, @DESC_TEST, 0
        SET @RES = 0
    END
    RETURN @RES
END