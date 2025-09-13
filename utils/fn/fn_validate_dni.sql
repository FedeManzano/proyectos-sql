USE db_utils


GO
CREATE OR ALTER FUNCTION [library].[fn_Validate_Dni](@DNI CHAR(8))
RETURNS TINYINT
AS 
BEGIN 
    IF  LEN(@DNI) <> 8 OR
        @DNI NOT LIKE '[1-7][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    BEGIN 
        RETURN 0
    END
    RETURN 1
END

