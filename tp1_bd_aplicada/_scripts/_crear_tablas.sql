USE db_tp_bd_aplicada 
/*
SCRIPT Que crea las tablas y las llena con datos de prueba aleatorios
Este archivo no sigue las buenas prácticas de programación, es solo para crear
las tablas y cargarlas de información de prueba. 
Las tablas tienen que ser creadas individualmente desde los archivos pertenecientes
al path /tb/ dentro de este proyecto.
*/


IF NOT EXISTS 
(
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA =  'negocio' AND
            TABLE_NAME =    'Localidad'
)
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
END -- Termina la creación de la tabla localidad
ELSE  PRINT('*** La tabla [Localidad] ya existe en la base de datos')

-- TABLA TIPO_DOC ---------------------------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA = 'negocio' AND
            TABLE_NAME   = 'Tipo_Doc'
)
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
    INSERT INTO [db_tp_bd_aplicada].
                [negocio].
                [Tipo_Doc]
                (IDTipo, Descripcion)

    VALUES 
    (1, 'DNI'),
    (2, 'LC'),
    (3, 'CAR')
END -- Termina la creación de la tabla tipo_doc
ELSE  PRINT('*** La tabla [Tipo_Doc] ya existe en la base de datos')

-- TABLA Persona ---------------------------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA = 'negocio' AND 
            TABLE_NAME   = 'Persona'
)
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
    -- Define la cantidad actual de personas procesadas
    DECLARE @CANT_PERSONAS INT = 0 -- 1100 Personas random

    DECLARE @NRO_DOC        CHAR(8) = '',
            @NOMBRE         VARCHAR(30),
            @APELLIDO       VARCHAR(30),
            @FNAC           DATE

    DECLARE @LOC_RAND       INT,  -- Guarda el ID random de localidad (1 - 8)
            @TIPO_RAND      INT, -- Guarda el ID random de tipo_doc (1 - 3)
            
            -- CANTIDAD TOTAL DE LOCALIDADES
            @CANT_LOC       INT =
            (
                SELECT COUNT(*)
                FROM [db_tp_bd_aplicada].
                    [negocio].
                    [Localidad]  
            ),

            -- CANTIDAD TOTAL DE TIPOS DE DOCUMENTO
            @CANT_TIPO INT = 
            (
                SELECT COUNT(*)
                FROM [db_tp_bd_aplicada].
                    [negocio].
                    [Tipo_Doc]  
            )
    WHILE @CANT_PERSONAS < 1100
    BEGIN 
        -- Localidad ID 1 - 8
        EXEC @LOC_RAND =  
                [db_utils].
                [library].
                [sp_Str_Number_Random] 1, @CANT_LOC, 1, NULL
        -- Tipo doc ID 1,2,3            
        EXEC @TIPO_RAND =  
                [db_utils].
                [library].
                [sp_Str_Number_Random] 1, @CANT_TIPO, 1, NULL
        
        -- Genera un nombre aleatorio
        EXEC    [db_utils].
                [library].
                [sp_Str_letter_Random] 8, 1,@NOMBRE  OUTPUT
        
        -- Genera un apellido aleatorio
        EXEC    [db_utils].
                [library].
                [sp_Str_letter_Random] 8, 1, @APELLIDO OUTPUT
        
        -- Genera un DNI aleatorio
        EXEC    [db_tp_bd_aplicada].
                [negocio].
                [sp_Crear_Dni_Aleatorio] @NRO_DOC OUTPUT
        -- Genera un una fecha aleatoria a partir de la fecha 1980-02-01
        EXEC    [db_utils].
                [library].
                [sp_Date_Random] '1980-02-01', 4, @FNAC OUTPUT
    
        -- INSERTA A LA PERSONA
        INSERT INTO [db_tp_bd_aplicada].
                    [negocio].
                    [Persona] 
                    (
                        IDTipo, 
                        NroDoc, 
                        Nombre, 
                        Apellido, 
                        IdLocalidad, 
                        FNac
                    )
                    VALUES
                    (
                        @TIPO_RAND, 
                        @NRO_DOC, 
                        @NOMBRE, 
                        @APELLIDO, 
                        @LOC_RAND, 
                        @FNAC
                    )
    
        -- CONTADOR TERMPORAL DE PERSONAS
        SET @CANT_PERSONAS = @CANT_PERSONAS + 1
    END
END -- FIN INGRESO 1100 Personas -------------------------------------------------------------------
ELSE  PRINT('*** La tabla [Persona] ya existe en la base de datos')

