USE db_utils


GO 
CREATE OR ALTER PROCEDURE library.sp_Str_Number_Random
/** 
    Los parámetros de entrada podrían ser más apropiados
    como TINYINT, por una cuestión de simplicidad los definí 
    con el tipo más utilizado INT.
*/
@I_RANGO    INT,        -- INICIO DEL RANGO DE VALORES POR EJ 2
@F_RANGO    INT,        -- FIN DEL RANGO DE VALORES POR EJ 7
@C_CAR      INT,        -- CANTIDAD DE CAREACRES DE LA CADENA ALEATOREA
@S_RES VARCHAR(MAX) = '' OUTPUT -- CADENA GENERADA EN LA SALIDA
AS 
BEGIN 
    IF @I_RANGO < 0 OR @I_RANGO >= @F_RANGO
        RETURN 0
    IF @F_RANGO < 0 OR @F_RANGO >= 10
        RETURN 0
    IF @C_CAR <= 0
        RETURN 0
    SET @S_RES = '' 
    -- Se carga esta cadena con los valores posibles
    -- según el rango que entra por parámetro
    DECLARE @VAL_POSIBLES VARCHAR(MAX) = ''


    -- Se caraga la cadena @VAL_POSIBLES con los valores posibles
    -- según el rango
    WHILE @I_RANGO <= @F_RANGO 
    BEGIN 
        SET @VAL_POSIBLES = @VAL_POSIBLES + CAST(@I_RANGO AS CHAR(1))
        SET @I_RANGO = @I_RANGO + 1
    END -- FIN WHILE

    SET @I_RANGO = 0 -- Lo pongo en 0 para generar el bucle y contar las cantidad de caracteres
                     -- Uso esta variable para no crear otra, en cualquier caso lo podemos cambiar
    DECLARE @INDEX INT = 0
    
    WHILE @I_RANGO < @C_CAR
    BEGIN
        -- INDEX Random para acceder a la @val_posibles y obtener un caracter
        SET @INDEX = CAST((RAND() * LEN(@VAL_POSIBLES) + 1 ) AS INT)

        -- Accede a la posición de la cadena INDEX y devuelve el caracter
        -- Para eso el OFFSET está en 1
        SET @S_RES = @S_RES + SUBSTRING(@VAL_POSIBLES, @INDEX, 1) 
        SET @I_RANGO = @I_RANGO + 1
    END -- FIN WHILE

    DECLARE @S_INT INT = TRY_CAST(@S_RES AS INT)
    SELECT @S_INT = ISNULL(@S_INT,-1)

    RETURN @S_INT -- Si no lo puede convertir devuelve -1
END
