
USE db_utils 

/***
	Función para validar el correo electrónico 
	- Si el valor devuelto es 1 -> el correo es válido
	- Si el valor devuelto es 0 -> el correo es inválido
*/
GO 
CREATE OR ALTER FUNCTION [library].[fn_Validate_Email](@EMAIL VARCHAR(MAX))
RETURNS TINYINT 
AS 
BEGIN 
    IF	  @EMAIL LIKE		'%@%.%'
	  AND @EMAIL NOT LIKE	'-%'
	  AND @EMAIL NOT LIKE	'% %'
	  AND @EMAIL NOT LIKE	'%[^a-zA-Z0-9@._-]%'
	  AND @EMAIL NOT LIKE	'%@%@%'
	  AND @EMAIL NOT LIKE	'%@.%'
	  AND @EMAIL NOT LIKE	'.%'
	  AND @EMAIL NOT LIKE	'%.'
	  AND @EMAIL LIKE		'%@%'
	  AND @EMAIL LIKE		'%.%'
	  AND LEN(@EMAIL) >= 6
	  RETURN 1
        RETURN 0
END


