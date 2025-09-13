USE db_tp_bd_aplicada -- EJECURAT PRIMERO

/**
    SCRIPT Que crea las tablas y las llena con datos de prueba aleatorios
*/



BEGIN TRY
    BEGIN TRANSACTION 
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Localidad]')
    BEGIN
        CREATE TABLE [db_tp_bd_aplicada].[negocio].[Localidad]
        (
            IDLocalidad INT IDENTITY(1,1) PRIMARY KEY,
            Nombre VARCHAR(30) NOT NULL
        );

        INSERT INTO [db_tp_bd_aplicada].[negocio].[Localidad](Nombre)
        VALUES 
        ('Ramos Mejia'),
        ('Villa Luro'),
        ('Flores'),
        ('Primera Junta'),
        ('Haedo'),
        ('El Palomar'),
        ('Merlo'),
        ('Villa Urquiza')
    END


    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Tipo_Doc]')
    BEGIN
        CREATE TABLE [db_tp_bd_aplicada].[negocio].[Tipo_Doc]
        (
            IDTipo TINYINT PRIMARY KEY,
            Descripcion VARCHAR(3) NOT NULL,
            CONSTRAINT CK_DESC CHECK
            (
                Descripcion LIKE 'DNI' OR 
                Descripcion LIKE 'LC'  OR
                Descripcion LIKE 'CAR'
            ), 
        );

        INSERT INTO [db_tp_bd_aplicada].[negocio].[Tipo_Doc](IDTipo, Descripcion)
        VALUES 
        (1, 'DNI'),
        (2, 'LC'),
        (3, 'CAR')
    END


    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Persona]')
    BEGIN
        CREATE TABLE [db_tp_bd_aplicada].[negocio].[Persona] 
        (
            IDTipo TINYINT NOT NULL,
            NroDoc VARCHAR(8) NOT NULL,
            Nombre VARCHAR(40) NOT NULL,
            Apellido VARCHAR(40) NOT NULL,
            FNac DATE NOT NULL,
            IdLocalidad INT NOT NULL,
            CONSTRAINT PK_Persona PRIMARY KEY(IDTipo, NroDoc),
            CONSTRAINT FK_TIPO FOREIGN KEY(IDTipo) REFERENCES [db_tp_bd_aplicada].[negocio].[Tipo_Doc],
            CONSTRAINT FK_Localidad FOREIGN KEY(IdLocalidad) REFERENCES  [db_tp_bd_aplicada].[negocio].[Localidad]
        );


        
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
                [sp_Date_Random] '1980-02-01', 4, @FNAC OUTPUT


            INSERT INTO [db_tp_bd_aplicada].[negocio].[Persona] (IDTipo, NroDoc, Nombre, Apellido, IdLocalidad, FNac)
            VALUES
            (@TIPO_RAND, @NRO_DOC, @NOMBRE, @APELLIDO, @LOC_RAND, @FNAC)

            SET @CANT_PERSONAS = @CANT_PERSONAS + 1
        END
    END


    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '[db_tp_bd_aplicada].[negocio].[Vehiculo]')
    BEGIN
        CREATE TABLE [db_tp_bd_aplicada].[negocio].[Vehiculo]
        (
            Patente VARCHAR(7) PRIMARY KEY,
            Modelo VARCHAR(30) NOT NULL,
            IDTipo TINYINT NOT NULL,
            NroDoc VARCHAR(8) NOT NULL,
            CONSTRAINT CK_Patente CHECK
            (
                Patente NOT LIKE '[A-Z0-9 ]'
            ),

            CONSTRAINT FK_Persona 
            FOREIGN KEY(IDTipo, NroDoc) REFERENCES 
                            [db_tp_bd_aplicada].
                            [negocio].
                            [Persona](IDTipo,NroDoc)

        );

        DECLARE @PERSONAS TABLE 
        (
            ID INT IDENTITY(1,1) PRIMARY KEY,
            TipoDoc TINYINT NOT NULL,
            NroDoc CHAR(8) NOT NULL
        )

        INSERT INTO @PERSONAS(TipoDoc, NroDoc)
        SELECT IDTipo, NroDoc
        FROM    [db_tp_bd_aplicada].
                [negocio].
                [Persona]

        DECLARE @PATENTE_NUM    CHAR(3),
                @PATENTE_LET    CHAR(3),
                @PATENTE        CHAR(7),
                @MODELO         VARCHAR(30),
                @DNI            VARCHAR(8),
                @TIPO           TINYINT,
                @CANT_VEH       INT = 0,
                @DNI_RAND       INT = 0

        WHILE @CANT_VEH < 300
        BEGIN 
            EXEC    [db_utils].
                    [library].
                    [sp_Str_letter_Random] 3, 1, @PATENTE_LET OUTPUT


            EXEC    [db_utils].
                    [library].
                    [sp_Str_Number_Random] 0,9,3, @PATENTE_NUM OUTPUT

            EXEC    [db_utils].
                    [library].
                    [sp_Str_letter_Random] 8,1, @MODELO OUTPUT
            
            EXEC @DNI_RAND = [db_utils].
                            [library].
                            [sp_Str_Number_Random] 1,9,3, NULL

            

            SET @PATENTE = @PATENTE_LET + ' ' + @PATENTE_NUM

            WHILE EXISTS (SELECT 1 FROM [db_tp_bd_aplicada].[negocio].[Vehiculo] WHERE Patente = @PATENTE)
            BEGIN 
                EXEC    [db_utils].
                        [library].
                        [sp_Str_letter_Random] 3, 1, @PATENTE_LET OUTPUT
                
                EXEC    [db_utils].
                        [library].
                        [sp_Str_Number_Random] 0,9,3, @PATENTE_NUM OUTPUT

                SET @PATENTE = @PATENTE_LET + ' ' + @PATENTE_NUM
            END

            SET @DNI = (SELECT NroDoc FROM @PERSONAS WHERE ID = @DNI_RAND)
            SET @TIPO = (SELECT TipoDoc FROM @PERSONAS WHERE ID = @DNI_RAND)

            INSERT INTO [db_tp_bd_aplicada].
                        [negocio].
                        [Vehiculo]
                        (Patente, Modelo, IDTipo, NroDoc)
            VALUES 
                        (@PATENTE, @MODELO, @TIPO, @DNI)  

            SET @CANT_VEH = @CANT_VEH + 1 
        END

    END
    COMMIT TRANSACTION
END TRY 
BEGIN CATCH
    ROLLBACK TRANSACTION
END CATCH
