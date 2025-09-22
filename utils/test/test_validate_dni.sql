
USE db_utils

DECLARE @ESPERADO INT = 1
DECLARE @OBTENIDO INT = [db_utils].[library].[fn_validate_dni]('32595830') -- DNI Válido

/**
    TEST 1
    DNI Ok retorno de la función es 1
*/
EXEC [db_utils].[library].[sp_Assert_Equals] 1, 'ENT: 32595830',@ESPERADO, @OBTENIDO, NULL

SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_validate_dni]('3259583') -- DNI Inválido

/**
    TEST 2
    DNI con menos caracteres (7) retorno de la función es 0
*/
EXEC [db_utils].[library].[sp_Assert_Equals] 2, 'ENT: 3259583',@ESPERADO, @OBTENIDO, NULL 


SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_validate_dni]('325958300') -- DNI Inválido

/**
    TEST 3
    DNI con mas caracteres (9) retorno de la función es 0
*/
EXEC [db_utils].[library].[sp_Assert_Equals] 3, 'ENT: 325958300',@ESPERADO, @OBTENIDO, NULL 


SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_validate_dni](' 325958300') -- DNI Inválido

/**
    TEST 4
    DNI con un espacio al inicio
*/
EXEC [db_utils].[library].[sp_Assert_Equals] 4, 'ENT:  32595830',@ESPERADO, @OBTENIDO, NULL 


SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_validate_dni]('32595830 ') -- DNI Inválido

/**
    TEST 5
    DNI con un espacio al inicio
*/
SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_validate_dni]('3259 583') -- DNI Inválido

EXEC [db_utils].[library].[sp_Assert_Equals] 5, 'ENT: 3259 830 ',@ESPERADO, @OBTENIDO, NULL 

/**
    TEST 6
    DNI con un espacio al medio
*/
EXEC [db_utils].[library].[sp_Assert_Equals] 6, 'ENT: 3259 583',@ESPERADO, @OBTENIDO, NULL 


SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_validate_dni]('+3259583') -- DNI Inválido

/**
    TEST 7
    DNI con caracteres especiales
*/
EXEC [db_utils].[library].[sp_Assert_Equals] 7, 'ENT: +3259583',@ESPERADO, @OBTENIDO, NULL 


SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_validate_dni]('325-9583') -- DNI Inválido

/**
    TEST 8
    DNI con caracteres especiales en medio
*/
EXEC [db_utils].[library].[sp_Assert_Equals] 8, 'ENT: 3259-583',@ESPERADO, @OBTENIDO, NULL 



SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_validate_dni]('3259583-') -- DNI Inválido

/**
    TEST 9
    DNI con caracteres especiales al final
*/
EXEC [db_utils].[library].[sp_Assert_Equals] 9, 'ENT: 3259583-',@ESPERADO, @OBTENIDO, NULL 


SET @ESPERADO = 0
SET @OBTENIDO = [db_utils].[library].[fn_validate_dni]('325958300') -- DNI Inválido

/**
    TEST 10
    DNI mas de 8 caracteres
*/
EXEC [db_utils].[library].[sp_Assert_Equals] 10, 'ENT: 325958300',@ESPERADO, @OBTENIDO, NULL 