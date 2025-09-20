USE db_utils

/***
    Función que permite la validación del DNI (8) Caracteres numéricos
    Devuelve 0 si el DNI es inválido
    Devuelve 1 si el DNI es válido
*/
GO
CREATE OR ALTER FUNCTION [library].[fn_Validate_Dni](@DNI VARCHAR(15))
RETURNS TINYINT
AS 
BEGIN 
    IF  LEN(@DNI) <> 8 OR
        @DNI NOT LIKE '[1-7][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    BEGIN 
        RETURN 0 -- FALLO
    END
    RETURN 1 -- OK
END

