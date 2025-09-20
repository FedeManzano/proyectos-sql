# :red_circle: Proyectos SQL

En este repositorio se agregaron algunos ejercicios de SQL junto con un conjunto de dependencias las cuales permiten separar y reutilizar la lógica de las funcionalidades comunes a todos los proyectos.
La estructura de cada proyecto está predefinida y se pude ver en ```/estructura_basica``` dentro  del repositorio, a su vez también se encuentra ```/db_utils``` con las dependencias antes mencionadas. Todos lo proyectos dependen de la Base de Datos generada en este directorio del proyecto.

## :wrench: Dependencia (db_utils)

### :heavy_plus_sign: Estructura

- <b>:file_folder: utils</b>
    * <b>:open_file_folder: fn</b>
        * <i>:page_facing_up: fn_lados_triangulo.sql (Utilizado para test)</i>
        * <i>:page_facing_up: fn_validate_dni.sql</i>
        * <i>:page_facing_up: fn_validate_email.sql</i>
     * <b>:open_file_folder: sp</b>
        * <b>:open_file_folder: format</b>
            * <i>:page_facing_up: sp_format_tittle.sql</i>
        * <b>:open_file_folder: random</b>
            * <i>:page_facing_up: sp_date_random.sql</i>
            * <i>:page_facing_up: sp_str_letter_random.sql</i>
            * <i>:page_facing_up: sp_str_number_random.sql</i>
        * <b>:open_file_folder: validation</b>
            * <i>:page_facing_up: sp_assert_equals.sql</i>

:green-book:[Documetación Dependencias](utils/README.md)




### Autor
[FedeManzano](https://github.com/FedeManzano)