---- TABLA Vehiculo -------------------------------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 

    WHERE   TABLE_SCHEMA = 'negocio' AND
            TABLE_NAME =    'Vehiculo'
)
BEGIN
    /**
        TABLA Vehículos con sus restricciones
    */
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Vehiculo]
    (
        Patente     VARCHAR(7) PRIMARY KEY,
        Modelo      VARCHAR(30) NOT NULL,
        IDTipo      TINYINT NOT NULL,
        NroDoc      VARCHAR(8) NOT NULL,
        -- Restricción de personas, C/ Vehículo es de una persona
        CONSTRAINT FK_Persona 
        FOREIGN KEY(IDTipo, NroDoc) 
        REFERENCES 
                [db_tp_bd_aplicada].
                [negocio].
                [Persona](IDTipo,NroDoc)
    );
    --- Tabla Variable en memoria PERSONAS
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
        EXEC                [db_utils].
                            [library].
                            [sp_Str_letter_Random] 3, 1, @PATENTE_LET OUTPUT
        EXEC                [db_utils].
                            [library].
                            [sp_Str_Number_Random] 0,9,3, @PATENTE_NUM OUTPUT
        EXEC                [db_utils].
                            [library].
                            [sp_Str_letter_Random] 8,1, @MODELO OUTPUT
        
        EXEC @DNI_RAND =    [db_utils].
                            [library].
                            [sp_Str_Number_Random] 1,9,3, NULL
        SET @PATENTE = @PATENTE_LET + ' ' + @PATENTE_NUM
        WHILE EXISTS 
        (
            SELECT  1 
            FROM            [db_tp_bd_aplicada].
                            [negocio].
                            [Vehiculo] 
            WHERE           Patente = @PATENTE
        )
        BEGIN 
            EXEC    [db_utils].
                    [library].
                    [sp_Str_letter_Random] 3, 1, @PATENTE_LET OUTPUT
            
            EXEC    [db_utils].
                    [library].
                    [sp_Str_Number_Random] 0,9,3, @PATENTE_NUM OUTPUT
            SET @PATENTE = @PATENTE_LET + ' ' + @PATENTE_NUM
        END
        SET @DNI = 
        (
            SELECT NroDoc 
            FROM @PERSONAS 
            WHERE ID = @DNI_RAND
        )
        SET @TIPO = 
        (
            SELECT TipoDoc 
            FROM @PERSONAS 
            WHERE ID = @DNI_RAND
        )
        INSERT INTO [db_tp_bd_aplicada].
                    [negocio].
                    [Vehiculo]
                    (Patente, Modelo, IDTipo, NroDoc)
        VALUES 
                    (@PATENTE, @MODELO, @TIPO, @DNI)  
        SET @CANT_VEH = @CANT_VEH + 1 
    END
END
ELSE  PRINT('*** La tabla [Vehiculo] ya existe en la base de datos')


---- TABLA Docente -------------------------------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA = 'negocio' AND
            TABLE_NAME   = 'Docente'
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Docente]
    (
        TipoDoc TINYINT NOT NULL,
        NroDoc VARCHAR(8) NOT NULL,
        Cargo VARCHAR(30) NOT NULL,
        CONSTRAINT PK_Docente PRIMARY KEY
        (
            TipoDoc, 
            NroDoc
        ), 
        CONSTRAINT FK_Persona_Docente FOREIGN KEY
        (
            TipoDoc, 
            NroDoc
        )
        REFERENCES  [db_tp_bd_aplicada].
                    [negocio].
                    [Persona]
                    (
                        IDTipo, 
                        NroDoc
                    )
    )
END 
ELSE  PRINT('*** La tabla [Docente] ya existe en la base de datos')


