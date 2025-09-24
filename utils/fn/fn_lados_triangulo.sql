USE db_utils 

GO
CREATE OR ALTER FUNCTION [library].[fn_Es_Triangulo] (@LADOA INT, @LADOB INT, @LADOC INT)
RETURNS INT 
BEGIN 
    IF @LADOA <= 0 OR @LADOB <= 0 OR @LADOC <= 0
        RETURN 0
    -- Validar desigualdad triangular
    IF @LADOA + @LADOB <= @LADOC OR @LADOA + @LADOC <= @LADOB OR @LADOB + @LADOC <= @LADOA
        RETURN 0

    -- Clasificación
    IF @LADOA = @LADOB AND @LADOB = @LADOC
        RETURN 1 -- Equilátero
    IF @LADOA = @LADOB OR @LADOA = @LADOC OR @LADOB = @LADOC
        RETURN 2 -- Isósceles
    RETURN 3 -- Escaleno 
END
