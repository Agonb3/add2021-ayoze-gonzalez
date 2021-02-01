# Salt-Stack

Está herramienta se encuentra dentro del grupo de gestores de infraestructura, cuya principal funcionalidad es, automatizar ordenes para que los hosts esclavos (**minions**) del sistema anfitrión puedan descargar dichas ordenes automáticamente al conectarse al nfitrión (**master**).

## Configuraciones previas

**NOTA**  
*Es importanrte que se establezcan nombres e ip's estáticas a las máquinas antes de comenzar la instalación de la herramienta, puesto que se crean conexiones entre el master y los minions basadas en esos parámetros.*

- Para está práctica utilizaremos 2 máquinas con SO OpenSUSE con los siguientes parámetros.

  *Master*
  Nombre- master07g
  Alias- master
  Ip- 172.19.7.31 / 192.168.1.31

![](./1.JPG)

  *Minion*
  Nombre- minion07g
  Alias- minion
  Ip- 172.19.7.32 /192.168.1.32

![](./2.JPG)

## Master.

- Una vez configuradas las máquinas instalaremos la herramienta en el master con **zypper install salt-master**

![](./3.JPG)

- Ahora modificaremos el archivo de configuración */etc/salt/master* de la siguiente manera:

![](./24.JPG)

- Una vez hecho ejecutamos **systemctl enable salt-master.service** para que el servicio se active al iniciar el sistema y **systemctl start salt-master.service** para arrancarlo. Por último comprobamos con **salt-key -L** los clientes (*minions*) conectados.

![](./5.JPG)

## Minion

- Ahora configuaremos el servcio en nuestro minion.
Ejecutamos **zypper install salt-minion** para instalarlo.

![](./26.JPG)

- Tendremos que modificar el archivo de configuración para indicar quien será nuestro master.

![](./27.JPG)

- ahora ejecutamos los comandos para activar el servicio.

![](./8.JPG)

- y comprobamos que no tenemos *apache* instalado.

![](./9.JPG)

### Cortafuegos

- Volvemos a la máquina *master* para definir algunas reglas en el cortafuegos.
Ejecutaremos **firewall-cmd --get-active-zones** para comprobar la zona de nuestra red, **firewall-cmd --zone=public --add-port=4505-4506/tcp --permanent** para abrir los puertos 4505 4506 de forma permanente en la zona pública, **firewall-cmd --reload** para recargar el cortafuegos y **firewall-cmd --zone=public --list-all** para comprobar que los cambios han surtido efecto.

![](./29.JPG)

### Aceptación desde el Master

- Si volvemos a jecutar **salt-key -L** veremos que tenemos una solicitud de nuestro minion.

![](./30.JPG)

- Lo aceptamos con **salt-key -a minion07g** y comprobamos.

![](./31.JPG)

### Comprobamos conectividad

- Con los siguientes comandos comprobamos si hay conectividad entre ambas máquinas y la version de salt instalada en el minion.

![](./32.JPG)

## Salt States

### Preparar el directorio para los estados

- Vamos a crear directorios para guardar lo estados de Salt. Los estados de Salt son definiciones de cómo queremos que estén nuestras máquinas.
Para ello crearemos el archivo **/etc/salt/master.d/roots.conf** con el siguiente contenido y reiniciamos el servicio.

![](./33.JPG)

### Crear un nuevo estado

- Vamos a crear un nuevo estado que instale apache en nuestros minions. Para ello crearemos el siguiente archivo **/srv/salt/base/apache/init.sls** con la siguiente configuración:

![](./34.JPG)

### Asociar Minions a estados

- Para vincular los minions con los estados craremos el archivo top.sls con la siguiente configuración:

![](./35.JPG)

### Comprobar estados definidos

- Podemos comprobar el vinculo con el siguiente comando:

![](./36.JPG)

### Aplicar el nuevo estado

- Para comprobar en detalle los estados usaremos los siguientes comandos:

![](./37.JPG)

![](./38.JPG)

- Si todo está correcto ejecutamos el **salt '*' state.apply apache** para aplicar el estado:

![](./39.JPG)

## Crear más estados

### Estado Users

- Vamos a crear un grupo con varios usuarios del mismo mediante estados.    
Para ello empezaremos modificando el archivo top.sls para incluir el nuevo estado.

![](./41.JPG)

- Ahora crearemos el archivo **/srv/salt/base/users/init.sls** con la siguiente configuración:

![](./50.JPG)

- Por último aplicamos el estado con **salt '*' state.apply users**.

![](./51.JPG)

### Estado Dirs

- Vamos a crear algunos directorios dentro del home de nuestro usuario koji07.    
Comenzamos modificando el archivo top.sls para incluir el nuevo estado.

![](./52.JPG)

- Ahora crearemos el archivo **/srv/salt/base/dirs/init.sls** con la siguiente configuración:

![](./53.JPG)

- Por último aplicamos el estado.

![](./54.JPG)
