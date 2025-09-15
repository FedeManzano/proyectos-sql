
USE db_tp_bd_aplicada

GO
CREATE OR ALTER VIEW [negocio].[vw_Todas_Comisiones]
AS 
(
    SELECT  NroComision AS Nro_Comision, 
        CodMateria AS Cod_materia, 
        CASE TipoDocDocente
            WHEN 1 THEN 'DNI'
            WHEN 2 THEN 'LC'
            WHEN 3 THEN 'CED'
        END AS Tipo_Doc_Docente,
        NroDocDocente AS Nro_Doc_Docente,
        Turno AS Turno,
        CASE Cuatrimestre
            WHEN 1 THEN 'PRIMER CUATRIMESTRE'
            WHEN 2 THEN 'SEGUNDO CUATRIMESTRE'
        END AS NroCuatrimestre,
        CASE DiaSemana
            WHEN 1 THEN 'LUNES'
            WHEN 2 THEN 'MARTES'
            WHEN 3 THEN 'MIERCOLES'
            WHEN 4 THEN 'JUEVES'
            WHEN 5 THEN 'VIERNES'
            WHEN 6 THEN 'SABADO'
            WHEN 7 THEN 'DOMINGO'
        END AS Dia_De_La_Semana,
        Año AS Año_Electivo
    FROM [db_tp_bd_aplicada].[negocio].[Comision]
)

GO
SELECT * FROM negocio.vw_Todas_Comisiones