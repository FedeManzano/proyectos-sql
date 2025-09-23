
# Documentación de las dependencias SQL

## Requisitos previos

- SQL Server 2016 o superior (recomendado)
- Permisos para crear bases de datos y objetos (funciones, procedimientos)
- Cliente SQL compatible (SQL Server Management Studio, Azure Data Studio o extensión SQL para VS Code)
- Conocimientos básicos de T-SQL

Un conjunto reducido de funcionalidades SQL para reutilizar. El objetivo es el aprendizaje del lenguaje.

## Creación de elementos

Dentro de el direcorio ```db_utils``` se encuentran las dependencias que se utilizan en todos los proyectos de este repositorio, por lo tanto es necesario crearlas para utilizar los ejemplos expuestos.

- :green_book: <b>db_utils</b> (Crear la BD)
    - :open_file_folder: <b>fn</b>
        - :page_facing_up: <i>fn_lados_triangulo.sql</i>
        - :page_facing_up: <i>fn_validate_dni.sql</i>
        - :page_facing_up: <i>fn_validate_email.sql</i>
    - <b>sp</b>
        - :open_file_folder: <b>format</b>
            - :page_facing_up: <i>sp_format_tittle.sql</i> 
        - :open_file_folder: <b>random</b>
            - :page_facing_up: <i>sp_str_letter_random.sql</i> 
            - :page_facing_up: <i>sp_str_number_random.sql</i>
            - :page_facing_up: <i>sp_str_date_random.sql</i>
        - :open_file_folder: <b>validate</b> 
            - :page_facing_up: <i>sp_assert_equals.sql</i>
            - :page_facing_up: <i>sp_exists_element.sql</i>
            - :page_facing_up: <i>sp_validate_cuit.sql</i>

## Funciones

### fn_validate_dni.sql

Función que valida un dni de 8 caracteres numéricos.
Entrada el DNI a evaluar.
Salida 1 Si es válido y 0 si no lo es.
```SQL
USE db_utils

/***
    Función que permite la validación del DNI (8) Caracteres numéricos
    Devuelve 0 si el DNI es inválido
    Devuelve 1 si el DNI es válido
*/
GO
CREATE OR ALTER FUNCTION [library].[fn_Validate_Dni](@DNI VARCHAR(15))
RETURNS TINYINT
AS 
BEGIN 
    IF  LEN(@DNI) <> 8 OR
        @DNI NOT LIKE '[1-7][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
    BEGIN 
        RETURN 0 -- FALLO
    END
    RETURN 1 -- OK
END
```

### fn_validate_email

Función para validar un correo electrónico 1 si es válido y 0 si no lo es.

```SQL
/***
	Función para validar el correo electrónico 
	- Si el valor devuelto es 1 -> el correo es válido
	- Si el valor devuelto es 0 -> el correo es inválido
*/


GO 
CREATE OR ALTER FUNCTION [library].[fn_Validate_Email](@EMAIL VARCHAR(MAX))
RETURNS TINYINT 
AS 
BEGIN 
    IF	  @EMAIL LIKE		'%@%.%'
	  AND @EMAIL NOT LIKE	'-%'
	  AND @EMAIL NOT LIKE	'% %'
	  AND @EMAIL NOT LIKE	'%[^a-zA-Z0-9@._-]%'
	  AND @EMAIL NOT LIKE	'%@%@%'
	  AND @EMAIL NOT LIKE	'%@.%'
	  AND @EMAIL NOT LIKE	'.%'
	  AND @EMAIL NOT LIKE	'%.'
	  AND @EMAIL LIKE		'%@%'
	  AND @EMAIL LIKE		'%.%'
	  AND LEN(@EMAIL) >= 6
	  RETURN 1
        RETURN 0
END
```

## Procedimientos

### sp_format_tittle

Función que transforma un conjunto de palabras a formato título.

Por ej: ESA   CaSa   Es  MIA </br> 
RESUL: Esa Casa Es Mia

Entrada una cadena, la salida es la misma cadena.

