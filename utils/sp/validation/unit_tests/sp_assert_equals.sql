USE db_utils 
/**
    Procedimiento almacenado que compara el valor esperado con el obtenido
    Parámetros:
        @NRO_TEST INT: Número del test
        @DESC_TEST NVARCHAR(MAX): Descripción del test
        @ESPERADO INT: Valor esperado
        @OBTENIDO INT: Valor obtenido
    Autor: Federico Manzano
*/
GO
CREATE OR ALTER PROCEDURE [library].[sp_Assert_Equals]
@NRO_TEST                   INT, -- Número del test
@DESC_TEST                  NVARCHAR(MAX), -- Descripción del test
@ESPERADO                   INT, -- Valor esperado
@OBTENIDO                   INT, -- Valor obtenido
@RES                        INT = -1 OUTPUT -- Resultado: 1 si son iguales, 0 si no lo son
AS 
BEGIN

    -- No mostrar mensajes de filas afectadas
    DECLARE @RESULTADO_DESC VARCHAR(18) = ''

    -- Comparar los valores
    IF @ESPERADO = @OBTENIDO
    BEGIN
        -- Mostrar el resultado del test
        EXEC [db_utils].[library].[sp_Show_Result_Test] @NRO_TEST, @DESC_TEST, 1
        SET @RES = 1
    END
    ELSE 
    BEGIN
        EXEC [db_utils].[library].[sp_Show_Result_Test] @NRO_TEST, @DESC_TEST, 0
        SET @RES = 0
    END
    RETURN @RES
END
