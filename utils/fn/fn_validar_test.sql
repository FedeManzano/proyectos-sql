USE db_utils 


GO
CREATE OR ALTER FUNCTION [library].[fn_Validar_Test] (@NROTEST INT, @ESPERADO INT, @OBTENIDO INT)
RETURNS INT 
BEGIN 
    IF @ESPERADO = @OBTENIDO
    BEGIN 
        SELECT '(' + CAST( @NROTEST AS VARCHAR(MAX) ) + ')TEST PASS - ' + 
                     CAST(@ESPERADO AS VARCHAR(MAX)) + ', ' + @OBTENIDO
        RETURN 1
    END
    ELSE 
    BEGIN 
        PRINT
        (
            '(' + CAST( @NROTEST AS VARCHAR(MAX) ) + ')TEST FAIL - ' + 
                CAST(@ESPERADO AS VARCHAR(MAX)) + ', ' + @OBTENIDO
        )
        RETURN 0
    END
END 