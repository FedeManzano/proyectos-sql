
USE db_utils


GO
CREATE OR ALTER PROCEDURE [library].[sp_Generate_Valid_DNI]
    @DNI VARCHAR(15) OUTPUT
AS 
BEGIN 
    DECLARE @PRIMER_NUMERO VARCHAR(5) = '0' 
    DECLARE @ULTIMOS_SIETE_NUMEROS VARCHAR(15)

    EXEC [db_utils].[library].[sp_Str_Number_Random] 1,7,1, @PRIMER_NUMERO OUTPUT
    EXEC [db_utils].[library].[sp_Str_Number_Random] 0, 9, 7, @ULTIMOS_SIETE_NUMEROS OUTPUT

    SET @DNI = @PRIMER_NUMERO + @ULTIMOS_SIETE_NUMEROS
END
--DECLARE @D VARCHAR(15) = '' 
--EXEC [db_utils].[library].[sp_Generate_Valid_DNI] @D OUTPUT

--SELECT @D