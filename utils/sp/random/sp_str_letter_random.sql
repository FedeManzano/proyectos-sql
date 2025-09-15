USE db_utils

GO
/**
    Sp que genera una cadena de letras random para resolver el problema de las patentes de los vehículos.
    Recibe la cantidad de caracteres que tiene que tener la cadena y devuelve a través 
    del parámetro OUTPUT la cadena solicitada

    EJ
    DECLARE @RES VARCHAR(10) = ''
    EXEC ddbba.sp_Cadena_Random_Letras 4,@S_RES = @RES OUTPUT
    SELECT @RES 
*/
CREATE OR ALTER PROCEDURE [library].[sp_Str_letter_Random]
@CANT_LETRAS INT, 
@MAY INT = 1,
@S_RES VARCHAR(MAX) = '' OUTPUT
AS 
BEGIN 
    IF  @CANT_LETRAS IS NULL    OR 
        @CANT_LETRAS <= 0   
        RETURN 0
    
    SET @S_RES = ''
    DECLARE @LETRAS VARCHAR(26) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

    IF @MAY <> 1
        SET @LETRAS = LOWER(@LETRAS)

    DECLARE @I INT = 0
    DECLARE @INDEX INT = 0

    WHILE @I < @CANT_LETRAS
    BEGIN 
        SET @INDEX = CAST((RAND() * LEN(@LETRAS) + 1 ) AS INT)
        SET @S_RES = @S_RES + SUBSTRING(@LETRAS, @INDEX, 1)
        SET @I = @I + 1
    END 
    RETURN 1 -- Para hacer las pruebas
END

/*
DECLARE @PALABRA VARCHAR(30) = ''
EXEC [db_utils].[library].[sp_Str_letter_Random] 11,0,@PALABRA OUTPUT 
SELECT @PALABRA*/



