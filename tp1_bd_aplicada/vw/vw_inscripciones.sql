USE db_tp_bd_aplicada

GO
CREATE OR ALTER VIEW [negocio].[vw_Inscripciones]
WITH SCHEMABINDING
AS 
(
    SELECT  INS.NroComision AS NroCom, 
            INS.CodMAteria AS Cod_Mat, 
            MAT.Nombre AS Nom_Mat, 
            CONCAT( CONCAT(ALU.Nombre, ', '), ALU.Apellido) AS 'Nombre, Apellido'

    FROM  
        [negocio].
        [Se_Inscribe] AS INS 

    INNER JOIN  
        [negocio].
        [Persona] AS  ALU

    ON  ALU.IDTipo      =   INS.TipoAlumno      AND 
        ALU.NroDoc      =   INS.NroDocAlumno 
    
    INNER JOIN
        [negocio].
        [Materia] MAT

    ON MAT.CodMAteria    =   INS.CodMAteria
)

GO
SELECT * FROM [negocio].[vw_Inscripciones]
