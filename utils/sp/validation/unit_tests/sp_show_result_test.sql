USE db_utils;

GO
CREATE OR ALTER PROCEDURE [library].[sp_Show_Result_Test]
@NRO_TEST                   INT,
@DESC_TEST                  NVARCHAR(MAX),
@RES                        BIT = 0
AS 
BEGIN 
    DECLARE @RESULTADO_DESC VARCHAR(18) = ''
    IF @RES = 1
    BEGIN
        SET @RESULTADO_DESC = ' PASS_OK - '
    END
    ELSE 
    BEGIN
        SET @RESULTADO_DESC = ' FAIL_!! - '
    END

    PRINT
    (
        'TEST ('+ CAST( @NRO_TEST AS VARCHAR(MAX) ) +')'+ ': ' + @RESULTADO_DESC +  @DESC_TEST
    )
END


