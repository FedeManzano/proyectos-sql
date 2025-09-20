
USE db_utils 

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


