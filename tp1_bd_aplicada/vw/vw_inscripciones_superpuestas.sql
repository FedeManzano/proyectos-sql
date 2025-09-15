USE db_tp_bd_aplicada

GO
CREATE OR ALTER VIEW [negocio].[vw_Inscripciones_Superpuestas]
AS 
    (
        SELECT  INS.NroDocAlumno        AS DNI_ALU, 
                INS.DiaSemana           AS DIA, 
                INS.Año                 AS AÑO, 
                COM.Turno               AS TURNO, 
                COUNT(INS.NroComision)  AS CANT_INS
            
            FROM    [db_tp_bd_aplicada].
                    [negocio].
                    [Se_Inscribe]   AS INS 

        INNER JOIN  [db_tp_bd_aplicada].
                    [negocio].
                    [Comision]      AS COM 
        ON      COM.TipoDocDocente = INS.TipoDocente
            AND COM.NroDocDocente  = INS.NroDocDocente
            AND COM.CodMateria     = INS.CodMAteria
            AND COM.Año            = INS.Año
            AND COM.Cuatrimestre   = INS.Cuatrimestre

        GROUP BY    INS.NroDocAlumno, 
                    INS.DiaSemana, 
                    INS.Año, COM.Turno 

        HAVING COUNT(INS.NroComision) > 1
    )

GO
SELECT * FROM [negocio].[vw_Inscripciones_Superpuestas]

GO
WITH Superposicion_Inscripciones (DNI, DIA, AÑO, TURNO, CANT_SUP)
AS 
(
    SELECT      INS.NroDocAlumno        AS DNI_ALU, 
                INS.DiaSemana           AS DIA, 
                INS.Año                 AS AÑO, 
                COM.Turno               AS TURNO, 
                COUNT(INS.NroComision)  OVER
                (
                    PARTITION BY INS.NroDocAlumno, INS.DiaSemana, INS.Año, COM.Turno 
                ) AS CANT_SUP
                
                FROM    [db_tp_bd_aplicada].
                        [negocio].
                        [Se_Inscribe]   AS INS 

            INNER JOIN  [db_tp_bd_aplicada].
                        [negocio].
                        [Comision]      AS COM 
            ON      COM.TipoDocDocente = INS.TipoDocente
                AND COM.NroDocDocente  = INS.NroDocDocente
                AND COM.CodMateria     = INS.CodMAteria
                AND COM.Año            = INS.Año
                AND COM.Cuatrimestre   = INS.Cuatrimestre

)

SELECT*  FROM Superposicion_Inscripciones WHERE CANT_SUP > 1 