USE db_tp_bd_aplicada

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
            PARTITION BY    INS.TipoAlumno, 
                            INS.NroDocAlumno, 
                            INS.Cuatrimestre, 
                            INS.Año
        ) AS CANT_INSCRPCIONES_POR_MATERIA
    FROM [negocio].[Se_Inscribe] INS
)


GO
SELECT * FROM negocio.vw_Cantidad_Inscriptos_Materia

