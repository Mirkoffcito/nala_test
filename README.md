# Test Backend para NALA

### URL de la google sheet utilizada: 
* https://docs.google.com/spreadsheets/d/17c1eWA8nwZJNR1Kk-4a_WDwjCkKpGXai9Sj7Qh42Wik/edit?usp=sharing
### URL de la aplicación en heroku:
* https://test-nala.herokuapp.com


### Al utilizar la aplicación por primera vez, en consola se debe ejecutar el comando  ```Fetcher.fetch```

Nuestra tabla de google sheet contiene la información de las vacaciones de los empleados de una empresa(Nombre y apellido del empleado, fecha de inicio de las vacaciones y fecha de fin). 

Asumimos que cada FILA corresponde a un único registro de vacaciones, que a su vez pertenece a un único empleado. 
Esto significa que NO habrán dos registros de vacaciones para un mismo empleado en la tabla inicial(ya que nombre y apellido no son óptimos para distinguir a los usuarios a nivel base de datos). Una vez que empecemos a crear nuevos registros de vacaciones desde la API, un empleado SI podrá tener más de un registro de vacaciones en la tabla.

El comando ```Fetcher.fetch``` poblará la base de datos con toda la información de la GSheet, cada FILA será un nuevo registro. (Un registro de empleado y un registro de vacaciones que le corresponderá).

## Endpoints

### Autenticación
#### Todos los endpoints, exceptuando los de registro y login, requieren de autenticación. La autenticación se realiza enviando el parametro 'Authorization' con el token de acceso vía headers. Si el usuario no está autenticado, recibirá un mensaje de error y un código de error 401.
* **REGISTRO DE USUARIO**: https://test-nala.herokuapp.com/api/auth/register
  - Recibe como parametros *email*, *password* y *password_confirmation*
  - Devuelve el email del usuario y un TOKEN de acceso.

* **LOGIN DE USUARIO**: https://test-nala.herokuapp.com/api/auth/register
  - Recibe como parametros *email*, *password*
  - Devuelve el email del usuario y un TOKEN de acceso.

### Vacaciones

* **INDEX VACACIONES**: GET https://test-nala.herokuapp.com/api/vacations
  - Devuelve todos los registros de vacaciones, con su fecha de inicio, fecha de fin, cantidad total de días de vacaciones, su estado(pendiente, finalizada, o en curso) y el usuario al que pertenece.

* **INDEX VACACIONES DE EMPLEADO ESPECIFICO**: GET https://test-nala.herokuapp.com/api/employees/:employee_id/vacations
  - Devuelve todos los registros de vacaciones del usuario especifico, con su fecha de inicio, fecha de fin, cantidad total de días de vacaciones, su estado(pendiente, finalizada, o en curso) y el usuario al que pertenece.
  - Si el usuario no existe, devuelve un error 404 y un mensaje de error

* **SHOW VACACION**: GET https://test-nala.herokuapp.com/api/vacations/:vacation_id
  - Devuelve un registro especifico de vacaciones, mostrando su fecha de inicio, fecha de fin, cantidad total de días de vacaciones, su estado(pendiente, finalizada, o en curso) y el usuario al que pertenece.
  - Si el registro no existe, devuelve un error 404 y un mensaje de error.

* **SHOW VACACION DE EMPLEADO ESPECIFICO**: GET https://test-nala.herokuapp.com/api/employees/:employee_id/vacations/:vacation_id
  - Devuelve un registro especifico de vacaciones perteneciente a un usuario, mostrando su fecha de inicio, fecha de fin, cantidad total de días de vacaciones, su estado(pendiente, finalizada, o en curso) y el usuario al que pertenece.
  - Si el registro no existe o no pertenece al empleado especifico, devuelve un error 404 y un mensaje de error.
  - Si el empleado no existe, devuelve un error 404 y un mensaje de error

* **DELETE VACACION**: DELETE https://test-nala.herokuapp.com/api/vacations/:vacation_id
  - Elimina un registro de vacaciones de la base de datos.

* **DELETE VACACION DE EMPLEADO ESPECIFICO**: DELETE https://test-nala.herokuapp.com/api/employees/:employee_id/vacations/:vacation_id
  - Elimina un registro de vacaciones de la base de datos.
  - Si el registro no existe o no pertenece al empleado especifico, devuelve un error 404 y un mensaje de error.
  - Si el empleado no existe, devuelve un error 404 y un mensaje de error.

* **CREAR VACACION**: POST https://test-nala.herokuapp.com/api/employees/:employee_id/vacations
  - Recibe como parametros fecha de inicio(started_at) y fecha de fin(finished_at).
  - Crea un registro de vacación perteneciente al usuario del ID del url(:employee_id)
  - Agrega una nueva Fila a la tabla de Google sheets de Vacaciones.
  - Si el empleado no existe, devuelve un error 404 y un mensaje de error.

