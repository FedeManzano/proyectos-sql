
USE db_utils

GO
CREATE OR ALTER PROCEDURE [library].[sp_Date_Random]
@FINI DATE,
@FSAL DATETIME OUTPUT
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
    EXEC @INTER = [db_utils].[library].[sp_Str_Number_Random] 0,9,5,NULL 
    SET @FSAL = DATEADD(DAY, @INTER, @FINI)
END


