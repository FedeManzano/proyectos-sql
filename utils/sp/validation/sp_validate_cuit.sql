USE db_utils

GO
CREATE OR ALTER PROCEDURE [library].[sp_Validate_Cuit]
@CUIT   VARCHAR(MAX),
@RES    INT = 0         OUTPUT
AS 
BEGIN 
    IF @CUIT IS NULL 
        RETURN -1
    
    SET @CUIT = REPLACE(@CUIT, '-', '')

    IF  LEN(@CUIT)  <>      11          AND
        @CUIT       LIKE    '%[^0-9]%'
        RETURN -1

    IF LEFT(@CUIT, 2) NOT IN (20, 23, 24, 25, 26, 27)
        RETURN -1


    DECLARE @COHEFICIENTES TABLE 
    (
        Cohef INT NOT NULL
    )

    INSERT INTO @COHEFICIENTES 
    (       Cohef   ) VALUES
    (       5       ),
    (       4       ),
    (       3       ),
    (       2       ),
    (       7       ),
    (       6       ),
    (       5       ),
    (       4       ),
    (       3       ),
    (       2       )

    DECLARE @DIG_VER INT = RIGHT(@CUIT, 1)

    DECLARE @CANT_NUM       INT = 0
    DECLARE @COHEF_ACTUAL   INT = 0
    DECLARE @SUM            INT = 0
    DECLARE @CAR_ACTUAL     CHAR

    WHILE @CANT_NUM < 10
    BEGIN 
        SET @COHEF_ACTUAL = (SELECT TOP(1)Cohef FROM @COHEFICIENTES)

        SET @CAR_ACTUAL = SUBSTRING(@CUIT, @CANT_NUM + 1, 1)

        SET @SUM = @SUM + (CAST(@CAR_ACTUAL AS INT) * @COHEF_ACTUAL)

        SET @CANT_NUM = @CANT_NUM + 1
        DELETE TOP(1) FROM @COHEFICIENTES
    END

    SET @RES = @SUM % 11
    SET @RES = 11 - @RES

    IF @RES = @DIG_VER
    BEGIN 
        SET @RES = 1
        RETURN 1
    END
    ELSE 
    BEGIN 
        SET @RES = 0
        RETURN 0
    END
END
