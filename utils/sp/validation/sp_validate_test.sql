USE db_utils 

GO
CREATE OR ALTER PROCEDURE [library].[sp_Validate_Test]
@NRO_TEST                   INT,
@DESC_TEST                  NVARCHAR(MAX),
@ESPERADO                   INT,
@OBTENIDO                   INT,
@RES                        INT = -1 OUTPUT
AS 
BEGIN

    DECLARE @RESULTADO_DESC VARCHAR(10) = ''
    IF @ESPERADO = @OBTENIDO
    BEGIN
        SET @RESULTADO_DESC = ' PASS - '
        SET @RES = 1
    END
    ELSE 
    BEGIN
        SET @RESULTADO_DESC = ' FAIL - '
        SET @RES = 0
    END
    PRINT
    (
        'TEST '+ CAST( @NRO_TEST AS VARCHAR(MAX) ) + ' :' + @RESULTADO_DESC +  @DESC_TEST + ' ' + 
        'ESP: ' + 
            CAST(@ESPERADO AS VARCHAR(MAX)) + ', ' + 
        'OBT: ' + 
            CAST(@OBTENIDO AS VARCHAR(MAX)) 
    )
    RETURN @RES
END