```SQL
GO
CREATE OR ALTER PROCEDURE [library].[sp_Format_Tittle]
@CADENA VARCHAR(MAX) OUTPUT
AS 
BEGIN 
    SET NOCOUNT ON
    IF @CADENA IS NULL 
    BEGIN 
        SET @CADENA = ''
        RETURN 0
    END
    SET @CADENA = TRIM(@CADENA)

    DECLARE @PALABRAS TABLE 
    (
        Campo NVARCHAR(MAX)
    )


    INSERT INTO @PALABRAS (Campo) 
    SELECT value FROM STRING_SPLIT(@CADENA, ' ') WHERE value <> ' '

    DECLARE @CANT INT = (SELECT COUNT(1) FROM @PALABRAS)
    DECLARE @CADENA_AUX VARCHAR(MAX)

    SET @CADENA = ''

    WHILE @CANT >= 1
    BEGIN 
        SELECT @CADENA_AUX = Campo FROM @PALABRAS 
        WHERE Campo IN 
        (   
           SELECT TOP(1)Campo FROM @PALABRAS 
        )

        SET @CADENA_AUX =  TRIM(UPPER(SUBSTRING(@CADENA_AUX, 1, 1)) +  LOWER(SUBSTRING(@CADENA_AUX, 2, LEN(@CADENA_AUX))))
        SET @CADENA = @CADENA + @CADENA_AUX + ' '
        SET @CADENA_AUX  = ''
    
        SET @CANT = @CANT - 1
        
        DELETE TOP(1) FROM @PALABRAS
    END


    SET @CADENA = TRIM(@CADENA)
END
```
### sp_date_random

Procedimiento que devuelve una fecha (DATE) alearia 
a partir de una fecha base pasada por parámetro y la cantidad de caracteres
del intervalo
Por EJEMPLO:
 - 1554 (4 CARACTERES) el parámetro sería 4
 - 10455 (5 CARACTERES) el parámetro sería 5

POR DEFECTO ESTE PARÁMETRO ES 3

```SQL
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
```
### sp_str_letter_random

Procedimiento que genera una cadena de letras random.
Recibe la cantidad de caracteres que tiene que tener la cadena y devuelve a través del parámetro ```OUTPUT``` 
la cadena solicitada. </br></br>
EJEMPLO

```SQL
DECLARE @RES VARCHAR(10) = ''
EXEC ddbba.sp_Cadena_Random_Letras 4,@S_RES = @RES OUTPUT
SELECT @RES
```
```SQL 
USE db_utils

GO
/**
    Sp que genera una cadena de letras random para resolver el problema de las patentes de los vehículos.
    Recibe la cantidad de caracteres que tiene que tener la cadena y devuelve a través 
    del parámetro OUTPUT la cadena solicitada

    EJ
    DECLARE @RES VARCHAR(10) = ''
    EXEC ddbba.sp_Cadena_Random_Letras 4,@S_RES = @RES OUTPUT
    SELECT @RES 
*/
CREATE OR ALTER PROCEDURE [library].[sp_Str_letter_Random]
@CANT_LETRAS INT, 
@MAY INT = 1,
@S_RES VARCHAR(MAX) = '' OUTPUT
AS 
BEGIN 
    IF  @CANT_LETRAS IS NULL    OR 
        @CANT_LETRAS <= 0   
        RETURN 0
    
    SET @S_RES = ''
    DECLARE @LETRAS VARCHAR(26) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

    IF @MAY <> 1
        SET @LETRAS = LOWER(@LETRAS)

    DECLARE @I INT = 0
    DECLARE @INDEX INT = 0

    WHILE @I < @CANT_LETRAS
    BEGIN 
        SET @INDEX = CAST((RAND() * LEN(@LETRAS) + 1 ) AS INT)
        SET @S_RES = @S_RES + SUBSTRING(@LETRAS, @INDEX, 1)
        SET @I = @I + 1
    END 
    RETURN 1 -- Para hacer las pruebas
END
```

### sp_str_number_random

```SQL 
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
```

### sp_asset_equals

Procedimiento almacenado para ser reutilizado en todos los test unitarios:</br>
Imprime el resultado por la consola de mensajes y evalúa el resultado obtenido con el esperado.

```SQL 
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
        SET @RESULTADO_DESC = ' PASS_OK - '
        SET @RES = 1
    END
    ELSE 
    BEGIN
        SET @RESULTADO_DESC = ' FAIL_!! - '
        SET @RES = 0
    END
    PRINT
    (
        'TEST ('+ CAST( @NRO_TEST AS VARCHAR(MAX) ) +')'+ ': ' + @RESULTADO_DESC +  @DESC_TEST + ' | ' + 
        'ES ' + 
            CAST(@ESPERADO AS VARCHAR(MAX)) + ' <=> ' + 
        'OB ' + 
            CAST(@OBTENIDO AS VARCHAR(MAX)) 
    )
    RETURN @RES
END
```

### sp_validate_cuit

Procedimiento almacenado para validar un cuit según su dígito 
verificados: </br>
 - si el cuit es válido       @RES OUTPUT =    1
- si el cuit no es válido    @RES OUTPUT =   -1
    
EJEMPLO: <br>
```SQL
DECLARE @R INT = -1
EXEC [db_utils].[library].[sp_Validate_Cuit] '20325958309', @R OUTPUT
SELECT @R --> MUESTRA 1
```

```SQL 
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
        RETURN        1
    END
    ELSE 
    BEGIN 
        SET @RES =  -1
        RETURN      -1
    END
END
```

## Autor

[Federico Manzano](https://github.com/FedeManzano)