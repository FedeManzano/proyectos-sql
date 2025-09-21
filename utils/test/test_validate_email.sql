USE db_utils

/***
    TEST 1 email valido retorno 1
*/
DECLARE @ESPERADO INT = 1
DECLARE @OBTENIDO INT = [db_utils].[library].[fn_Validate_Email]('federico@gmail.com') -- email Válido

EXEC [db_utils].[library].[sp_Assert_Equals] 1, 'ENT: federico@gmail.com',@ESPERADO, @OBTENIDO, NULL 


/***
    TEST 2 email punto intermedio VALIDO
*/
SET @ESPERADO = 1
SET @OBTENIDO = [db_utils].[library].[fn_Validate_Email]('fede.rico@gmail.com') -- email Válido

EXEC [db_utils].[library].[sp_Assert_Equals] 2, 'ENT: fede.rico@gmail.com',@ESPERADO, @OBTENIDO, NULL 


/***
    TEST 3 email punto inicio INVALIDO
*/
SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_Validate_Email]('.federico@gmail.com')

EXEC [db_utils].[library].[sp_Assert_Equals] 3, 'ENT: .federico@gmail.com',@ESPERADO, @OBTENIDO, NULL 


/***
    TEST 4 email punto final INVALIDO
*/
SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_Validate_Email]('federico@gmail.com.')

EXEC [db_utils].[library].[sp_Assert_Equals] 4, 'ENT: federico@gmail.com.',@ESPERADO, @OBTENIDO, NULL 

/***
    TEST 5 email caracter especial NO -_. en medio
*/
SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_Validate_Email]('fede*rico@gmail.com')

EXEC [db_utils].[library].[sp_Assert_Equals] 5, 'ENT: fede*rico@gmail.com',@ESPERADO, @OBTENIDO, NULL 


/***
    TEST 6 email caracter especial NO -_. al final
*/
SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_Validate_Email]('federico@gmail.com*')

EXEC [db_utils].[library].[sp_Assert_Equals] 6, 'ENT: federico@gmail.com*',@ESPERADO, @OBTENIDO, NULL

/***
    TEST 7 email caracter punto al lado delante de la arroba
*/
SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_Validate_Email]('federico.@gmail.com*')

EXEC [db_utils].[library].[sp_Assert_Equals] 7, 'ENT: federico.@gmail.com*',@ESPERADO, @OBTENIDO, NULL