* **ACTUALIZAR VACACION**: PATCH https://test-nala.herokuapp.com/api/employees/:employee_id/vacations/:vacation_id
  - Recibe como parametros fecha de inicio(started_at) y/o fecha de fin(finished_at).
  - Dependiendo de las nuevas fechas, el estado de la vacación podrá cambiar (por ejemplo, si la vacación está en curso y se actualiza la fecha finished_at al día actual, el estado de la vacación pasará a ser 'finished'.)
  - Si el empleado o la vacación de la URL no existen, devolverá un error 404 y un mensaje de error.

### Empleados

* **INDEX EMPLEADOS**: GET https://test-nala.herokuapp.com/api/employees
  - Devuelve una lista de todos los empleados, detallando su nombre, apellido y si están de vacaciones actualmente (true si esta de vacaciones, falso en caso contrario.)

* **SHOW EMPLEADO**: GET https://test-nala.herokuapp.com/api/employees/:employee_id
  - Devuelve un empleado especifico, detallando su nombre, apellido y si está de vacaciones actualmente.

* **CREAR EMPLEADO**: POST https://test-nala.herokuapp.com/api/employees
  - Recibe como parametros first_name, last_name.
  - Devuelve el empleado creado.

* **DELETE EMPLEADO**: DELETE https://test-nala.herokuapp.com/api/employees/:employee_id
  - Elimina el usuario especifico y todos sus registros de vacaciones de la base de datos.
  - En caso de no existir el usuario, devuelve un error 404 y un mensaje de error.

* **UPDATE EMPLEADO**: PATCH https://test-nala.herokuapp.com/api/employees/:employee_id
  - Recibe como parametros first_name y/o last_name. Actualiza la información del empleado.
  - En caso de no existir el usuario, devuelve un error 404 y un mensaje de error.

### Imágenes del funcionamiento de la API.

*Creacion de un empleado*

![Creacion empleado](https://user-images.githubusercontent.com/81385234/128618999-27864862-3936-42d4-be31-e8d69b8568e5.jpg)

*Creación de un registro de vacaciones de un empleado*

![creacion vacacion empleado 13](https://user-images.githubusercontent.com/81385234/128619008-c3cb7698-352e-4f24-b7f3-f956052a6433.jpg)

*Request cuando un empleado no existe*

![empleado no existe](https://user-images.githubusercontent.com/81385234/128619014-25ee8295-4c13-4c0f-8f9a-f1f3e5961d0d.jpg)

*Index de vacaciones*

![GET vacations](https://user-images.githubusercontent.com/81385234/128619019-3bde5eb4-6b63-4807-a1c8-46207dc19c29.jpg)

*Registro de un usuario*

![registro](https://user-images.githubusercontent.com/81385234/128619047-42a5c57e-108a-4b4e-9a0c-14d71cd1f51b.jpg)

*Login de un usuario*

![login](https://user-images.githubusercontent.com/81385234/128619055-db0ef692-10cf-427c-8975-cc57630ae427.jpg)

*Request sin token de autorización*

![request sin token](https://user-images.githubusercontent.com/81385234/128619062-e38252fb-96f4-4b41-93e7-2f89b8ad2a35.jpg)

*Request con token de autorización*

![Request con token de autorizacion](https://user-images.githubusercontent.com/81385234/128619070-2079edb4-e085-4614-ba63-e9e1bf61defa.jpg)


**Además, antes de cada request, el código se encarga de checkear que el estado actual de las vacaciones sea correcto. Ya que por ejemplo podría pasar que las vacaciones que se agregaron hace una semana, cuyo estado es pending(pendientes), inicien en la semana actual, por lo cual su estado debe pasar a 'currently'(en curso). O también podría pasar que las vacaciones de algún empleado hayan finalizado, por lo cual su estado debe cambiar a 'finished'.**

## Filtros de busqueda de vacaciones (INDEX)

### ?by_state

* **/api/vacations?by_state=finished**: Devuelve todos los registros de vacaciones cuyo estado es 'finalizado'.

* **/api/vacations?by_state=currently**: Devuelve todos los registros de vacaciones cuyo estado es 'en curso'.

* **/api/vacations?by_state=pending**: Devuelve todos los registros de vacaciones cuyo estado es 'pendiente'.

### ?by_start_date

* **/api/vacations?by_start_date[from]=AAAA-MM-DD&by_start_date[to]=AAAA-MM-DD**: Devuelve todos los registros de vacaciones que INICIAN entre dos fechas dadas.

### ?by_finish_date

* **/api/vacations?by_finish_date[from]=AAAA-MM-DD&by_start_date[to]=AAAA-MM-DD**: Devuelve todos los registros de vacaciones que FINALIZAN entre dos fechas dadas.

## PAGINACIÓN

Para la paginación utilicé la gema 'pager_api' en combinación con la gema 'pagy'. Son muy sencillas de utilizar y nos brindan toda la información que podemos necesitar de una paginación.

![paginación](https://user-images.githubusercontent.com/81385234/128636716-68666912-98ef-44cd-b6e9-f3afadaa9062.jpg)








