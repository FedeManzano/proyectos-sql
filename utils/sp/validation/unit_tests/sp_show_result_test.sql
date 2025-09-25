USE db_utils;
/**
    Procedimiento almacenado que muestra el resultado de un test
    Parámetros:
        @NRO_TEST INT: Número del test
        @DESC_TEST NVARCHAR(MAX): Descripción del test
        @RES BIT: Resultado del test (1 = OK, 0 = FAIL)
    Autor: Federico Manzano
*/
GO
CREATE OR ALTER PROCEDURE [library].[sp_Show_Result_Test]
@NRO_TEST                   INT,
@DESC_TEST                  NVARCHAR(MAX),
@RES                        BIT = 0
AS 
BEGIN 
    DECLARE @RESULTADO_DESC VARCHAR(18) = ''
    IF @RES = 1
    BEGIN
        SET @RESULTADO_DESC = ' PASS_OK - '
    END
    ELSE 
    BEGIN
        SET @RESULTADO_DESC = ' FAIL_!! - '
    END

    PRINT
    (
        'TEST ('+ CAST( @NRO_TEST AS VARCHAR(MAX) ) +')'+ ': ' + @RESULTADO_DESC +  @DESC_TEST
    )
END


