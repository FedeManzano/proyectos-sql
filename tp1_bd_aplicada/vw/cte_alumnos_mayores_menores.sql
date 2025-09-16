USE db_tp_bd_aplicada

GO
WITH Personas_Jovenes_Grandes (Tipo, NroDoc, Nombre, Apellido, ACUM_EDADES)
AS 
(
    SELECT  PER.IDTipo, 
            PER.NroDoc, 
            PER.Nombre, 
            PER.Apellido,
        PERCENT_RANK() OVER(ORDER BY PER.FNac) ACUM_EDADES
    FROM [db_tp_bd_aplicada].[negocio].[Persona] AS PER 
)

SELECT  * 
FROM    Personas_Jovenes_Grandes
WHERE   ACUM_EDADES >= 0      AND  ACUM_EDADES <= 0.05 OR 
        ACUM_EDADES >= 0.95   AND  ACUM_EDADES <= 1