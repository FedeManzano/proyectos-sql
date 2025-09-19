USE db_utils 

GO
CREATE OR ALTER PROCEDURE [library].[sp_Validate_Test]
@NRO_TEST INT,
@ESPERADO INT,
@OBTENIDO INT,
@RES INT = -1 OUTPUT
AS 
BEGIN 
    IF @ESPERADO = @OBTENIDO
    BEGIN 
        PRINT
        (
            '(' + CAST( @NRO_TEST AS VARCHAR(MAX) ) + ')TEST PASS - ' + 
               'ESP: ' + CAST(@ESPERADO AS VARCHAR(MAX)) + ', ' + 'Obt: ' + CAST(@OBTENIDO AS VARCHAR(MAX)) 
        )
        SET @RES = @OBTENIDO
        RETURN 1
    END
    ELSE 
    BEGIN 
        PRINT
        (
            '(' + CAST( @NRO_TEST AS VARCHAR(MAX) ) + ')TEST FAIL - ' + 
                'ESP: ' + CAST(@ESPERADO AS VARCHAR(MAX)) + ', ' + 'Obt: ' + CAST(@OBTENIDO AS VARCHAR(MAX)) 
        )
        SET @RES = @OBTENIDO
        RETURN 0
    END
END
