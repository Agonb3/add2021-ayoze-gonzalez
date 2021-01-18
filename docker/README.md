# DOCKER

*En está práctica trabajaremos con la tecnología "docker", cuya función principal es crear contenedores capaces almacenar y ejecutar archivos y aplicaciones. De está forma es mucho más sencillo migrar todo tipo de aplicaciones y herramientas entre distintas máquinas y plataformas*

## Instalación.

La instalación la realizaremos sobre una máquina con sistema operativo OpenSUSE.  
Ejecutaremos en nuestra terminal **zypper in docker** para instalar la herramienta.

![](./1.jpg)

Una vez instalado, con el comando **systemctl ... docker** activamos el servicio (**start**), le damos orden d ejecutarse al iniciar la máquina (**enable**) y comprobamos el estado actual del servcio (**status**).  
Tambien comprobaremos el estado de *IP_FORWARD* que debe estar activo (**1**)

![](./2.jpg)

## Primeros Pasos.

Con el comando **docker version** comprobamos la version de la aplicacion que tenemos instalada.

![](./3.jpg)

Para trabajar con nuestro usuario normal previamente lo incluiremos en el grupo "docker", para que disponga de los privilegios necesarios para ejecutar la herramienta.

![](./4.jpg)

Ahora ejecutamos **docker run hello-world** para descargar la imagen, crear el contenedor y ejecutar la aplicación.  
**(En este punto empezó a darme problemas de privilegios la aplicación)**

![](./5.jpg)

**(A modo de prueba creé un nuevo usuario cuyo grupo principal seía docker, y ejecute de nuevo el comando)**

![](./6.jpg)

**(Al comprobar que funcionaba correctamente, volví a comprobar los grupos de mi usuario principal, cambié al mismo y probé a ejecutar de nuevo el código.)**

![](./8.jpg)

**(Puesto que parecía estar solucionado continue la practica con mi usuario principal.)**

Con el comando **docker images** listaremos las imagenes disponibles.  
Y con **docker ps -a**, vemos que hay un contenedor en estado 'Exited'.

![](./9.jpg)

Con los comandos **docker stop ID_CONTENEDOR** y **docker rm ID_CONTENEDOR** detendremos el contenedor y lo borraremos respectivamente.

![](./10.jpg)

## Creación Manual de Nuestra Imagen.

*Para nuestro primer contenedor usaremos una base "debian".*

Ejecutaremos el comando **docker search debian** para buscar la imagen en los repositorios de docker.

![](./11.jpg)

Con **docker pull debian** descargamos una imagen desde el repositorio.

![](./12.jpg)

Y con **docker images** comprobamos que se ha descargado correctamente.

![](./13.jpg)

Vamos a crear un contenedor con nombre **app1debian** a partir de la imagen debian, y ejecutaremos el programa **/bin/bash** con el siguiente comando.

![](./14.jpg)

Ahora estamos dentro de debian. Vamos a personalizarlo instalando algunos programas.

![](./15.jpg)

![](./16.jpg)

Tambien crearemos un fichero html de la siguiente manera.

![](./17.jpg)

Por último crearemos el script **/root/server.sh** con el siguiente contenido.

![](./18.jpg)

Una vez creado le daremos permisos de ejecución al fichero.

![](./19.jpg)

## Crear una Imagen a Partir del Contenedor.

Para crear nuestra imagen, abrimos otra terminal y ejecutamos el comando **docker commit app1debian ayoze/nginx1**.

**Aquí el servicio volvió a darme problemas de permisos. Realicé varios intentos sin éxito, hasta que reinicie el servicio y aceptó la operación.  
Deduzco que docker necesita reiniciarse cada vez que se apliquen cambios referente a los permisos**

![](./21.jpg)

Comprobamos que nuestra imagen se ha creado correctamente.

![](./22.jpg)

Ahora podremos parar y eliminar nuestro contenedor.

![](./23.jpg)

## Crear Contenedor con Nginx.

Ya tenemos una imagen con "nginx" instalado. Ahora crearemos un contenedor a partir de ella, con el siguiente comando.

![](./24.jpg)

Para comprobar qu está en ejecución abrimos una nueva terminal y ejecutamos **docker ps**.

![](./26.jpg)

Ahora comprobamos desde el navegador con la ruta **0.0.0.0:32768** (localhost + el puerto del servicio)

![](./27.jpg)

Por último, probamos la ruta ha nuestro archivo **holamundo1.html**

![](./28.jpg)

## Migrar la imagen a otra máquina

Ahora vamos a intercambiar nuestra imagen con la de un compañero, para crear un contenedor a partir de ella.  
Para ello exportaremos la imagen a un fichero tar.
**docker save -o ayoze07docker.tar ayoze/nginx1** y la enviamos.  
Una vez tengamos la imagen del compañero, nos dirigimos a la carpeta contenedora y ejecutamos **docker load -i nombre-compañeroXXdocker.tar**.

![](./29.jpg)

Con docker images comprobamos que tenemos la imagen.

![](./30.jpg)

Creamos el contenedor con el siguiente comando y, repetimos los pasos del punto anterior para comprobar.

![](./31.jpg)

![](./32.jpg)

![](./33.jpg)

![](./34.jpg)

## Capas.

Las imágenes de docker están creadas a partir de capas que van definidas en el fichero Dockerfile.  
Con el siguiente comando comprobamos las capas de la imagen.

![](./35.jpg)

## Dockerfile.
