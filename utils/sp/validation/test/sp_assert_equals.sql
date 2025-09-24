USE db_utils 

GO
CREATE OR ALTER PROCEDURE [library].[sp_Assert_Equals]
@NRO_TEST                   INT,
@DESC_TEST                  NVARCHAR(MAX),
@ESPERADO                   INT,
@OBTENIDO                   INT,
@RES                        INT = -1 OUTPUT
AS 
BEGIN
    DECLARE @RESULTADO_DESC VARCHAR(18) = ''
    IF @ESPERADO = @OBTENIDO
    BEGIN
        EXEC [db_utils].[library].[sp_Show_Result_Test] @NRO_TEST, @DESC_TEST, 1
        SET @RES = 1
    END
    ELSE 
    BEGIN
        EXEC [db_utils].[library].[sp_Show_Result_Test] @NRO_TEST, @DESC_TEST, 0
        SET @RES = 0
    END
    RETURN @RES
END
