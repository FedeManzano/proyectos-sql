USE db_utils
/**
    Procedimiento almacenado para generar un cuit válido
    EJ 
    DECLARE @C VARCHAR(MAX) = ''
    EXEC [db_utils].[library].[sp_Gen_Valid_CUIT] 0, @C OUTPUT 
    SELECT @C
*/
GO
CREATE OR ALTER PROCEDURE [library].[sp_Gen_Valid_CUIT]
    @FORMATO    INT = 0,  -- CON GUIONES 1 / 0 SIN GUIONES
    @CUIT       VARCHAR(MAX) = '' OUTPUT -- SALIDA CUIT RANDOM
AS
BEGIN
    -- No mostrar mensajes de filas afectadas
    SET NOCOUNT ON

    -- Declaración de variables --------------------------------
    DECLARE @DNI                VARCHAR(15)     = ''
    DECLARE @PREFIX_RANDOM      INT             = 0
    DECLARE @PREFIJO            VARCHAR(2)      = ''
    DECLARE @CUIT_SIN_DV        VARCHAR(13)     = ''

    DECLARE @CANT_NUM           INT             = 0
    DECLARE @COHEF_ACTUAL       INT             = 0
    DECLARE @SUM                INT             = 0
    DECLARE @CAR_ACTUAL         CHAR(1)         = ''
    DECLARE @RES                INT             = 0 
    -- ---------------------------------------------------------


    -- Tabla temporal para los prefijos válidos
    DECLARE @PREFIJOS TABLE 
    (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Prefijo VARCHAR(2) NOT NULL
    )

    -- Insertar los prefijos válidos en la tabla temporal
    INSERT INTO @PREFIJOS   
    (   Prefijo  ) VALUES
    (   '20'     ),
    (   '23'     ),
    (   '24'     ),
    (   '25'     ),
    (   '26'     ),
    (   '27'     )

    -- Tabla temporal para los coeficientes usados en el cálculo del dígito verificador
    DECLARE @COHEFICIENTES TABLE 
    (
        Cohef INT NOT NULL
    )

    -- Insertar los coeficientes en la tabla temporal
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

    -- Generar un DNI válido utilizando el procedimiento almacenado existente
    EXEC [db_utils].[library].[sp_Generate_Valid_DNI] @DNI OUTPUT


    -- Seleccionar un prefijo aleatorio de la tabla de prefijos
    SET @PREFIX_RANDOM  = ( RAND() * 6 ) + 1
    
    -- Obtener el prefijo correspondiente al número aleatorio generado
    SET @PREFIJO = 
    (
        SELECT Prefijo 
        FROM @PREFIJOS 
        WHERE ID = @PREFIX_RANDOM
    )

    -- Concatenar el prefijo y el DNI para formar el CUIT sin el dígito verificador

    IF @FORMATO = 1
        SET @CUIT_SIN_DV = @PREFIJO + '-' +  @DNI    
    ELSE 
        SET @CUIT_SIN_DV = @PREFIJO +  @DNI    

    -- Calcular el dígito verificador
    DECLARE CursorCohef CURSOR FOR
    SELECT Cohef FROM @COHEFICIENTES

    -- Abrir el cursor
    OPEN CursorCohef
    
    -- Inicializar variables para el cálculo
    FETCH NEXT FROM CursorCohef INTO @COHEF_ACTUAL
    WHILE @@FETCH_STATUS = 0    
    BEGIN
        -- Obtener el carácter actual del CUIT sin dígito verificador
        SET @CAR_ACTUAL = SUBSTRING(@CUIT_SIN_DV, @CANT_NUM + 1, 1)

        -- Obtener el coeficiente actual    
        SET @COHEF_ACTUAL = 
        ( 
            SELECT TOP(1) Cohef 
            FROM @COHEFICIENTES
        )
        
        -- Acumular la suma ponderada
        SET @SUM = @SUM + (CAST(@CAR_ACTUAL AS INT) * @COHEF_ACTUAL)

        -- Incrementar el contador de números procesados
        SET @CANT_NUM = @CANT_NUM + 1

        -- Mover al siguiente coeficiente
        FETCH NEXT FROM CursorCohef INTO @COHEF_ACTUAL      
    END
    
    -- Cerrar y liberar el cursor
    CLOSE CursorCohef

    -- Liberar el cursor
    DEALLOCATE CursorCohef

    -- Calcular el dígito verificador y formar el CUIT completo
    SET @RES    = @SUM % 11

    -- Ajustar el dígito verificador según las reglas específicas
    SET @CUIT   = 11 - @RES    

    -- Si el resultado es 11, el dígito verificador es 0
    IF @FORMATO = 1
        SET @CUIT   = @CUIT_SIN_DV + '-' +CAST(@RES AS VARCHAR(1))
    ELSE 
        SET @CUIT   = @CUIT_SIN_DV + CAST(@RES AS VARCHAR(1))
    RETURN 1 -- Termina el procedimiento
END

