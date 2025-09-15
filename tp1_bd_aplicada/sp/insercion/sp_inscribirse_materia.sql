
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
    IF NOT EXISTS 
    (
        SELECT 1
        FROM [db_tp_bd_aplicada].[negocio].[Comision]
        WHERE @TIPO_DOC     = TipoDocDocente    AND 
              @DNI_DOC      = NroDocDocente     AND 
              @NRO_COM      = NroComision       AND 
              @COD_MAT      = CodMateria        AND 
              @CUATRIMESTRE = Cuatrimestre      AND 
              @D_SEM        = DiaSemana         AND 
              @ANO          = Año
    )
    BEGIN 
        PRINT('La comisión a la que se quiere anotar no existe dentro')
        RETURN 0 -- La comisión no existe
    END 
        

    IF EXISTS 
    (
        SELECT 1
        FROM [db_tp_bd_aplicada].[negocio].[Se_Inscribe]
        WHERE @TIPO_DOC     = TipoDocente    AND 
              @DNI_DOC      = NroDocDocente     AND 
              @NRO_COM      = NroComision       AND 
              @COD_MAT      = CodMAteria        AND 
              @CUATRIMESTRE = Cuatrimestre      AND 
              @D_SEM        = DiaSemana         AND 
              @ANO          = Año               AND 
              @TIPO_ALU     = TipoAlumno        AND 
              @DNI_ALU      = NroDocAlumno      
    )
    BEGIN 
        PRINT('Usted ya fué inscripto a esta comisión, no puede volverse a anotar')
        RETURN 2 -- Ya está anotado a esta comisión
    END
        

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
    RETURN 1
END

SELECT * FROM negocio.Se_Inscribe

DECLARE @RES INT = 0
EXEC @RES = [db_tp_bd_aplicada].[negocio].[sp_Inscribirse_Materia] 1,'13028164',1, '11618387', 4, '2930', 1, 4, 2025
SELECT @RES

