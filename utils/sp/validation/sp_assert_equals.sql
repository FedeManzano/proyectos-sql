USE db_utils 

GO
CREATE OR ALTER PROCEDURE [library].[sp_Assert_Equals]
@NRO_TEST                   INT,
@DESC_TEST                  NVARCHAR(MAX),
@ESPERADO                   INT,
@OBTENIDO                   INT,
@RES                        INT = -1 OUTPUT
AS 
BEGIN

    DECLARE @RESULTADO_DESC VARCHAR(18) = ''
    IF @ESPERADO = @OBTENIDO
    BEGIN
        SET @RESULTADO_DESC = ' PASS_OK - '
        SET @RES = 1
    END
    ELSE 
    BEGIN
        SET @RESULTADO_DESC = ' ¡¡¡FAIL_!!! - '
        SET @RES = 0
    END
    PRINT
    (
        'TEST ('+ CAST( @NRO_TEST AS VARCHAR(MAX) ) +')'+ ': ' + @RESULTADO_DESC +  @DESC_TEST + ' | ' + 
        'ES ' + 
            CAST(@ESPERADO AS VARCHAR(MAX)) + ' <=> ' + 
        'OB ' + 
            CAST(@OBTENIDO AS VARCHAR(MAX)) 
    )
    RETURN @RES
END
