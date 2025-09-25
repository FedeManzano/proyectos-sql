USE db_utils

/****
    Procedimiento almacenado para validar un cuit según su dígito 
    verificados, si el cuit es válido       @RES OUTPUT =    1
                 si el cuit no es válido    @RES OUTPUT =   -1
    
    EJ 
    DECLARE @R INT = -1
    EXEC [db_utils].[library].[sp_Validate_Cuit] '20325958309', @R OUTPUT
    SELECT @R --> MUESTRA 1
*/
GO
CREATE OR ALTER PROCEDURE [library].[sp_Validate_Cuit]
@CUIT   VARCHAR(MAX),
@RES    INT = -1         OUTPUT
AS 
BEGIN 

    SET @RES = -1
    IF @CUIT IS NULL 
        RETURN -1
    
    SET @CUIT = REPLACE(@CUIT, '-', '')

        IF  LEN(@CUIT)  <>      11          OR
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

    DECLARE @DIG_VER        INT = RIGHT(@CUIT, 1)
    DECLARE @CANT_NUM       INT = 0
    DECLARE @COHEF_ACTUAL   INT = 0
    DECLARE @SUM            INT = 0
    DECLARE @CAR_ACTUAL     CHAR


    WHILE @CANT_NUM < 10
    BEGIN 
        SET @COHEF_ACTUAL = 
        ( 
            SELECT TOP(1) Cohef 
            FROM @COHEFICIENTES
        )

        SET @CAR_ACTUAL = SUBSTRING
        (
            @CUIT, 
            @CANT_NUM + 
            1, 
            1
        )

        SET @SUM = @SUM + 
        (
            CAST(@CAR_ACTUAL AS INT) * @COHEF_ACTUAL
        )

        SET @CANT_NUM = @CANT_NUM + 1
        DELETE TOP(1) FROM @COHEFICIENTES
    END

    SET @RES = @SUM % 11
    SET @RES = 11 - @RES

    IF @RES = @DIG_VER
    BEGIN 
        SET @RES    = 1
        RETURN        @DIG_VER
    END
    ELSE 
    BEGIN 
        SET @RES =  -1
        RETURN      -1
    END
END
