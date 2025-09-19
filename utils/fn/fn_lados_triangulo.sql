USE db_utils 

GO
CREATE OR ALTER FUNCTION [library].[fn_Es_Triangulo] (@LADOA INT, @LADOB INT, @LADOC INT)
RETURNS INT 
BEGIN 
    IF @LADOA <= 0 OR @LADOB <= 0 OR @LADOC <= 0
        RETURN 0
    IF @LADOA + @LADOB < @LADOC
        RETURN 0
    IF @LADOA + @LADOC < @LADOB
        RETURN 0
    IF @LADOC + @LADOB < @LADOA
        RETURN 0
    IF @LADOA = @LADOB AND @LADOB = @LADOC
        RETURN 1
    IF @LADOA = @LADOB AND @LADOB <> @LADOC
        RETURN 2
    IF @LADOA = @LADOC AND @LADOB <> @LADOA
        RETURN 2
    IF @LADOC = @LADOB AND @LADOB <> @LADOA
        RETURN 2
    IF @LADOA <> @LADOB AND @LADOA <> @LADOC
        RETURN 3
    RETURN 0    
END
