USE db_tp_bd_aplicada


--- PRO VENTANA
GO
CREATE OR ALTER VIEW [negocio].[vw_Cantidad_Inscriptos_Materia]
AS 
(
    SELECT  INS.TipoAlumno      AS TIPO_ALU, 
            INS.NroDocAlumno    AS DNI_ALU,  
            INS.CodMAteria      AS COD_MAT,
            INS.Cuatrimestre    AS CUATRIMESTRE, 
            INS.Año             AS AÑO,
        COUNT(INS.CodMAteria) OVER
        (
            PARTITION BY    INS.CodMAteria
        ) AS CANT_INSCRPCIONES_POR_MATERIA
    FROM [negocio].[Se_Inscribe] INS
)


GO
SELECT * FROM negocio.vw_Cantidad_Inscriptos_Materia


-- POR AGREGACIÓN

WITH Cantidad_Inscripciones_Materia (COD_MAT, CANTIDAD_ALU) 
AS 
    (
         SELECT INS.CodMAteria      AS COD_MAT, 
                COUNT(*)            AS CANTIDAD_ALU
        FROM [negocio].[Se_Inscribe] INS
        GROUP BY INS.CodMAteria 
    )

SELECT * FROM Cantidad_Inscripciones_Materia