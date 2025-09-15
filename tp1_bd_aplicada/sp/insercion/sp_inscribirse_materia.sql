
USE db_tp_bd_aplicada

GO
CREATE OR ALTER PROCEDURE [negocio].[sp_Inscribirse_Materia] 
@TIPO_DOC          TINYINT,
@DNI_DOC           CHAR(8),
@TIPO_ALU          TINYINT,
@DNI_ALU           CHAR(8),
@NRO_COM           INT,
@COD_MAT           CHAR(4),
@CUATRIMESTRE      INT,
@D_SEM             TINYINT,
@ANO               INT 
AS 
BEGIN 

    BEGIN TRANSACTION 
    BEGIN TRY 
        IF NOT EXISTS 
        (
            SELECT 1
            FROM [db_tp_bd_aplicada].[negocio].[Comision]
            WHERE @TIPO_DOC      =   TipoDocDocente    AND 
                @DNI_DOC         =   NroDocDocente     AND 
                @NRO_COM         =   NroComision       AND 
                @COD_MAT         =   CodMateria        AND 
                @CUATRIMESTRE    =   Cuatrimestre      AND 
                @D_SEM           =   DiaSemana         AND 
                @ANO             =   Año
        )
            RAISERROR('La comisión no existe en la base de datos', 21, 1)
            

        IF EXISTS 
        (
            SELECT 1
            FROM [db_tp_bd_aplicada].[negocio].[Se_Inscribe]
            WHERE @TIPO_DOC      =    TipoDocente      AND 
                @DNI_DOC         =    NroDocDocente    AND 
                @NRO_COM         =    NroComision      AND 
                @COD_MAT         =    CodMAteria       AND 
                @CUATRIMESTRE    =    Cuatrimestre     AND 
                @D_SEM           =    DiaSemana        AND 
                @ANO             =    Año              AND 
                @TIPO_ALU        =    TipoAlumno       AND 
                @DNI_ALU         =    NroDocAlumno      
        )
            RAISERROR('Usted ya está anotado a esta comisión', 21, 1)
            

        INSERT INTO [db_tp_bd_aplicada].[negocio].[Se_Inscribe]    
            (TipoDocente, NroDocDocente, TipoAlumno, NroDocAlumno, NroComision, CodMAteria, Cuatrimestre, DiaSemana, Año)
        VALUES 
        (
            @TIPO_DOC,
            @DNI_DOC,
            @TIPO_ALU,
            @DNI_ALU,
            @NRO_COM,
            @COD_MAT,
            @CUATRIMESTRE,
            @D_SEM,
            @ANO
        )
        COMMIT TRANSACTION
    END TRY 
    BEGIN CATCH
        DECLARE @MJE_ERROR NVARCHAR(2000),
                @SEVERIDAD INT, 
                @ESTADO INT 

        SELECT  @MJE_ERROR = ERROR_MESSAGE(),
                @SEVERIDAD = ERROR_SEVERITY(),
                @ESTADO    = ERROR_STATE() 

        RAISERROR(@MJE_ERROR, @SEVERIDAD, @ESTADO)

        ROLLBACK TRANSACTION
    END CATCH
END


