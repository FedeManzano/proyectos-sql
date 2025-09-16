USE db_tp_bd_aplicada

GO
CREATE OR ALTER VIEW [negocio].[vw_Cantidad_Inscripciones_Materias_Turno]
AS 
(
    SELECT  COD_MAT,
            ISNULL([TM], 0) AS T_MAÑANA, 
            ISNULL([TT], 0) AS T_TARDE, 
            ISNULL([TN], 0) AS T_NOCHE
    FROM 
    (
        SELECT  COM.NroComision NRO_COM, 
                COM.CodMAteria COD_MAT, 
                COM.Turno TURNO

        FROM        [db_tp_bd_aplicada].
                    [negocio].
                    [Se_Inscribe]       AS INS
        INNER JOIN  [db_tp_bd_aplicada].
                    [negocio].
                    [Comision]          AS COM 

        ON  COM.NroDocDocente  = INS.NroDocDocente  AND 
            COM.TipoDocDocente = INS.TipoDocente    AND 
            COM.CodMAteria     = INS.CodMAteria     AND 
            COM.Cuatrimestre   = INS.Cuatrimestre   AND 
            COM.DiaSemana      = INS.DiaSemana      AND
            COM.AÑO            = INS.AÑO
    ) AS CANT_POR_TURNO
    PIVOT
    (
        SUM(CANT_POR_TURNO.NRO_COM) 
        FOR CANT_POR_TURNO.TURNO IN ([TM],[TT], [TN] )
    ) AS PI
)

GO
SELECT * FROM [negocio].[vw_Cantidad_Inscripciones_Materias_Turno]