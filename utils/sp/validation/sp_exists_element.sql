USE db_utils 
/**
    Procedimiento almacenado que verifica si existe un elemento en una tabla específica de una base de datos
    Parámetros:
        @N_DB NVARCHAR(MAX): Nombre de la base de datos
        @N_SCH NVARCHAR(MAX): Nombre del esquema
        @N_TABLA NVARCHAR(MAX): Nombre de la tabla
        @N_CAMPO NVARCHAR(MAX): Nombre del campo a verificar
        @PARAMETRO NVARCHAR(MAX): Valor del campo a buscar
        @RETURN INT OUTPUT: Resultado de la verificación (1 = Existe, 0 = No existe, -1 = Error)
    Autor: Federico Manzano
*/  
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

    IF  @N_DB       IS NULL     OR 
        @N_SCH      IS NULL     OR  
        @N_TABLA    IS NULL 
    BEGIN 
        SET @RETURN = 0
        RETURN @RETURN
    END 
            
    
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
    
    SET @RETURN = -1

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