---- TABLA Alumno -------------------------------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA = 'negocio' AND
            TABLE_NAME = 'Alumno' 
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Alumno]
    (
        TipoDoc TINYINT NOT NULL,
        NroDoc VARCHAR(8) NOT NULL,
        FechaIng DATE NOT NULL,
        CONSTRAINT PK_Alumno PRIMARY KEY(TipoDoc, NroDoc),
        CONSTRAINT FK_Persona_Alumno FOREIGN KEY(TipoDoc, NroDoc) 
        REFERENCES [db_tp_bd_aplicada].[negocio].[Persona](IDTipo, NroDoc)
    )
    DECLARE @TIPO_PERSONA       INT = 0,
            @TIPO_DOC           TINYINT = 0,
            @NRO_DOC_ALUMNO     VARCHAR(8) = '',
            @F_ING              DATE,
            @CANT               INT = 0,
            @CARGO              VARCHAR(30) = ''
    DECLARE ClavesPersona CURSOR FOR
    SELECT NroDoc FROM [negocio].[Persona];
    OPEN ClavesPersona;
    
    FETCH NEXT FROM ClavesPersona INTO @NRO_DOC_ALUMNO;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC @TIPO_PERSONA = [db_utils].[library].[sp_Str_Number_Random] 1,5,1,NULL
        
        SET @TIPO_DOC = 
        (
            SELECT IDTipo 
            FROM    [db_tp_bd_aplicada].
                    [negocio].
                    [Persona] 
            WHERE NroDoc = @NRO_DOC_ALUMNO
        )
        EXEC        [db_utils].
                    [library].
                    [sp_Date_Random] '1990-01-01', 4, @F_ING OUTPUT
        IF   @TIPO_PERSONA = 1  OR
             @TIPO_PERSONA = 2  OR 
             @TIPO_PERSONA = 3
        -- Esto es si es alumno
        BEGIN 
            INSERT INTO [db_tp_bd_aplicada].
                        [negocio].
                        [Alumno] (TipoDoc,NroDoc,FechaIng)
            VALUES(@TIPO_DOC, @NRO_DOC_ALUMNO, @F_ING)
        END -- FIN IF Alumno
        IF   @TIPO_PERSONA = 4
        BEGIN 
            EXEC        [db_utils].
                        [library].
                        [sp_Str_letter_Random] 7, 1, @CARGO OUTPUT 
            INSERT INTO 
                        [db_tp_bd_aplicada].
                        [negocio].
                        [Docente] 
                        (
                            TipoDoc, 
                            NroDoc, 
                            Cargo
                        )
                  VALUES 
                        (
                            @TIPO_DOC, 
                            @NRO_DOC_ALUMNO, 
                            @CARGO
                        )
            INSERT INTO 
                        [db_tp_bd_aplicada].
                        [negocio].
                        [Alumno] (TipoDoc, NroDoc, FechaIng)
            VALUES 
                (@TIPO_DOC, @NRO_DOC_ALUMNO, @F_ING)
        END
        IF @TIPO_PERSONA = 5
        BEGIN 
            EXEC        [db_utils].
                        [library].
                        [sp_Str_letter_Random] 7, 1, @CARGO OUTPUT 
            
            INSERT INTO [db_tp_bd_aplicada].
                        [negocio].
                        [Docente] (TipoDoc, NroDoc, Cargo)
            VALUES 
            (@TIPO_DOC, @NRO_DOC_ALUMNO, @CARGO)
        END
        FETCH NEXT FROM ClavesPersona INTO @NRO_DOC_ALUMNO;
    END
END
ELSE  PRINT('*** La tabla [Alumno] ya existe en la base de datos')

---- TABLA Materia -------------------------------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA = 'negocio' AND
            TABLE_NAME   = 'Materia'
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Materia]
    (
        CodMAteria CHAR(4) PRIMARY KEY,
        Nombre VARCHAR(40) NOT NULL
    )
    INSERT INTO [db_tp_bd_aplicada].[negocio].[Materia](CodMAteria, Nombre)
    VALUES 
    ('2930', 'Sistemas Operativos'),
    ('2931', 'Analisis de Software'),
    ('2932', 'Principios de Calidad'),
    ('2933', 'Bases de Datos'),
    ('2934', 'Analisis Matemático'),
    ('2935', 'Analisis Matemático 2'),
    ('2936', 'Algebra I'),
    ('2937', 'Algebra II'),
    ('2938', 'Algebra III'),
    ('2939', 'Virtualización'),
    ('2940', 'Diseño de Sistemas')
END
ELSE  PRINT('*** La tabla [Materia] ya existe en la base de datos')


---- TABLA Dia_Semana -------------------------------------------------------------------------------------------
IF NOT EXISTS 
(
        SELECT 1 
        FROM INFORMATION_SCHEMA.TABLES

        WHERE   TABLE_SCHEMA    = 'negocio' AND
                TABLE_NAME      = 'Dia_Semana' 
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Dia_Semana]
    (
        CodDia TINYINT IDENTITY(1,1) PRIMARY KEY,
        Nombre VARCHAR(15) NOT NULL 
    )
    INSERT INTO [db_tp_bd_aplicada].[negocio].[Dia_Semana]( Nombre)
    VALUES 
    ('Lunes'),
    ('Martes'),
    ('Miércoles'),
    ('Jueves'),
    ('Viernes'),
    ('Sábado'),
    ('Domingo')
