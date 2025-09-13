USE db_tp_bd_aplicada


DECLARE @CANT_PERSONAS INT = 0 -- 1100 Personas random

DECLARE @NRO_DOC CHAR(8) = '',
        @NOMBRE VARCHAR(30),
        @APELLIDO VARCHAR(30),
        @FNAC DATE

DECLARE @LOC_RAND INT,
        @TIPO_RAND INT,
        @CANT_LOC INT =
        (
            SELECT COUNT(*)
            FROM [db_tp_bd_aplicada].
                [negocio].
                [Localidad]  
        ),
        @CANT_TIPO INT = 
        (
            SELECT COUNT(*)
            FROM [db_tp_bd_aplicada].
                [negocio].
                [Tipo_Doc]  
        )

WHILE @CANT_PERSONAS < 1100
BEGIN 
    DECLARE @NRO_RAND INT
    EXEC @TIPO_RAND = [db_utils].[library].[sp_Str_Number_Random] 1,3,1,NULL
    
    EXEC @LOC_RAND =  
            [db_utils].
            [library].
            [sp_Str_Number_Random] 1, @CANT_LOC, 1, NULL

    EXEC @TIPO_RAND =  
            [db_utils].
            [library].
            [sp_Str_Number_Random] 1, @CANT_TIPO, 1, NULL
    
    EXEC [db_utils].
         [library].
         [sp_Str_letter_Random] 8, 1,@NOMBRE  OUTPUT
    
    EXEC [db_utils].
         [library].
         [sp_Str_letter_Random] 8, 1, @APELLIDO OUTPUT
    
    EXEC [db_tp_bd_aplicada].
         [negocio].
         [sp_Crear_Dni_Aleatorio] @NRO_DOC OUTPUT


    EXEC [db_utils].
         [library].
         [sp_Date_Random] '1980-02-01', @FNAC OUTPUT


    INSERT INTO [db_tp_bd_aplicada].[negocio].[Persona] (IDTipo, NroDoc, Nombre, Apellido, IdLocalidad, FNac)
    VALUES
    (@TIPO_RAND, @NRO_DOC, @NOMBRE, @APELLIDO, @LOC_RAND, @FNAC)

    SET @CANT_PERSONAS = @CANT_PERSONAS + 1
END

--SELECT * FROM negocio.Persona




