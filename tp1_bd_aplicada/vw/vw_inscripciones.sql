USE db_tp_bd_aplicada

GO
CREATE OR ALTER VIEW [negocio].[vw_Inscripciones]
WITH SCHEMABINDING
AS 
(
    SELECT  INS.NroComision, 
            INS.CodMAteria, 
            MAT.Nombre, 
            CONCAT( CONCAT(ALU.Nombre, ', '), ALU.Apellido) AS 'Nombre, Apellido'
    FROM  
        [db_tp_bd_aplicada].
        [negocio].
        [Se_Inscribe] AS INS 
    INNER JOIN  
        [db_tp_bd_aplicada].
        [negocio].
        [Persona] AS  ALU
                  ON  ALU.IDTipo      =   INS.TipoAlumno      AND 
                      ALU.NroDoc      =   INS.NroDocAlumno 
    INNER JOIN
        [db_tp_bd_aplicada].
        [negocio].
        [Materia] MAT 
                 ON MAT.CodMAteria    =   INS.CodMAteria
)

