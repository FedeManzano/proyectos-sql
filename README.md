
<p align='center'>
    <img src="portada/portada.jpg" 
    style="width: 470px; height: 310px; border-radius: 15px">
</p>

# :red_circle: Proyectos SQL

## Requisitos previos

- SQL Server 2016 o superior (recomendado)
- Permisos para crear bases de datos y objetos (funciones, procedimientos)
- Cliente SQL compatible (SQL Server Management Studio, Azure Data Studio o extensión SQL para VS Code)
- Software [Drawio Oficial](https://www.drawio.com/) para poder abrir los archivos con los diseños.
- Conocimientos básicos de T-SQL

En este repositorio se incluyen ejercicios de SQL junto con un conjunto de dependencias que permiten separar y reutilizar la lógica de funcionalidades comunes a todos los proyectos.
La estructura de cada proyecto está predefinida y puede verse en ```/estructura_basica``` dentro del repositorio. Además, se encuentra :green_book: [db_utils](/utils/) con las dependencias mencionadas. Todos los proyectos dependen de la base de datos generada en este directorio.


## Recursos

- :page_facing_up: [PORTADA](https://www.bairesdev.com/blog/what-is-sql-server/)

## :wrench: Dependencia (db_utils)

### :heavy_plus_sign: Estructura

Para utilizar cualquiera de los proyectos de este repositorio es necesario crear las dependencias que se detallan en la siguiente estructura:

- :green_book: <b>[db_utils](/utils/)</b> (Crear la BD)
    - :open_file_folder: <b>fn</b>
        - :page_facing_up: <i>fn_lados_triangulo.sql</i>
        - :page_facing_up: <i>fn_validate_dni.sql</i>
        - :page_facing_up: <i>fn_validate_email.sql</i>
    - <b>sp</b>
        - :open_file_folder: <b>format</b>
            - :page_facing_up: <i>sp_format_tittle.sql</i> 
        - :open_file_folder: <b>random</b>
            - :page_facing_up: <i>sp_str_letter_random.sql</i> 
            - :page_facing_up: <i>sp_str_number_random.sql</i>
            - :page_facing_up: <i>sp_str_date_random.sql</i>
        - :open_file_folder: <b>validate</b> 
            - :page_facing_up: <i>sp_assert_equals.sql</i>
            - :page_facing_up: <i>sp_exists_element.sql</i>
            - :page_facing_up: <i>sp_validate_cuit.sql</i>


:green_book: [Documentación de dependencias](utils/README.md)


## Proyectos

- :closed_book: [TP1 BD Aplicada](tp1_bd_aplicada)
- :closed_book: [db_alquileres_vehiculos](db_alquileres_vehiculos)

### Autor
[FedeManzano](https://github.com/FedeManzano)

