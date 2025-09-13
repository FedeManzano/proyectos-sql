
USE db_utils

GO
/**
    Evalúa si el primer parámetro es menor a cero, si es así devuelve 0
    caso contrario devuelve 1
*/
CREATE OR ALTER PROCEDURE [test].[sp_test_rango_inicial_neg_ret_cero]
AS 
BEGIN 
    DECLARE @RET INT = 0
    DECLARE @CADENA VARCHAR(MAX) = ''

    EXEC @RET = [db_utils].[library].[sp_Str_Number_Random] -1, 3, 3, @CADENA OUTPUT 
    PRINT('TEST 1: Rango inicial negativo')
    IF @RET = 0
        PRINT('Esperado: 0 | Devuelto: ' + CAST(@RET AS VARCHAR(MAX)))
    ELSE 
        PRINT('TEST 1: FAIL')
    PRINT('-----------------------------------------------------------')
END 

GO
CREATE OR ALTER PROCEDURE [test].[sp_test_rango_inicial_igual_final_cero]
AS 
BEGIN 
    DECLARE @RET INT = 0
    DECLARE @CADENA VARCHAR(MAX) = ''

    EXEC @RET = [db_utils].[library].[sp_Str_Number_Random] 3, 3, 3, @CADENA OUTPUT 
    PRINT('TEST 2: Rango inicial igual al rango final')
    IF @RET = 0
        PRINT('Esperado: 0 | Devuelto: ' + CAST(@RET AS VARCHAR(MAX)))
    ELSE 
        PRINT('TEST 2: FAIL')
    PRINT('-----------------------------------------------------------')
END 

GO
CREATE OR ALTER PROCEDURE [test].[sp_test_rango_final_igual_diez_0]
AS 
BEGIN 
    DECLARE @RET INT = 0
    DECLARE @CADENA VARCHAR(MAX) = ''

    EXEC @RET = [db_utils].[library].[sp_Str_Number_Random] 3, 10, 3, @CADENA OUTPUT 
    PRINT('TEST 3: Rango final igual a 10')
    IF @RET = 0
        PRINT('Esperado: 0 | Devuelto: ' + CAST(@RET AS VARCHAR(MAX)))
    ELSE 
        PRINT('TEST 3: FAIL')
    PRINT('-----------------------------------------------------------')
END


GO
CREATE OR ALTER PROCEDURE [test].[sp_test_cantidad__igual_0_ret_0]
AS 
BEGIN 
    DECLARE @RET INT = 0
    DECLARE @CADENA VARCHAR(MAX) = ''

    EXEC @RET = [db_utils].[library].[sp_Str_Number_Random] 3, 7, 0, @CADENA OUTPUT 
    PRINT('TEST 4: Cantidad igual 0')
    IF @RET = 0
        PRINT('Esperado: 0 | Devuelto: ' + CAST(@RET AS VARCHAR(MAX)))
    ELSE 
        PRINT('TEST 4: FAIL')
    PRINT('-----------------------------------------------------------')
END 

GO
CREATE OR ALTER PROCEDURE [test].[sp_test_rango_final_menor_0_ret_0]
AS 
BEGIN 
    DECLARE @RET INT = 0
    DECLARE @CADENA VARCHAR(MAX) = ''

    EXEC @RET = [db_utils].[library].[sp_Str_Number_Random] 3, -1, 1, @CADENA OUTPUT 
    PRINT('TEST 5: Rango final menor que cero')
    IF @RET = 0
        PRINT('Esperado: 0 | Devuelto: ' + CAST(@RET AS VARCHAR(MAX)))
    ELSE 
        PRINT('TEST 5: FAIL')
    PRINT('-----------------------------------------------------------')
END 

EXEC [db_utils].[test].[sp_test_rango_inicial_neg_ret_cero]
EXEC [db_utils].[test].[sp_test_rango_inicial_igual_final_cero]
EXEC [db_utils].[test].[sp_test_rango_final_igual_diez_0]
EXEC [db_utils].[test].[sp_test_cantidad__igual_0_ret_0]
EXEC [db_utils].[test].[sp_test_rango_final_menor_0_ret_0]