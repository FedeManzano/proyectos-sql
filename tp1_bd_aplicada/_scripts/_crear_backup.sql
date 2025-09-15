
USE db_tp_bd_aplicada

DECLARE @PATH_BACK NVARCHAR(MAX) = 'C:\\Users\\feder\\OneDrive\\Documentos\\sql_proyectos\\backup\\' + FORMAT(GETDATE(), 'dd-MM-yyyy', 'es-AR') + '_sqldb_tp_bd_aplicada.bak'
SELECT @PATH_BACK
BACKUP DATABASE [db_tp_bd_aplicada] TO DISK = @PATH_BACK

