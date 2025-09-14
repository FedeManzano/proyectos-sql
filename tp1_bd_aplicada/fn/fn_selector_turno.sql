
USE db_tp_bd_aplicada 

GO
CREATE OR ALTER FUNCTION [negocio].[fn_Selector_Turno](@TURNO_INT INT)
RETURNS CHAR(2)
AS 
BEGIN 
    RETURN 
    (
        SELECT 
            CASE @TURNO_INT
                WHEN 1 THEN 'TM'
                WHEN 2 THEN 'TT'
                WHEN 3 THEN 'TN'
                ELSE NULL
            END
    )
END


