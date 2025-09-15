
USE db_tp_bd_aplicada

GO
CREATE OR ALTER VIEW [negocio].[vw_Comisiones_Asignadas]
AS 
(
    SELECT COM.NroComision Com, DOC.IDTipo Tipo, DOC.NroDoc Dni,DOC.Nombre Nom, DOC.Apellido Ape,
        COUNT(COM.NroComision) OVER (PARTITION BY COM.NroDocDocente) AS Cant_Comisiones_Asignadas  
    FROM 
    [db_tp_bd_aplicada].[negocio].[Comision] COM 
    INNER JOIN
    [db_tp_bd_aplicada].[negocio].[Persona] DOC
    ON  COM.TipoDocDocente = DOC.IDTipo AND 
        COM.NroDocDocente  = DOC.NroDoc
)


GO
SELECT * FROM negocio.vw_Comisiones_Asignadas