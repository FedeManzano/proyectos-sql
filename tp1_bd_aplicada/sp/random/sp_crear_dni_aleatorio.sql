
USE db_tp_bd_aplicada

GO 
CREATE OR ALTER PROCEDURE [negocio].[sp_Crear_Dni_Aleatorio]
@DNI VARCHAR(8) = '' OUTPUT 
AS 
BEGIN 

    SET @DNI = ''
    DECLARE @PRIMER_NUMERO CHAR(1)
    DECLARE @SIETE_NUMEROS CHAR(7)

    EXEC [db_utils].[library].[sp_Str_Number_Random] 1,7,1,@PRIMER_NUMERO OUTPUT
    EXEC [db_utils].[library].[sp_Str_Number_Random] 0,9,7,@SIETE_NUMEROS OUTPUT

    WHILE EXISTS (SELECT 1 FROM [db_tp_bd_aplicada].[negocio].[Persona] WHERE NroDoc = @DNI)
    BEGIN 
        EXEC [db_utils].[library].[sp_Str_Number_Random] 1,7,1,@PRIMER_NUMERO OUTPUT
        EXEC [db_utils].[library].[sp_Str_Number_Random] 0,9,7,@SIETE_NUMEROS OUTPUT
    END
    SET @DNI = @PRIMER_NUMERO + @SIETE_NUMEROS
END


-- DROP [db_tp_bd_aplicada].[negocio].[sp_Crear_Dni_Aleatorio]