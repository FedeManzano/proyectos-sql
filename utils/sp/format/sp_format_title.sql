USE db_utils

GO
CREATE OR ALTER PROCEDURE [library].[sp_Format_Title]
@CADENA VARCHAR(MAX) OUTPUT
AS 
BEGIN
    SET NOCOUNT ON
    IF @CADENA IS NULL 
    BEGIN 
        SET @CADENA = ''
        RETURN 0
    END
    SET @CADENA = TRIM(@CADENA)

    DECLARE @PALABRA NVARCHAR(MAX)
    DECLARE @RESULTADO VARCHAR(MAX) = ''

    DECLARE palabras_cursor CURSOR FOR
        SELECT value FROM STRING_SPLIT(@CADENA, ' ') WHERE value <> ' '

    OPEN palabras_cursor
    FETCH NEXT FROM palabras_cursor INTO @PALABRA
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @PALABRA = TRIM(UPPER(SUBSTRING(@PALABRA, 1, 1)) + LOWER(SUBSTRING(@PALABRA, 2, LEN(@PALABRA))))
        SET @RESULTADO = @RESULTADO + @PALABRA + ' '
        FETCH NEXT FROM palabras_cursor INTO @PALABRA
    END
    CLOSE palabras_cursor
    DEALLOCATE palabras_cursor

    SET @CADENA = TRIM(@RESULTADO)
END
GO