END
---- TABLA Comision -------------------------------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA    = 'negocio' AND
            TABLE_NAME      = 'Comision' 
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Comision]
    (
        TipoDocDocente TINYINT NOT NULL,
        NroDocDocente VARCHAR(8) NOT NULL,
        CodMateria CHAR(4) NOT NULL,
        NroComision INT NOT NULL,
        Turno CHAR(2) NOT NULL,
        Cuatrimestre TINYINT NOT NULL,
        DiaSemana TINYINT NOT NULL,
        Año INT NOT NULL,
        CONSTRAINT PK_Docente_Comision 
            PRIMARY KEY(TipoDocDocente, NroDocDocente, NroComision, CodMAteria, Cuatrimestre, DiaSemana, Año),
        CONSTRAINT FK_Docente_Comision FOREIGN KEY(TipoDocDocente, NroDocDocente) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Docente](TipoDoc, NroDoc),
        CONSTRAINT FK_Materia FOREIGN KEY(CodMateria) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Materia](CodMateria),
        CONSTRAINT FK_DiaSemana FOREIGN KEY(DiaSemana) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Dia_Semana](CodDia)
    )
    
    DECLARE @ENTERO_RANDOM INT = -1
    DECLARE @CANT_COMISIONES INT = 0
    DECLARE @TIPO_DOC_COMISION TINYINT      = 0,
            @NRO_DOC_COMISION  VARCHAR(8)   = '',
            @COD_MAT_COMISION  CHAR(4)      = '',
            @TURNO_COMISION    CHAR(2)      = '',
            @CUAT_COMISION     INT          = 0,
            @D_SEM_COMISION    TINYINT      = 0,
            @ANO_COMISION      INT          = 0

    DECLARE @MATERIAS_COMISION TABLE 
    (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        CodMateria CHAR(4) NOT NULL
    )
    INSERT INTO @MATERIAS_COMISION (CodMateria)
    SELECT CodMateria
    FROM [db_tp_bd_aplicada].[negocio].[Materia]
    
    DECLARE CURSOR_DOCENTES CURSOR FOR
    SELECT NroDoc 
    FROM [db_tp_bd_aplicada].[negocio].[Docente]


    OPEN CURSOR_DOCENTES
    FETCH NEXT FROM CURSOR_DOCENTES INTO @NRO_DOC_COMISION    
   
    WHILE @CANT_COMISIONES < 50 AND @@FETCH_STATUS = 0
    BEGIN 
        
        SET @TIPO_DOC_COMISION = 
        (
            SELECT TOP(1)TipoDoc
            FROM [db_tp_bd_aplicada].[negocio].[Docente]
            WHERE NroDoc = @NRO_DOC_COMISION
        )

        EXEC @ENTERO_RANDOM = [db_utils].[library].[sp_Str_Number_Random] 1,9,2,NULL
        SET @COD_MAT_COMISION = 
        (
            SELECT CodMateria
            FROM @MATERIAS_COMISION
            WHERE ID = (@ENTERO_RANDOM % 11) + 1
        )
         
        
        
        EXEC @ENTERO_RANDOM = [db_utils].[library].[sp_Str_Number_Random] 1,3,1,NULL
        SET @TURNO_COMISION     = [db_tp_bd_aplicada].[negocio].[fn_Selector_Turno](@ENTERO_RANDOM) 
        EXEC @CUAT_COMISION     = [db_utils].[library].[sp_Str_Number_Random] 1,2,1,NULL
        EXEC @D_SEM_COMISION    = [db_utils].[library].[sp_Str_Number_Random] 1,7,1,NULL
        SET @ANO_COMISION       = 2025


        EXEC [db_tp_bd_aplicada].[negocio].[sp_Insertar_Comision] 
        @TIPO_DOC_COMISION,
        @NRO_DOC_COMISION,
        @COD_MAT_COMISION,
        @TURNO_COMISION,
        @CUAT_COMISION,
        @D_SEM_COMISION,
        @ANO_COMISION 

        FETCH NEXT FROM CURSOR_DOCENTES INTO @NRO_DOC_COMISION    
        SET @CANT_COMISIONES = @CANT_COMISIONES + 1
    END
END
ELSE  PRINT('*** La tabla [Comision] ya existe en la base de datos')

