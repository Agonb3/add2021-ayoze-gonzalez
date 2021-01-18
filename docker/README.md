# DOCKER

*En está práctica trabajaremos con la tecnología "docker", cuya función principal es crear contenedores capaces almacenar y ejecutar archivos y aplicaciones. De está forma es mucho más sencillo migrar todo tipo de aplicaciones y herramientas entre distintas máquinas y plataformas*

## Instalación.

La instalación la realizaremos sobre una máquina con sistema operativo OpenSUSE.  
Ejecutaremos en nuestra terminal **zypper in docker** para instalar la herramienta.

![](./1.JPG)

Una vez instalado, con el comando **systemctl ... docker** activamos el servicio (**start**), le damos orden d ejecutarse al iniciar la máquina (**enable**) y comprobamos el estado actual del servcio (**status**).  
Tambien comprobaremos el estado de *IP_FORWARD* que debe estar activo (**1**)

![](./2.JPG)

## Primeros pasos.

Con el comando **docker version** comprobamos la version de la aplicacion que tenemos instalada.

![](./3.JPG)

Para trabajar con nuestro usuario normal previamente lo incluiremos en el grupo "docker", para que disponga de los privilegios necesarios para ejecutar la herramienta.

![](./4.JPG)

Ahora ejecutamos **docker run hello-world** para descargar la imagen, crear el contenedor y ejecutar la aplicación.  
**(En este punto empezó a darme problemas de privilegios la aplicación)**

![](./5.JPG)

**(A modo de prueba creé un nuevo usuario cuyo grupo principal seía docker, y ejecute de nuevo el comando)**

![](./6.JPG)

**(Al comprobar que funcionaba correctamente, volví a comprobar los grupos de mi usuario principal, cambié al mismo y probé a ejecutar de nuevo el código.)**

![](./8.JPG)

**(Puesto que parecía estar solucionado continue la practica con mi usuario principal.)**

Con el comando **docker images** listaremos las imagenes disponibles.  
Y con **docker ps -a**, vemos que hay un contenedor en estado 'Exited'.

![](./9.JPG)

Con los comandos **docker stop ID_CONTENEDOR** y **docker rm ID_CONTENEDOR** detendremos el contenedor y lo borraremos respectivamente.

![](./10.JPG)

## Creación manual de nuestra imagen.

*Para nuestro primer contenedor usaremos una base "debian".*

Ejecutaremos el comando **docker search debian** para buscar la imagen en los repositorios de docker.

![](./11.JPG)

Con **docker pull debian** descargamos una imagen desde el repositorio.

![](./12.JPG)

Y con **docker images** comprobamos que se ha descargado correctamente.

![](./13.JPG)

Vamos a crear un contenedor con nombre **app1debian** a partir de la imagen debian, y ejecutaremos el programa **/bin/bash** con el siguiente comando.

![](./14.JPG)

Ahora estamos dentro de debian. Vamos a personalizarlo instalando algunos programas.

![](./15.JPG)

![](./16.JPG)

Tambien crearemos un fichero html de la siguiente manera.

![](./17.JPG)

Por último crearemos el script **/root/server.sh** con el siguiente contenido.

![](./18.JPG)

Una vez creado le daremos permisos de ejecución al fichero.

![](./19.JPG)

## Crear una imagen a partir del contenedor.

Para crear nuestra imagen, abrimos otra terminal y ejecutamos el comando **docker commit app1debian ayoze/nginx1**.

**Aquí el servicio volvió a darme problemas de permisos. Realicé varios intentos sin éxito, hasta que reinicie el servicio y aceptó la operación.  
Deduzco que docker necesita reiniciarse cada vez que se apliquen cambios referente a los permisos**

![](./21.JPG)

Comprobamos que nuestra imagen se ha creado correctamente.

![](./22.JPG)

Ahora podremos parar y eliminar nuestro contenedor.

![](./23.JPG)

## Crear contenedor con Nginx.

Ya tenemos una imagen con "nginx" instalado. Ahora crearemos un contenedor a partir de ella, con el siguiente comando.

![](./24.JPG)

Para comprobar qu está en ejecución abrimos una nueva terminal y ejecutamos **docker ps**.

![](./26.JPG)

Ahora comprobamos desde el navegador con la ruta **0.0.0.0:32768** (localhost + el puerto del servicio)

![](./27.JPG)

