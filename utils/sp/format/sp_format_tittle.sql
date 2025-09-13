USE db_utils

GO
CREATE OR ALTER PROCEDURE [library].[sp_Format_Tittle]
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

    DECLARE @PALABRAS TABLE 
    (
        Campo NVARCHAR(MAX)
    )


    INSERT INTO @PALABRAS (Campo) 
    SELECT value FROM STRING_SPLIT(@CADENA, ' ') WHERE value <> ' '

    DECLARE @CANT INT = (SELECT COUNT(1) FROM @PALABRAS)
    DECLARE @CADENA_AUX VARCHAR(MAX)

    SET @CADENA = ''

    WHILE @CANT >= 1
    BEGIN 
        SELECT @CADENA_AUX = Campo FROM @PALABRAS 
        WHERE Campo IN 
        (   
           SELECT TOP(1)Campo FROM @PALABRAS 
        )

        SET @CADENA_AUX =  TRIM(UPPER(SUBSTRING(@CADENA_AUX, 1, 1)) +  LOWER(SUBSTRING(@CADENA_AUX, 2, LEN(@CADENA_AUX))))
        SET @CADENA = @CADENA + @CADENA_AUX + ' '
        SET @CADENA_AUX  = ''
    
        SET @CANT = @CANT - 1
        
        DELETE TOP(1) FROM @PALABRAS
    END


    SET @CADENA = TRIM(@CADENA)
END
GO