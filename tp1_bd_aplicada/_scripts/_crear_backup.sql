
USE db_tp_bd_aplicada


-- PATH ABSOLUTO DEL ARCHIVO
DECLARE @PATH NVARCHAR(MAX)   = 'C:\\Users\\feder\\OneDrive\\Documentos\\sql_proyectos\\backup\\'

-- NOMBRE DEL ARCHIVO
DECLARE @N_ARCH NVARCHAR(MAX) = FORMAT(GETDATE(), 'dd-MM-yyyy', 'es-AR') + '_sqldb_tp_bd_aplicada.bak'

-- PATH ABS + NOMBRE_ARCH
DECLARE @PATH_BACK NVARCHAR(MAX) = @PATH + @N_ARCH

-- Generar el BACKUP
BACKUP DATABASE [db_tp_bd_aplicada] TO DISK = @PATH_BACK