Por último, probamos la ruta ha nuestro archivo **holamundo1.html**

![](./28.JPG)

## Migrar la imagen a otra máquina

Ahora vamos a intercambiar nuestra imagen con la de un compañero, para crear un contenedor a partir de ella.  
Para ello exportaremos la imagen a un fichero tar.
**docker save -o ayoze07docker.tar ayoze/nginx1** y la enviamos.  
Una vez tengamos la imagen del compañero, nos dirigimos a la carpeta contenedora y ejecutamos **docker load -i nombre-compañeroXXdocker.tar**.

![](./29.JPG)

Con docker images comprobamos que tenemos la imagen.

![](./30.JPG)

Creamos el contenedor con el siguiente comando y, repetimos los pasos del punto anterior para comprobar.

![](./31.JPG)

![](./32.JPG)

![](./33.JPG)

![](./34.JPG)

## Capas.

Las imágenes de docker están creadas a partir de capas que van definidas en el fichero Dockerfile.  
Con el siguiente comando comprobamos las capas de la imagen.

![](./35.JPG)

## Dockerfile.

En este apartado crearemos una imagen a partir de un fichero **Dockerfile**.  
Para ello, crearemos el directorio de proyecto **/home/ayoze/docker07a** donde alojaremos los ficheros. Una vez dentro, crearemos los ficheros **holamundo2.html** y el **Dockerfile** con el contenido de la imagen.

![](./36.JPG)

## Crear imagen a partir del Dockerfile.

Desde el directorio de trabajo con el comando **docker build -t ayoze/nginx2** crearemos nuestra imagen.

![](./37.JPG)

Comprobamos con **docker images**

![](./38.JPG)

## Crear contenedor y comprobar.

A continuación vamos a crear un contenedor con el nombre "app4nginx2", a partir de la imagen "ayoze/nginx2".

![](./39.JPG)

Abrimos otra terminal y comprobamos.

![](./40.JPG)

Ahora desde el navegador.

![](./41.JPG)

![](./42.JPG)

## Usar imagenes ya creadas.

El ejemplo anterior donde creábamos una imagen Docker con Nginx se puede simplificar aún más aprovechando imágenes oficiales que ya existen.  
Como en el apartado anterior, crearemos nuestro directorio de trabajo **docker07b** y dentro los ficheros **holamundo3.html** y **Dockerfile** como se muestra en la imagen.

![](./43.JPG)

Ejecutamos **docker build -t ayoze/nginx3** para crear la imagen y, **docker run --name=app5nginx3 -d -p 8083:80 ayoze/nginx3** para crear el contenedor.

![](./44.JPG)

Comprobamos si podemos acceder al fichero **holamundo3.html** desde el navegador

![](./45.JPG)

## Docker Hub.

Nuestro último proyecto será crear un contenedor llamado **holamundo** y subirlo a los servidores de **DockerHub**.  
Primero crearemos nuestro directori de trabajo **docker07c** y dentro los ficheros **Dockerfile** y **holamundo07.sh** con el siguiente contenido.

![](./60.JPG)

Creamos la imagen con el siguiente comando.

![](./62.JPG)

Y ejecutamos **docker run ayoze/holamundo** para crear el contenedor (Como vemos en la imagen, el script que creamos devuelbe algunos parámetros por pantalla, gracias a la utilidad **echo**).

![](./63.JPG)

Para subir la imagen al servidor previamente debemos registarnos. En mi caso utilizo **agonbe** como usuario. Un acrónimo de mi nombre y apellidos (Ayoze Gonzalez Bello).

![](./64.JPG)

Ahora desde la terminal nos logueamos en el servidor con la id de registro. Y etiquetamos la imagen con la etiqueta **version1**

![](./65.JPG)

Tan solo nos queda subir la imagen al servidor con el siguiente comando.

![](./66.JPG)

## Limpiar contenedores e imágenes.

Ya hemos terminado y toca hacer limpieza.  
Con el comando **docker ps -a** podremos ver las id's de los contenedores.

![](./67.JPG)

Vamos a pararlos y eliminarlos del sistema con los comandos **docker stop id-contenedor** y **docker rm id-contenedor**.

![](./68.JPG)

Haremos lo mismo con las imagenes.  
Comprobamos las id's con **docker images**.

![](./69.JPG)

Y con **docker rmi id-imagen** las eliminamos.

![](./70.JPG)
