# Documentación de las dependendencias SQL

```SQL
/*
   1 - CREAR LA BASE DE DATOS Y LOS ESQUEMAS
   
   2 - FN
   /fn/fn_validate_dni.sql
   /fn/fn_validate_email.sql

   3 - SP
   /sp/format/sp_format_tittle.sql
   /sp/random/sp_date_random
   /sp/random/sp_letter_random
   /sp/random/sp_number_random
*/
```

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

### sp_validate_test

Procedimiento almacenado para ser reutilizado en todos los test unitarios:
Imprime el resultado por la consola de mensajes y evalúa el resultado obtenido con el esperado

```SQL 
USE db_utils 

GO
CREATE OR ALTER PROCEDURE [library].[sp_Validate_Test]
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
        SET @RESULTADO_DESC = ' ¡¡¡FAIL_!!! - '
        SET @RES = 0
    END
    PRINT
    (
        'TEST ('+ CAST( @NRO_TEST AS VARCHAR(MAX) ) +')'+ ': ' + @RESULTADO_DESC +  @DESC_TEST + ' ' + 
        'ESP: ' + 
            CAST(@ESPERADO AS VARCHAR(MAX)) + ', ' + 
        'OBT: ' + 
            CAST(@OBTENIDO AS VARCHAR(MAX)) 
    )
    RETURN @RES
END
```

### Autor

[Federico Manzano](https://github.com/FedeManzano)

