
USE db_utils

/**
    Procedimiento que devuelve una fecha (DATE) alearia 
    a partir de una fecha base pasada por parámetro y la cantidad de caracteres
    del intervalo POR EJ 1100 (4 CARACTERES) el parámetro sería 4 
                      EJ 1554 (4 CARACTERES) el parámetro sería 4
                      EJ 10455 (5 CARACTERES) el parámetro sería 5
                      POR DEFECTO ESTE PARÁMETRO ES 3
    EJECUCIÓN
    DECLARE @FRAN DATE
    EXEC [db_utils].[library].[sp_Date_Random] '2023-01-01',4, @FRAN OUTPUT 

    DEFAULT
    EXEC [db_utils].[library].[sp_Date_Random] '2023-01-01',DEFAULT, @FRAN OUTPUT -- Es 3 el DEFAULT 
*/
GO
CREATE OR ALTER PROCEDURE [library].[sp_Date_Random]
@FINI DATE,
@DIGITOS_INTERVALO BIGINT = 3, -- cantidad de digitos del intervalo de fechas
@FSAL DATE OUTPUT
AS 
BEGIN 
    DECLARE @RES_VAL INT = 
    CASE 
		WHEN TRY_CONVERT(DATETIME, @FINI) IS NOT NULL THEN 1
		ELSE 0
	END 

    IF @RES_VAL = 0
        RETURN 0
    
    DECLARE @INTER INT = -1
    EXEC @INTER = [db_utils].[library].[sp_Str_Number_Random] 0,9,@DIGITOS_INTERVALO,NULL 
    SET @FSAL = DATEADD(DAY, @INTER, @FINI)
END


