
USE db_utils
/**
    Procedimiento almacenado para generar un DNI válido
    EJ 
    DECLARE @DNI VARCHAR(15) = ''
    EXEC [db_utils].[library].[sp_Generate_Valid_DNI] @DNI OUTPUT 
    SELECT @DNI -- MUESTRA UN DNI VÁLIDO
*/

GO
CREATE OR ALTER PROCEDURE [library].[sp_Generate_Valid_DNI]
    @DNI VARCHAR(15) OUTPUT
AS 
BEGIN 
    SET NOCOUNT ON
    --- Declaración de variables
    DECLARE @PRIMER_NUMERO VARCHAR(5) = '0' 
    DECLARE @ULTIMOS_SIETE_NUMEROS VARCHAR(15)

    --- Generar el primer número del DNI (entre 1 y 7)
    EXEC [db_utils].[library].[sp_Str_Number_Random] 1,7,1, @PRIMER_NUMERO OUTPUT

    --- Generar los últimos siete números del DNI (entre 0000000 y 9999999)
    EXEC [db_utils].[library].[sp_Str_Number_Random] 0, 9, 7, @ULTIMOS_SIETE_NUMEROS OUTPUT

    --- Combinar el primer número con los últimos siete números para formar el DNI completo
    SET @DNI = @PRIMER_NUMERO + @ULTIMOS_SIETE_NUMEROS
END
