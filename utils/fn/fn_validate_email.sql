
USE db_utils 

GO 
CREATE OR ALTER FUNCTION [library].[fn_Validate_Email](@EMAIL VARCHAR(100))
RETURNS TINYINT 
AS 
BEGIN 
    IF  @EMAIL LIKE '%[^a-zA-Z0-9@._-]%' OR  
        @EMAIL LIKE '%@%@%'              OR 
        @EMAIL LIKE '%.@%'               OR 
        @EMAIL LIKE '%@.%'               OR 
        @EMAIL NOT LIKE '%.[A-Za-z0-9-_][A-Za-z0-9-_][A-Za-z0-9-_]'
            RETURN 0
        RETURN 1
END


