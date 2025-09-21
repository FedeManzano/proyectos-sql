USE db_utils 

GO
CREATE OR ALTER PROCEDURE [library].[sp_Exists_Element] 
@N_DB       NVARCHAR(MAX),
@N_SCH      NVARCHAR(MAX),
@N_TABLA    NVARCHAR(MAX),
@N_CAMPO    NVARCHAR(MAX),
@PARAMETRO  NVARCHAR(MAX),
@RETURN     INT OUTPUT
AS 
BEGIN 
    SET @RETURN = -1
    IF NOT EXISTS 
    (
        SELECT 1
        FROM sys.databases 
        WHERE name = @N_DB
    )
    BEGIN 
        SET @RETURN = 0
        RETURN @RETURN
    END
    
    DECLARE @TA TABLE 
    (
        VAL INT
    )

    DECLARE @SQL_QUERY NVARCHAR(MAX) = 
    'SELECT 1 
     FROM ' + QUOTENAME(@N_DB,     '[]')   + '.' + 
              QUOTENAME(@N_SCH,    '[]')   + '.' +
              QUOTENAME(@N_TABLA,  '[]')   + ' '  +
    'WHERE ' + @N_CAMPO + ' = ' + CAST(@PARAMETRO AS NVARCHAR(MAX)) 

    INSERT INTO @TA
    EXEC(@SQL_QUERY)

    SELECT @RETURN = VAL 
    FROM @TA

    RETURN @RETURN
END