---- TABLA Se_Inscribe -------------------------------------------------------------------------------------------
IF NOT EXISTS 
(
    SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE   TABLE_SCHEMA = 'negocio'    AND
            TABLE_NAME   = 'Se_Inscribe' 
)
BEGIN 
    CREATE TABLE [db_tp_bd_aplicada].[negocio].[Se_Inscribe]
    (
        TipoAlumno TINYINT NOT NULL,
        NroDocAlumno VARCHAR(8) NOT NULL,
        TipoDocente TINYINT NOT NULL,
        NroDocDocente VARCHAR(8) NOT NULL,
        NroComision INT NOT NULL,
        CodMAteria CHAR(4) NOT NULL,
        Cuatrimestre TINYINT NOT NULL,
        DiaSemana TINYINT NOT NULL,
        Año INT NOT NULL,
        PRIMARY KEY (TipoAlumno, NroDocAlumno, TipoDocente, NroDocDocente,NroComision, CodMAteria, Cuatrimestre, DiaSemana, Año),
        FOREIGN KEY(TipoAlumno, NroDocAlumno) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Alumno](TipoDoc, NroDoc),
        FOREIGN KEY(TipoDocente, NroDocDocente, NroComision, CodMAteria, Cuatrimestre, DiaSemana, Año) 
            REFERENCES [db_tp_bd_aplicada].[negocio].[Comision] 
        (TipoDocDocente, NroDocDocente, NroComision, CodMateria, Cuatrimestre, DiaSemana, Año)
    )


    DECLARE @RAND_COM INT = -1
    DECLARE @CANT_INS_ALU INT = 0
    DECLARE @TIPO_DOC_ALU INT = 0
    DECLARE @TIPO_DOC_INS TINYINT,
            @NRO_DOC_INS  VARCHAR(8),
            @NRO_COM_INS  INT,
            @COD_MAT_INS  CHAR(4),
            @CUA_INS      TINYINT,
            @DIA_SEM      TINYINT,
            @ANO_INS      INT  
    --EXEC @RAND_COM = [db_utils].[library].[sp_Str_Number_Random] 1,5,2, NULL
    --SELECT @RAND_COM
    DECLARE @COMISIONES TABLE 
    (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        TipoDocDocente TINYINT,
        NroDocDocente VARCHAR(8) NOT NULL,
        NroComision INT NOT NULL,
        CodMAteria CHAR(4) NOT NULL,
        Cuatrimestre TINYINT NOT NULL,
        DiaSemana TINYINT NOT NULL,
        Año INT NOT NULL
    )


    INSERT INTO @COMISIONES (TipoDocDocente, NroDocDocente, NroComision, CodMAteria, Cuatrimestre, DiaSemana, Año)
    SELECT TipoDocDocente, NroDocDocente, NroComision, CodMAteria, Cuatrimestre, DiaSemana, Año
    FROM [db_tp_bd_aplicada].[negocio].[Comision]

    DECLARE @DNI_ALU VARCHAR(8) = ''

    DECLARE CursorAlu CURSOR FOR
    SELECT NroDoc
    FROM [db_tp_bd_aplicada].[negocio].[Alumno]

    OPEN CursorAlu

    FETCH NEXT FROM CursorAlu INTO @DNI_ALU

    WHILE @@FETCH_STATUS = 0
    BEGIN 

        SELECT @TIPO_DOC_ALU = TipoDoc
        FROM [db_tp_bd_aplicada].[negocio].[Alumno]
        WHERE NroDoc = @DNI_ALU

        WHILE @CANT_INS_ALU < 5
        BEGIN 
            EXEC @RAND_COM = [db_utils].[library].[sp_Str_Number_Random] 1,5,2, NULL

            WHILE NOT EXISTS 
            (
                SELECT 1
                FROM @COMISIONES 
                WHERE ID = @RAND_COM
            )
            BEGIN 
                EXEC @RAND_COM = [db_utils].[library].[sp_Str_Number_Random] 1,5,2, NULL
            END
            SELECT  @TIPO_DOC_INS   =     TipoDocDocente,
                    @NRO_DOC_INS    =     NroDocDocente,
                    @NRO_COM_INS    =     NroComision,
                    @COD_MAT_INS    =     CodMateria,
                    @CUA_INS        =     Cuatrimestre,
                    @DIA_SEM        =     DiaSemana,
                    @ANO_INS        =     Año
            FROM @COMISIONES
            WHERE ID = @RAND_COM

            EXEC [db_tp_bd_aplicada].
                 [negocio].
                 [sp_Inscribirse_Materia] 
                        @TIPO_DOC_INS, 
                        @NRO_DOC_INS, 
                        @TIPO_DOC_ALU, 
                        @DNI_ALU,
                        @NRO_COM_INS, 
                        @COD_MAT_INS,
                        @CUA_INS,
                        @DIA_SEM, 
                        @ANO_INS

            SET @CANT_INS_ALU = @CANT_INS_ALU + 1
        END
        SET @CANT_INS_ALU = 0
        FETCH NEXT FROM CursorAlu INTO @DNI_ALU
    END
    CLOSE CursorAlu
END 


/* TEST
SELECT * FROM [db_tp_bd_aplicada].[negocio].[Comision] */