
USE db_tp_bd_aplicada

/***
    TEST Unitarios a la función fn_Lados de un triángulo
    Ubicada en [db_utils][library][fn_Lados_fn_Es_Triangulo]
*/

---- TEST(1) 1 2 3 Esperado Escaleno --------------------------------------
-- Predefinido lo que espero que devuelva
DECLARE @RES_ESPERADO INT = 3

-- Lo que obtengo, si es igual a lo que espero TEST OK
DECLARE @RES_OBTENIDO INT = -1

-- Resultado obtenido desde el OUTPUT del [db_utils].[library].[sp_Validate_Test]
DECLARE @RES INT = -1

-- Obtengo el valor obtenido
SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](1,2,3) -- Lo que se quiere probar

-- Muestra y devuelve un valor entero con el rsultado del test
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 1,
            'EsEscaleno_(1)_(2)_(3)', 
            @RES_ESPERADO, 
            @RES_OBTENIDO,
            NULL





---- TEST(2) 1 2 3 Esperado Equilatero --------------------------------------
SET @RES_ESPERADO = 1
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](1,1,1)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 2,'EsEquilatero_(1)_(1)_(1)', @RES_ESPERADO, @RES_OBTENIDO, NULL


---- TEST(3) 1 2 3 Esperado Isosceles --------------------------------------
SET @RES_ESPERADO = 2
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](1,1,2)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 3,'EsIsosceles(1)_(1)_(2)', @RES_ESPERADO, @RES_OBTENIDO, NULL

/*
---- TEST(4) 1 2 3 Esperado Isosceles --------------------------------------
SET @RES_ESPERADO = 2
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](1,1,2)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 4, @RES_ESPERADO, @RES_OBTENIDO, NULL

---- TEST(5) 1 2 3 Esperado Isosceles --------------------------------------
SET @RES_ESPERADO = 2
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO =  [db_utils].[library].[fn_Es_Triangulo](1,2,2)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 5, @RES_ESPERADO, @RES_OBTENIDO, NULL


---- TEST(6) 1 2 3 Esperado Isosceles --------------------------------------
SET @RES_ESPERADO = 2
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](2,2,1)
EXEC @RES = [db_utils].[library].[sp_Validate_Test]  6, @RES_ESPERADO, @RES_OBTENIDO, NULL


---- TEST(7) 1 2 3 Esperado Isosceles --------------------------------------
SET @RES_ESPERADO = 2
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](1,2,1)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 7, @RES_ESPERADO, @RES_OBTENIDO, NULL


---- TEST(8) 1 2 3 Esperado 0 No es triangulo lado negativo --------------------------------------
SET @RES_ESPERADO = 0
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](-1,2,1)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 8, @RES_ESPERADO, @RES_OBTENIDO, NULL


---- TEST(9) 1 2 3 Esperado 0 No es triangulo lado negativo --------------------------------------
SET @RES_ESPERADO = 0
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](2,-1,1)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 9, @RES_ESPERADO, @RES_OBTENIDO, NULL


---- TEST(10) Esperado 0 No es triangulo lado negativo --------------------------------------
SET @RES_ESPERADO = 0
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](2,1,-1)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 10, @RES_ESPERADO, @RES_OBTENIDO, NULL


---- TEST(11) Esperado 0 No es suma de A > A+B NO ES TRIANGULO --------------------------------------
SET @RES_ESPERADO = 0
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](3,1,1)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 11, @RES_ESPERADO, @RES_OBTENIDO, NULL

---- TEST(12) Esperado 0 No es suma de B > A + C NO ES TRIANGULO --------------------------------------
SET @RES_ESPERADO = 0
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](1,3,1)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 12, @RES_ESPERADO, @RES_OBTENIDO, NULL


---- TEST(13) Esperado 0 No es suma de C > A + B NO ES TRIANGULO --------------------------------------
SET @RES_ESPERADO = 0
SET @RES_OBTENIDO = -1
SET @RES = -1

SELECT @RES_OBTENIDO = [db_utils].[library].[fn_Es_Triangulo](1,1,3)
EXEC @RES = [db_utils].[library].[sp_Validate_Test] 13, @RES_ESPERADO, @RES_OBTENIDO, NULL
*/